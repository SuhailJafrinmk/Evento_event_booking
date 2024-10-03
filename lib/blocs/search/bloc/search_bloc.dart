// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:evento_event_booking/development_only/custom_logger.dart';
// import 'package:evento_event_booking/models/event_model.dart';
// import 'package:evento_event_booking/repositories/events_repo.dart';
// import 'package:meta/meta.dart';
// part 'search_event.dart';
// part 'search_state.dart';

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   List<EventModel> _allItems = [];
//   late String nextPageUrl;
//   String currentQuery='';

//   SearchBloc() : super(ItemLoadingState()) {
//     on<FetchAllItemsEvent>(fetchAllItemsEvent);
//     on<FilterItemsEvent>(filterItemsEvent);
//     on<FetchMoreItemsEvents>(fetchMoreItemsEvents);
//   }

//   //this function event is meant to fetch all the events from the backend and refresh the ui
//   FutureOr<void> fetchAllItemsEvent(
//     FetchAllItemsEvent event, Emitter<SearchState> emit) async {
//     logInfo('the event handler is in fetchallitems');
//     _allItems.clear();
//     emit(ItemLoadingState());
//     final rawData = await EventsRepo.getAllEvents();
//     rawData
//     .fold((left) => emit(ItemErrorState(errorMessage: left.errorMessage)),
//             (right) {
//       nextPageUrl = right.data['next'];
//       logInfo('next page url is stored in bloc $nextPageUrl');
//       final data = right.data['results'] as List<dynamic>;
//       _allItems.addAll(data
//           .map((item) => EventModel.fromJson(item as Map<String, dynamic>))
//           .toList());
//       emit(ItemLoadedState(allItems: _allItems, filteredItems: _allItems));
//     });
//   }


//   //this function filters out the event from the search field and updates the ui
//   void filterItemsEvent(FilterItemsEvent event, Emitter<SearchState> emit) {
//     logInfo('filter function in bloc is working...');
//     currentQuery=event.query;
//     final List<EventModel> filteredEvents = _allItems
//         .where((item) =>
//             item.event_name.toLowerCase().contains(event.query.toLowerCase()))
//         .toList();

//     emit(ItemLoadedState(allItems: _allItems, filteredItems: filteredEvents));
//     logInfo('the state emitted is itemloadedstate');
//   }

//   //this function is called when the scroll reaches the max of the vertical listview
//   //this function fetches more events from the backend by sending the [nextpageurl] parameter to the backend
//   //updates the ui with more events
//   FutureOr<void> fetchMoreItemsEvents(
//       FetchMoreItemsEvents event, Emitter<SearchState> emit) async {
//     final rawdata = await EventsRepo.getMoreEvents(nextPageUrl);
//     rawdata.fold((left) {
//       emit(ItemErrorState(errorMessage: left.errorMessage));
//     }, (right) {
//       logInfo('it success...');
//       final requiredData=right.data['results'] as List<dynamic>;
//       final List<EventModel> events=requiredData.map((item) => EventModel.fromJson(item as Map<String,dynamic>)).toList();
//       _allItems.addAll(events);
//       nextPageUrl = right.data['next'];
//          final currentState = state;
//     List<EventModel> filteredItems = _allItems;
//           // If there's a query, apply the same filter on the updated list
//       List<EventModel> _filteredItems = _allItems;
//       if (currentQuery != null && currentQuery!.isNotEmpty) {
//         filteredItems = _allItems
//             .where((item) => item.event_name
//                 .toLowerCase()
//                 .contains(currentQuery!.toLowerCase()))
//             .toList();
//       }
//       emit(ItemLoadedState(allItems: _allItems, filteredItems: filteredItems));
//     });
//   }
// }



import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/blocs/search/bloc/search_state.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/repositories/events_repo.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(ItemLoadingState()) {
    on<FetchAllItemsEvent>(fetchAllItemsEvent);
    on<FilterItemsEvent>(filterItemsEvent);
    on<FetchMoreItemsEvents>(fetchMoreItemsEvents);
  }

  Future<void> fetchAllItemsEvent(
      FetchAllItemsEvent event, Emitter<SearchState> emit) async {
    logInfo('Fetching all items...');
    emit(ItemLoadingState());
    final rawData = await EventsRepo.getAllEvents();
    rawData.fold(
      (failure) => emit(ItemErrorState(errorMessage: failure.errorMessage)),
      (success) {
        final List<EventModel> allItems = (success.data['results'] as List)
            .map((item) => EventModel.fromJson(item as Map<String, dynamic>))
            .toList();
        final String ? nextPageUrl = success.data['next'];
        emit(ItemLoadedState(
          allItems: allItems,
          filteredItems: allItems,
          nextPageUrl: nextPageUrl,
        ));
      },
    );
  }

  // Filter items based on query
  void filterItemsEvent(FilterItemsEvent event, Emitter<SearchState> emit) {
    logInfo('Filtering items...');
    final currentState = state;
    if (currentState is ItemLoadedState) {
      final List<EventModel> filteredItems = currentState.allItems
          .where((item) => item.event_name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(currentState.copyWith(
        filteredItems: filteredItems,
        currentQuery: event.query,
      ));
    }
  }

  Future<void> fetchMoreItemsEvents(
      FetchMoreItemsEvents event, Emitter<SearchState> emit) async {
    logInfo('Fetching more items...');
    final currentState =state;
    if (currentState is ItemLoadedState) {
      if (currentState.hasMoreItems==false) {
        return;
      }
      final rawData = await EventsRepo.getMoreEvents(currentState.nextPageUrl!);
      rawData.fold(
        (failure) => emit(ItemErrorState(errorMessage: failure.errorMessage)),
        (success) {
          final List<EventModel> newItems = (success.data['results'] as List)
              .map((item) => EventModel.fromJson(item as Map<String, dynamic>))
              .toList();
          
          final String? nextPageUrlLatest = success.data['next'];
          // logError('the next page url is  log error$nextPageUrl');
          final List<EventModel> updatedAllItems = List.from(currentState.allItems)..addAll(newItems);
          
          // If a search query exists, apply the filter to the new list
          List<EventModel> filteredItems = updatedAllItems;
          if (currentState.currentQuery.isNotEmpty) {
            filteredItems = updatedAllItems
                .where((item) => item.event_name.toLowerCase().contains(currentState.currentQuery.toLowerCase()))
                .toList();
          }

          // Emit the updated state with the new items and updated nextPageUrl
          emit(currentState.copyWith(
            allItems: updatedAllItems,
            filteredItems: filteredItems,
            nextPageUrl: nextPageUrlLatest,
            hasMoreItems: nextPageUrlLatest==null ? false : true,
          ));
        },
      );
    }
  }
}
