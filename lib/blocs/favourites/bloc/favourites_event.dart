part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}
class AddToFavouritesEvent extends FavouritesEvent{
  final int eventId;
  AddToFavouritesEvent({required this.eventId});
}
class GetAllFavouriteEvents extends FavouritesEvent{}
class DeleteFavouriteEvent extends FavouritesEvent{
  final int eventId;
  DeleteFavouriteEvent({required this.eventId});
}