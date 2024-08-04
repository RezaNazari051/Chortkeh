import 'package:shared_preferences/shared_preferences.dart';

class PrefsOperator {
  PrefsOperator(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<void> setBoolPrefs(String key, bool? value) async {
    await sharedPreferences.setBool(key, value!);
  }

  bool getBoolPrefs(String key)  {
    return sharedPreferences.getBool(key) ?? false;
  }



    Future<void> setFirstTime(String key, bool? value) async {
    await sharedPreferences.setBool(key, value!);
  }


  bool getFirstTime(String key)  {
    return sharedPreferences.getBool(key) ?? true;
  }



}
