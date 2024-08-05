import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  SharedPref._();
  static final _instance=SharedPref._();
  static SharedPref get instance=>_instance;
  static const String token='token';
  late SharedPreferences sharedPref;
  void initSharedPreferences()async{
    sharedPref=await SharedPreferences.getInstance();
  }
  void storeToken(String userToken)async{
    await sharedPref.setString(token, userToken);
  }
  void removeToken()async{
    await sharedPref.remove(token);
  }
  String ? getToken(){
    return sharedPref.getString(token);
  }
}