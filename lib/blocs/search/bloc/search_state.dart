part of 'search_bloc.dart';

@immutable
sealed class SearchState {}
class ItemLoadingState extends SearchState{}
class ItemLoadedState extends SearchState{
  final List<EventModel> allItems;
  final List<EventModel> filteredItems;
  ItemLoadedState({required this.allItems, required this.filteredItems});
}
class ItemErrorState extends SearchState{
  final String errorMessage;
  ItemErrorState({required this.errorMessage});
}


