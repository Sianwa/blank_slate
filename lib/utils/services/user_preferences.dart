import '../Services/shared_pref_service.dart';
import '../constants.dart';
import '../service_locator.dart';

class UserPreferences {
  var sharedPref = locator<SharedPrefService>();

  //save video background preference
  Future<void> saveVideoPreference(bool shouldPlay) async {
    sharedPref.saveToSharedPref(playVideoBackground, shouldPlay);
  }

  //get video background preference
  bool getVideoPreference() {
    return sharedPref.getFromSharedPref(playVideoBackground) ?? true;
  }

  //save biometrics login preference
  Future<void> saveBiometricsLoginPreference(bool isEnabled) async {
    sharedPref.saveToSharedPref(loginBiometrics, isEnabled);
  }

  //get biometrics login preference
  bool getBiometricsLoginPreference() {
    return sharedPref.getFromSharedPref(loginBiometrics) ?? true;
  }

  //save the biometric auth type: face_id or fingerprint_id
  Future<void> saveBiometricType(String type) async {
    sharedPref.saveToSharedPref(biometricType, type);
  }

  String getBiometricType() {
    return sharedPref.getFromSharedPref(biometricType) ?? "none";
  }

  //save the theme preference: darkMode or lightMode
  Future<void> saveThemePreference(bool isDark) async {
    sharedPref.saveToSharedPref(themePreference, isDark);
  }

  bool getThemePreference() {
    return sharedPref.getFromSharedPref(themePreference) ?? true;
  }

}
