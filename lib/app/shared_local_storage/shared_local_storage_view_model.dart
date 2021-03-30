import 'package:teste_pro_mobile/app/utils/my_data.dart';

import 'shared_local_storage_service.dart';

class SharedLocalStorageViewModel {

  SharedLocalStorageServices storage = SharedLocalStorageServices();

  Future<bool> isLogin() async {
    MyData.isLogin = await storage.get('isLogin') ?? false;
    return MyData.isLogin;
  }

  setLogin(bool value) async {
    await storage.put('isLogin', value);
    MyData.isLogin = value;
  }

  Future<String>getHashKey() async {
    MyData.hashKey = await storage.get('HashKey') ?? '';
    return MyData.hashKey;
  }

  setHashKey(String hash) async{
    MyData.hashKey = hash;
    await storage.put('HashKey', hash);
    return MyData.hashKey;
  }



}