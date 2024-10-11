import 'package:evento_event_booking/data/hive/hive_helper.dart';
import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';

class UtilityFunctions {
static bool isFavourite(EventModel eventModel) {
  List<EventModel> favourites = HiveHelper().getFavourites();
  return favourites.any((item) => item.id == eventModel.id);
}
}