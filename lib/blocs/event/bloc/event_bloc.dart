import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
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
    eventsAtLocation: []
  )) {
    on<FetchEventLocations>(fetchEventLocations);
    on<FetchEventCategories>(fetchEventCategories);
    on<FetchTrendingEvents>(fetchTrendingEvents);
    on<FetchAllEvents>(fetchAllEvents);
    on<FetchEventByLocation>(fetchEventByLocation);
    on<FetchEventDetails>(fetchEventDetails);
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
        final data=right.data as List<dynamic>;
        List<EventLocations> eventLocation=data.map((e) => EventLocations.fromMap(e as Map<String,dynamic>)).toList();
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          eventLocations: eventLocation,
        ));
      },
    );
  }

  FutureOr<void> fetchEventCategories(FetchEventCategories event, Emitter<EventState> emit) async {
    emit((state as EventStateLoaded).copyWith(isLoading: true));
    final response = await EventsRepo.getEventCategories();
    response.fold(
      (left) {
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          errorMessage: left.errorMessage,
        ));
      },
      (right) {
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
        final data=right.data['results'] as List<dynamic>;
        List<EventModel> events = data.map((e) => EventModel.fromJson(e as Map<String,dynamic>),).toList();
        emit((state as EventStateLoaded).copyWith(
          isLoading: false,
          allEvents: events,
        ));
      },
    );
  }

  FutureOr<void> fetchEventByLocation(FetchEventByLocation event, Emitter<EventState> emit)async{
    EventLocations? locations=SharedPref.instance.getUserLocation();
    final response=await EventsRepo.getEventsByLocation(locations!.id);
    response.fold((left){
      
    }, (right){
      final data=right.data as List<dynamic>;
      List<EventModel> eventsAtLocation=data.map((item) =>EventModel.fromJson(item as Map<String,dynamic>) ).toList();
      emit((state as EventStateLoaded).copyWith(
        isLoading: false,
        eventsAtLocation: eventsAtLocation
      ));
    });
  }

  FutureOr<void> fetchEventDetails(FetchEventDetails event, Emitter<EventState> emit)async{
    logInfo('in the bloc function for getting event details..............');
    final response=await EventsRepo.getEventDetails(event.eventId);
    response.fold((left) => emit(ErrorFetchingEventDetails(errorMessage: left.errorMessage)),
     (right) {
      final data=right.data as Map<String,dynamic>;
      EventModel eventModel=EventModel.fromJson(data);
      emit(EventDetailsLoaded(eventModel: eventModel));
     });
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
