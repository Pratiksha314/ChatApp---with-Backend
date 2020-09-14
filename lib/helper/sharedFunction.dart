import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions{
//sharedPreference User LoggedIn Key 
static String sharedkey = "ISLOGGEDIN";
//sharedPreference User Name Key
static String  namekey = "USERNAMEKEY";
//sharedPreference User Email Key
static String  emailkey = "USEREMAILKEY";

// saving data to shared preference
// static se we can use this function anywhere 
static Future <bool> saveUserLoggedInSP( bool isuserLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.setBool(sharedkey, isuserLoggedIn);
}
static Future <bool> saveUserNameSP( String userName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.setString(namekey, userName);
}

static Future <bool> saveUserEmailSP(String userEmail) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString(emailkey, userEmail);
}


//getting data from shared preference
static Future<bool> getUserLoggedInSP() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getBool(sharedkey);
}

static Future<String> getUserNameSP() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(namekey);
}

static Future<String> getUserEmailSP() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString(emailkey);
}

}