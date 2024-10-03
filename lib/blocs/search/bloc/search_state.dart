// part of 'search_bloc.dart';

// @immutable
// sealed class SearchState {}
// class ItemLoadingState extends SearchState{}
// class ItemLoadedState extends SearchState{
//   final List<EventModel> allItems;
//   final List<EventModel> filteredItems;
//   ItemLoadedState({required this.allItems, required this.filteredItems});
// }
// class ItemErrorState extends SearchState{
//   final String errorMessage;
//   ItemErrorState({required this.errorMessage});
// }


import 'package:evento_event_booking/models/event_model.dart';

abstract class SearchState {}

class ItemLoadingState extends SearchState {}

class ItemErrorState extends SearchState {
  final String errorMessage;

  ItemErrorState({required this.errorMessage});
}

class ItemLoadedState extends SearchState {
  final List<EventModel> allItems;
  final List<EventModel> filteredItems;
  final String? nextPageUrl;
  final String currentQuery;
  final bool hasMoreItems;

  ItemLoadedState({
    required this.allItems,
    required this.filteredItems,
    this.nextPageUrl,
    this.currentQuery = '',
    this.hasMoreItems=true,
  });

  // A copyWith method to help update the state without overwriting existing values
  ItemLoadedState copyWith({
    List<EventModel>? allItems,
    List<EventModel>? filteredItems,
    String? nextPageUrl,
    String? currentQuery,
    bool ? hasMoreItems,
  }) {
    return ItemLoadedState(
      allItems: allItems ?? this.allItems,
      filteredItems: filteredItems ?? this.filteredItems,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      currentQuery: currentQuery ?? this.currentQuery,
      hasMoreItems: hasMoreItems ?? this.hasMoreItems,
    );
  }
}
