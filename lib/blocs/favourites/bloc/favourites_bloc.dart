import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:evento_event_booking/data/hive/hive_helper.dart';
import 'package:evento_event_booking/data/shared_preferences/shared_preferences.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/repositories/favourites_repo.dart';
import 'package:hive/hive.dart';
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
    await HiveHelper().addToFavourite(event.eventModel);
    final response=await FavouritesRepo.addToFavourites(event.eventModel.id);
    response.fold((left){
      emit(ErrorAddingToFavourites());
    }, (right){
      emit(AddToFavouritesSuccess());
    });
  }

  FutureOr<void> getAllFavouriteEvents(GetAllFavouriteEvents event, Emitter<FavouritesState> emit)async{
    final response=HiveHelper().getFavourites();
    emit(GetAllFavouritesSuccess(favouriteEvents: response));
  }

  FutureOr<void> deleteFavouriteEvent(DeleteFavouriteEvent event, Emitter<FavouritesState> emit)async{
    await HiveHelper().removeFavourite(event.eventModel);
    final response=await FavouritesRepo.deleteFromFavourites(event.eventModel.id);
    response.fold((left){
      emit(ErrorDeletingFromFavourites());
    }, (right){
      emit(DeleteFromFavouritesSuccess());
    });
  }
}
