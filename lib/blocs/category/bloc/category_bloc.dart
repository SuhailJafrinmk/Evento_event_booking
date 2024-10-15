import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/models/category_model.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/repositories/events_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<GetEventsByCategory>(getEventsByCategory);
  }

  FutureOr<void> getEventsByCategory(GetEventsByCategory event, Emitter<CategoryState> emit)async{
    emit(CategoryEventsLoading());
    final response=await EventsRepo.getEventByCategory(event.categoryModel.name);
    response.fold(
      (error){
        emit(FailedFetchingCategoryEvents(errorMessage: error.errorMessage));
      },
     (success){
      final rawData=success.data as Map<String,dynamic>;
      final data=rawData['results'] as List<dynamic>;
      List<EventModel> events=data.map((e) => EventModel.fromJson(e as Map<String,dynamic>),).toList();
      emit(CategoryEventsFetched(events:events,categoryModel: event.categoryModel));
      debugPrint('emitting state category events fethced');
     });
  }
}
