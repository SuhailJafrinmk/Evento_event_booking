// part of 'search_bloc.dart';

// @immutable
// sealed class SearchEvent {}
// class FetchAllItemsEvent extends SearchEvent{}
// class FilterItemsEvent extends SearchEvent{
//   final String query;
//   FilterItemsEvent({required this.query});
// }
// class FetchMoreItemsEvents extends SearchEvent{}
part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class FetchAllItemsEvent extends SearchEvent {}

class FilterItemsEvent extends SearchEvent {
  final String query;
  final String sortType;
  FilterItemsEvent({required this.query,required this.sortType});
}

class SortItemsEvent extends SearchEvent {
  final String sortType;
  SortItemsEvent({required this.sortType});
}

class FetchMoreItemsEvents extends SearchEvent {}
