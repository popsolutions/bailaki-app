import 'package:shared_preferences/shared_preferences.dart';

class MessageDao {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<String> read(String key) async {
    final prefs = await _sharedPreferences;
    return prefs.get(key);
  }

  Future<void> saveOrReplace(String key, String value) async {
    final prefs = await _sharedPreferences;
    return prefs.setString(key, value);
  }
}
