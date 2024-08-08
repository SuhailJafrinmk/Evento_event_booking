import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  SharedPref._();
  static final _instance=SharedPref._();
  static SharedPref get instance=>_instance;
  static const String token='token';
  static const String refreshToken='refreshToken';
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
}