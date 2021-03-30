import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_intefaces.dart';

class SharedLocalStorageServices implements ILocalStorage {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.remove(key);
  }

  @override
  Future get(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  @override
  Future put(String key, value) async {
    var shared = await SharedPreferences.getInstance();
    if (value is bool) {
      return shared.setBool(key, value);
    } else if (value is String) {
      return shared.setString(key, value);
    }
  }
  
}
