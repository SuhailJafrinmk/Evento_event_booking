part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}
class FetchAllItemsEvent extends SearchEvent{}
class FilterItemsEvent extends SearchEvent{
  final String query;
  FilterItemsEvent({required this.query});
}
class FetchMoreItemsEvents extends SearchEvent{}
