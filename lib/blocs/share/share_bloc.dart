import 'package:evento_event_booking/models/event_model.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'share_event.dart';


class ShareBloc extends Bloc<ShareEvent, void> {
  ShareBloc() : super(null) {
    on<ShareAnEvent>(shareAnEvent);
  }

  FutureOr<void> shareAnEvent(ShareAnEvent event, Emitter<void> emit)async{
    String eventLink='https://evento.ink/event-details/${event.eventModel.id}';
      String shareText = '''
        Check out this amazing event: ${event.eventModel.event_name} happening on ${event.eventModel.end_date}. Don't miss it!
        Click here for more details and to book your tickets: $eventLink
        ''';
    try {
      await Share.share(
        shareText
      );
    } catch (e) {
      developer.log('some error occured');
    }
  }
}
