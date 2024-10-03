import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/event_model.dart';
import 'package:evento_event_booking/repositories/favourites_repo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rive/rive.dart'; // Import hive_flutter for Flutter support


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

    // Open the box for EventModel objects
    await Hive.openBox<EventModel>('eventsBox');
  }

  // Close Hive when not in use
  Future<void> closeHive() async {
    await Hive.close();
  }


  Future<void> storeFavouritesFromBackend()async{
    logInfo('the function is getting favourites from backend and storing to hive');
    final response=await FavouritesRepo.getAllFavourites();
    response.fold((left){
    }, (right)async{
      final rawData=right.data as List<dynamic>;
      final List<EventModel> favoriteEvent=rawData.map((item){
       return EventModel.fromJson(item['event']);
      }).toList();
      var box=Hive.box<EventModel>('eventsBox');
      if(box.isNotEmpty){
        box.clear();
      }else{
        await box.addAll(favoriteEvent);
      }
    });
  }
  List<EventModel> getFavourites(){
  logInfo('getting events from hive box');
  var box=Hive.box<EventModel>('eventsBox');
  List<EventModel> FavouriteEvents=box.values.toList();
  logInfo('events from hive is ${FavouriteEvents}');
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
  }else{
    logInfo('no event found');
  }
}

}
