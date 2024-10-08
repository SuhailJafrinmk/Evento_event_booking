part of 'share_bloc.dart';

@immutable
sealed class ShareEvent {}
class ShareAnEvent extends ShareEvent{
  final EventModel eventModel;
  ShareAnEvent({required this.eventModel});
}
