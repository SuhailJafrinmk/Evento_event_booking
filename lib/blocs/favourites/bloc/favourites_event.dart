part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}
class AddToFavouritesEvent extends FavouritesEvent{
  final EventModel eventModel;
  AddToFavouritesEvent({required this.eventModel});
}
class GetAllFavouriteEvents extends FavouritesEvent{}
class DeleteFavouriteEvent extends FavouritesEvent{
  final EventModel eventModel;
  DeleteFavouriteEvent({required this.eventModel});
}