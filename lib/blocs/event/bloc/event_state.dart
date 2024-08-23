part of 'event_bloc.dart';

@immutable
sealed class EventState {}

// final class EventInitial extends EventState {}
// class FetchingEventLocations extends EventState{}
// class FetchedEventLocations extends EventState{
//   final List<String> userlocaions;
//   FetchedEventLocations({required this.userlocaions});
// }
// class ErrorFetchingEventLocations extends EventState{
//   final String message;
//   ErrorFetchingEventLocations({required this.message});
// }
// class FetchingEventCategories extends EventState{}
// class FetchedEventCategories extends EventState{}
// class ErrorFetchingCategories extends EventState{
//   final String message;
//   ErrorFetchingCategories({required this.message});
// }

// class FetchingTrendingEvents extends EventState{}
// class FetchedTrendingEvents extends EventState{}
// class ErrorFetchingTrendingEvents extends EventState{} 

// class FetchingAllEvents extends EventState{}
// class FetchedAllEvents extends EventState{}
// class ErrorFetchingAllEvents extends EventState{}
class EventStateLoaded extends EventState {
  final List<String> eventLocations;
  final List<CategoryModel> eventCategories;
  final List<EventModel> trendingEvents;
  final List<EventModel> allEvents;
  final bool isLoading;
  final String? errorMessage;

  EventStateLoaded({
    required this.eventLocations,
    required this.eventCategories,
    required this.trendingEvents,
    required this.allEvents,
    this.isLoading = false,
    this.errorMessage,
  });

  EventStateLoaded copyWith({
    List<String>? eventLocations,
    List<CategoryModel>? eventCategories,
    List<EventModel>? trendingEvents,
    List<EventModel>? allEvents,
    bool? isLoading,
    String? errorMessage,
  }) {
    return EventStateLoaded(
      eventLocations: eventLocations ?? this.eventLocations,
      eventCategories: eventCategories ?? this.eventCategories,
      trendingEvents: trendingEvents ?? this.trendingEvents,
      allEvents: allEvents ?? this.allEvents,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}