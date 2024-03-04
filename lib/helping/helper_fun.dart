import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //helping function helps to get the
  ///key
  static String userLoggedINKey = "LOGGEDINKEY";
  static String userNameINKey = "USERNAMEKEY";
  static String userEmailINKey = "USEREMAILKEY";

  // saving the date to shared preferences

  static Future<bool?> saveUSerLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedINKey, isUserLoggedIn);
  }

  static Future<bool?> saveUSerNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameINKey, userName);
  }

  static Future<bool?> saveUSerEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailINKey, userEmail);
  }

  //getting data from shared preferences

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedINKey);
  }

  static Future<String?> getUserEmailfromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailINKey);
  }

  static Future<String?> getUserNamefromSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameINKey);
  }
}
