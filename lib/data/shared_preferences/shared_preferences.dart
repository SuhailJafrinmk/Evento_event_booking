import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:evento_event_booking/models/location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  SharedPref._();
  static final _instance=SharedPref._();
  static SharedPref get instance=>_instance;
  static const String token='token';
  static const String refreshToken='refreshToken';
  static const String userLocation='userLocation';
  static const String userLocationId='Locationid';
  static const String userName='userName';

  late SharedPreferences sharedPref;
  void initSharedPreferences()async{
    sharedPref=await SharedPreferences.getInstance();
  }
  void storeTokens(String userToken,String userRefreshToken)async{
    await sharedPref.setString(token, userToken);
    await sharedPref.setString(refreshToken,userRefreshToken);
  }
  void removeToken()async{
    await sharedPref.remove(token);
    await sharedPref.remove(refreshToken);
  }
  String ? getToken(){
    return sharedPref.getString(token);
  }
  void storeRefreshToken(String refresh)async{
    await sharedPref.setString(refreshToken, refresh);
  }
  String ? getRefreshToken(){
    return sharedPref.getString(refreshToken);
  }
  void storeUserName(String user)async{
    await sharedPref.setString(userName, user);
  }
  String ? getUserName(){
    return sharedPref.getString(userName);
  }
  void storeUserLocation(EventLocations? locations)async{
   if(locations!=null){
     await sharedPref.setString(userLocation,locations.name);
     await sharedPref.setInt(userLocationId, locations.id); 
   }
   logInfo('user location stored in shored prefrences');
  }
  EventLocations ? getUserLocation(){
    String ? place=sharedPref.getString(userLocation);
    int ? locationId=sharedPref.getInt(userLocationId);
    if(locationId!=null &&place!=null){
      return EventLocations(id: locationId, name: place);
    }
    return null;
  }
}