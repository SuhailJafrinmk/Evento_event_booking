part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

final class FavouritesInitial extends FavouritesState {}
class AddToFavouritesSuccess extends FavouritesState{}
class DeleteFromFavouritesSuccess extends FavouritesState{}
class GetAllFavouritesSuccess extends FavouritesState{
  final List<EventModel> favouriteEvents;
  GetAllFavouritesSuccess({required this.favouriteEvents});
}
class ErrorAddingToFavourites extends FavouritesState{}
class ErrorDeletingFromFavourites extends FavouritesState{}
class ErrorGettingAllFavourites extends FavouritesState{}