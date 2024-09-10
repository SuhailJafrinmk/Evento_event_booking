import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/repositories/favourites_repo.dart';
import 'package:meta/meta.dart';
part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
  on<AddToFavouritesEvent>(addToFavouritesEvent);
  on<GetAllFavouriteEvents>(getAllFavouriteEvents);
  on<DeleteFavouriteEvent>(deleteFavouriteEvent);
  }

  FutureOr<void> addToFavouritesEvent(AddToFavouritesEvent event, Emitter<FavouritesState> emit)async{
    final response=await FavouritesRepo.addToFavourites(event.eventId);
    response.fold((left){
      emit(ErrorAddingToFavourites());
    }, (right){
      emit(AddToFavouritesSuccess());
    });
  }

  FutureOr<void> getAllFavouriteEvents(GetAllFavouriteEvents event, Emitter<FavouritesState> emit)async{
    final response=await FavouritesRepo.getAllFavourites();
    response.fold((left){
      emit(ErrorGettingAllFavourites());
    }, (right){
      final rawData=right.data as List<dynamic>;
      final List<EventModel> favoriteEvent=rawData.map((item){
       return EventModel.fromJson(item['event']);
      }).toList();
      logInfo('the first item in favourite events is ${favoriteEvent.first.event_name}');
      emit(GetAllFavouritesSuccess(favouriteEvents: favoriteEvent));
    });
  }

  FutureOr<void> deleteFavouriteEvent(DeleteFavouriteEvent event, Emitter<FavouritesState> emit)async{
    final response=await FavouritesRepo.deleteFromFavourites(event.eventId);
    response.fold((left){
      emit(ErrorDeletingFromFavourites());
    }, (right){
      emit(DeleteFromFavouritesSuccess());
    });
  }
}
