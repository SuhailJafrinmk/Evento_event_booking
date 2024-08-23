part of 'event_bloc.dart';

@immutable
sealed class EventEvent {}
class FetchEventLocations extends EventEvent{}
class FetchEventCategories extends EventEvent{}
class FetchTrendingEvents extends EventEvent{}
class FetchAllEvents extends EventEvent{}