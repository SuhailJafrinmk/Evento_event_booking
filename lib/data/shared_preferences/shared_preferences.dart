import 'package:evento_event_booking/development_only/custom_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  SharedPref._();
  static final _instance=SharedPref._();
  static SharedPref get instance=>_instance;
  static const String token='token';
  static const String refreshToken='refreshToken';
  static const String userLocation='userLocation';
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
  void storeUserLocation(String ? userPickedLocation)async{
   if(userPickedLocation!=null){
     await sharedPref.setString(userLocation,userPickedLocation); 
   }
   logInfo('user location stored in shored prefrences');
  }
  String ? getUserLocation(){
    String ? place=sharedPref.getString(userLocation);
    if(place!=null){
      return place;
    }
    return null;
  }
}