import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SharedPrefService {

  static SharedPrefService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPrefService> getInstance()async{
    _instance ??= SharedPrefService();
    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  /// Function that handles getting all types
  dynamic getFromSharedPref(String key){
    var value = _preferences!.get(key);
    debugPrint('LocalStorageService:_getFromDisk. key: $key value: $value type: ${value.runtimeType}');
    return value;
  }

  /// Function  that handles setting all types
  void saveToSharedPref<T>(String key, T content){
    debugPrint('LocalStorageService:_saveToDisk. key: $key value: $content type: ${content.runtimeType}');

    if(content is String) {
      _preferences!.setString(key, content);
    }
    if(content is bool) {
      _preferences!.setBool(key, content);
    }
    if(content is int) {
      _preferences!.setInt(key, content);
    }
    if(content is double) {
      _preferences!.setDouble(key, content);
    }
    if(content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

  /// Function to specifically get List<String> from shared preferences
  List<String>? getStringListFromSharedPref(String key) {
    var value = _preferences!.getStringList(key);
    debugPrint('LocalStorageService:_getFromDisk. key: $key value: $value type: ${value.runtimeType}');
    return value;
  }

  ///clearing all data from shared pref
  void clearData(){
    debugPrint('LocalStorageService: Cleared Data');
    _preferences!.clear();
  }

  Future<void> clearSharedPreferencesExcept() async {
    debugPrint('LocalStorageService: Cleared Data except Login Preference');
    Set<String> keys = _preferences!.getKeys();
    List<String> keysToKeep = [
      //TODO: ADD keys you'd like not to clear from memory
    ];

    // Iterate through the keys and remove each one except the key you want to keep
    for (String key in keys) {
      if (!keysToKeep.contains(key)) {
        await _preferences!.remove(key);
      }
    }
  }

}