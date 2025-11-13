import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infraestructure/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Type not supported');
    }
  }

  @override
  Future<T?> getKeyValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.get(key) as T?;
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }
}
