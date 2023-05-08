import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void setLocalStorageString(String key, String value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  void setLocalStorageBool(String key, bool value) async {
    SharedPreferences prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  Future<String?> getLocalStorageString(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  Future<bool?> getLocalStorageBool(String key) async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future<void> removeLocalStorage(String key) async {
    SharedPreferences prefs = await _prefs;
    await prefs.remove(key);
  }
}
