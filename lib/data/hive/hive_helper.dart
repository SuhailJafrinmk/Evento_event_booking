import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/models/ticket_model.dart';
import 'package:evento_event_booking/repositories/favourites_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';



class HiveHelper {
  static final HiveHelper _instance = HiveHelper._internal();

  factory HiveHelper() {
    return _instance;
  }

  HiveHelper._internal();

  // Initialize Hive and register adapters
  Future<void> initHive() async {
    await Hive.initFlutter(); // Use hive_flutter for platform-specific initialization

    // Register adapters
    Hive.registerAdapter(EventModelAdapter());
    Hive.registerAdapter(TicketTypeAdapter());

    // Open the box for EventModel objects
    await Hive.openBox<EventModel>('eventsBox');
  }

  // Close Hive when not in use
  Future<void> closeHive() async {
    await Hive.close();
  }


Future<void> storeFavouritesFromBackend() async {
  logInfo('The function is getting favourites from backend and storing to hive');
  try {
    final response = await FavouritesRepo.getAllFavourites();
    response.fold(
      (left) {
        logError('Failed to fetch favourites from backend');
      },
      (right) async {
        final rawData = right.data as List<dynamic>?;  // Added null check
        if (rawData != null) {
          final List<EventModel> favoriteEvent = rawData.map((item) {
            return EventModel.fromJson(item['event']);
          }).toList();
          var box = await Hive.openBox<EventModel>('eventsBox');
          await box.clear();  // Clear the box regardless of whether it's empty or not
          await box.addAll(favoriteEvent);
        } else {
          logError('The data received from the backend is null or in an unexpected format');
        }
      },
    );
  } catch (e) {
    logError('An error occurred with Hive: ${e.toString()}');
  }
}

  List<EventModel> getFavourites(){
  var box=Hive.box<EventModel>('eventsBox');
  List<EventModel> FavouriteEvents=box.values.toList();
  return FavouriteEvents;
}

Future<void> addToFavourite(EventModel eventModel)async{
  var box=Hive.box<EventModel>('eventsBox');
  await box.add(eventModel);
}

Future<void> removeFavourite(EventModel eventModel)async{
  var box=Hive.box<EventModel>('eventsBox');
  final keyToDelete=box.keys.firstWhere((key){
    final storedEvent=box.get(key);
    return storedEvent?.id == eventModel.id;
  },
  orElse: () => null,
  );
  if(keyToDelete!=null){
    await box.delete(keyToDelete);
    logInfo('favourite deleted from hive');
  }else{
    logInfo('no event found');
  }
}

// Future<void>

}
