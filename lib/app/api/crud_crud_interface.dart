import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';

abstract class ICrudCrud{

  Future<List<UserModel>>getAllusers();
  Future<UserModel>editUser(UserModel user);
  Future<String>deleteUser(String id);
  Future<UserModel>login(String email, String pass);
  Future<UserModel>register(UserModel user);
  Future<String>changePassword(String email, String newPass);

}