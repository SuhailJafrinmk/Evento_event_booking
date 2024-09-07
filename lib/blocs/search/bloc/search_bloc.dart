import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/repositories/events_repo.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<EventModel> _allItems = [];
  late String nextPageUrl;
  String currentQuery='';

  SearchBloc() : super(ItemLoadingState()) {
    on<FetchAllItemsEvent>(fetchAllItemsEvent);
    on<FilterItemsEvent>(filterItemsEvent);
    on<FetchMoreItemsEvents>(fetchMoreItemsEvents);
  }

  FutureOr<void> fetchAllItemsEvent(
      FetchAllItemsEvent event, Emitter<SearchState> emit) async {
    logInfo('the event handler is in fetchallitems');
    emit(ItemLoadingState());
    final rawData = await EventsRepo.getAllEvents();
    rawData
        .fold((left) => emit(ItemErrorState(errorMessage: left.errorMessage)),
            (right) {
      nextPageUrl = right.data['next'];
      logInfo('next page url is stored in bloc $nextPageUrl');
      final data = right.data['results'] as List<dynamic>;
      _allItems.addAll(data
          .map((item) => EventModel.fromJson(item as Map<String, dynamic>))
          .toList());
      emit(ItemLoadedState(allItems: _allItems, filteredItems: _allItems));
    });
  }

  void filterItemsEvent(FilterItemsEvent event, Emitter<SearchState> emit) {
    logInfo('filter function in bloc is working...');
    currentQuery=event.query;
    final List<EventModel> filteredEvents = _allItems
        .where((item) =>
            item.event_name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(ItemLoadedState(allItems: _allItems, filteredItems: filteredEvents));
    logInfo('the state emitted is itemloadedstate');
  }

  FutureOr<void> fetchMoreItemsEvents(
      FetchMoreItemsEvents event, Emitter<SearchState> emit) async {
    final rawdata = await EventsRepo.getMoreEvents(nextPageUrl);
    rawdata.fold((left) {
      emit(ItemErrorState(errorMessage: left.errorMessage));
    }, (right) {
      logInfo('it success...');
      final requiredData=right.data['results'] as List<dynamic>;
      final List<EventModel> events=requiredData.map((item) => EventModel.fromJson(item as Map<String,dynamic>)).toList();
      _allItems.addAll(events);
      nextPageUrl = right.data['next'];
         final currentState = state;
    List<EventModel> filteredItems = _allItems;
          // If there's a query, apply the same filter on the updated list
      List<EventModel> _filteredItems = _allItems;
      if (currentQuery != null && currentQuery!.isNotEmpty) {
        filteredItems = _allItems
            .where((item) => item.event_name
                .toLowerCase()
                .contains(currentQuery!.toLowerCase()))
            .toList();
      }
      emit(ItemLoadedState(allItems: _allItems, filteredItems: filteredItems));
    });
  }
}
