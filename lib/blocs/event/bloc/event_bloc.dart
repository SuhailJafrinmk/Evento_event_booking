import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/models/location_model.dart';
import 'package:evento_event_booking/repositories/events_repo.dart';
import 'package:meta/meta.dart';
part 'event_event.dart';
part 'event_state.dart';

// event_bloc.dart

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventStateLoaded(
    eventLocations: [],
    eventCategories: [],
    trendingEvents: [],
    allEvents: [],
  )) {
    on<FetchEventLocations>(fetchEventLocations);
    on<FetchEventCategories>(fetchEventCategories);
    on<FetchTrendingEvents>(fetchTrendingEvents);
    on<FetchAllEvents>(fetchAllEvents);
  }

  FutureOr<void> fetchEventLocations(FetchEventLocations event, Emitter<EventState> emit) async {
    emit((state as EventStateLoaded).copyWith(isLoading: true));
    final response = await EventsRepo.getEventLocations();
    response.fold(
      (left) {
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          errorMessage: left.errorMessage,
        ));
      },
      (right) {
        List<String> locations = List<String>.from(right.data.map((e) => e['name'] as String));
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          eventLocations: locations,
        ));
      },
    );
  }

  FutureOr<void> fetchEventCategories(FetchEventCategories event, Emitter<EventState> emit) async {
    emit((state as EventStateLoaded).copyWith(isLoading: true));
    final response = await EventsRepo.getEventCategories();
    response.fold(
      (left) {
        logError('the error is ${left.errorMessage}');
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          errorMessage: left.errorMessage,
        ));
      },
      (right) {
        logError('the response of eventcategories is ${right.data}');
        final data=right.data as List<dynamic>;
        List<CategoryModel> categories =data.map((item) => CategoryModel.fromMap(item as Map<String,dynamic>)).toList();
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          eventCategories: categories,
        ));
      },
    );
  }

  FutureOr<void> fetchTrendingEvents(FetchTrendingEvents event, Emitter<EventState> emit) async {
    emit((state as EventStateLoaded).copyWith(isLoading: true));
    final response = await EventsRepo.getTrendingEvents();
    response.fold(
      (left) {
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          errorMessage: left.errorMessage,
        ));
      },
      (right) {
        final data=right.data as List<dynamic>;
        List<EventModel> events = data.map((item) => EventModel.fromJson(item as Map<String,dynamic>)).toList();
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          trendingEvents: events,
        ));
      },
    );
  }

  FutureOr<void> fetchAllEvents(FetchAllEvents event, Emitter<EventState> emit) async {
    emit((state as EventStateLoaded).copyWith(isLoading: true));
    final response = await EventsRepo.getAllEvents();
    response.fold(
      (left) {
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          errorMessage: left.errorMessage,
        ));
      },
      (right) {
        List<EventModel> events = (right.data as List).map((e) => EventModel.fromJson(e)).toList();
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          allEvents: events,
        ));
      },
    );
  }
}

// class EventBloc extends Bloc<EventEvent, EventState> {
//   List<String> eventLocations=[];
//   List<EventModel> allEvents=[];
//   EventBloc() : super(EventInitial()) {
//     on<FetchEventLocations>(fetchEventLocations);
//     on<FetchEventCategories>(fetchEventCategories);
//     on<FetchTrendingEvents>(fetchTrendingEvents);
//     on<FetchAllEvents>(fetchAllEvents);
//   }

//   FutureOr<void> fetchEventLocations(FetchEventLocations event, Emitter<EventState> emit) async {
//   emit(FetchingEventLocations());
//   final response = await EventsRepo.getEventLocations();
//   logInfo('The response of fetch locations is $response');
//   response.fold(
//     (left) {
//       emit(ErrorFetchingEventLocations(message: left.errorMessage));
//     },
//     (right) {
//       try {
//        List<dynamic> jsonData=right.data;
//        eventLocations.addAll(jsonData.map((e) {return e['name'] as String;},).toList());
//         emit(FetchedEventLocations(userlocaions: eventLocations));
//       } catch (e) {
//         logError(e.toString());
//         emit(ErrorFetchingEventLocations(message: 'Failed to parse event locations ${e.toString()}'));
//       }
//     },
//   );
//   }



//   FutureOr<void> fetchEventCategories(FetchEventCategories event, Emitter<EventState> emit)async{
//     logInfo('fetching event categories...');
//     emit(FetchingEventCategories());
//     final response=await EventsRepo.getEventCategories();
//     logInfo('the response of fetch categories is $response');
//     if(response.isLeft){
//       emit(ErrorFetchingCategories(message: response.left.errorMessage));
//     }else{
//       emit(FetchedEventCategories());
//     }
//   }

//   FutureOr<void> fetchTrendingEvents(FetchTrendingEvents event, Emitter<EventState> emit)async{
//     emit(FetchingTrendingEvents());
//     final response=await EventsRepo.getTrendingEvents();
//     response.fold((left) => emit(ErrorFetchingTrendingEvents()),
//      (right) => emit(FetchedTrendingEvents()));
//   }

//   FutureOr<void> fetchAllEvents(FetchAllEvents event, Emitter<EventState> emit)async{
//     emit(FetchingAllEvents());
//     final response=await EventsRepo.getAllEvents();
//     response.fold((left) => emit(ErrorFetchingAllEvents()), (right){
//       try {
//        List<dynamic> jsonData=right.data;
//        allEvents=jsonData.map((e) => EventModel.fromJson(e)).toList();
//        logError('the first event is ${allEvents[0].event_name}');
//         emit(FetchedEventLocations(userlocaions: eventLocations));
//       } catch (e) {
//         logError('failed to parse all events error:${e.toString()}');
//         emit(ErrorFetchingEventLocations(message: 'Failed to parse all events ${e.toString()}'));
//       }     
//       });
//   }
// }
