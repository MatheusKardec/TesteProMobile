import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:teste_pro_mobile/app/api/crud_crud_interface.dart';
import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';
import 'package:teste_pro_mobile/app/utils/my_data.dart';

class CrudCrudSerives implements ICrudCrud {

  String encodeMD5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  @override
  Future<List<UserModel>> getAllusers() async {
    List<UserModel> listUser = [];

    try {
      var response = await Dio().get('https://crudcrud.com/api/${MyData.hashKey}/users');

      for (var item in response.data) {
        listUser.add(
          UserModel.fromJson(item)
        );
      }

    } catch (e) {
      print(e);
    }

    return listUser;

  }

  @override
  Future<UserModel> register(UserModel user) async {
      UserModel userModel = UserModel();
      try {
        // ignore: unused_local_variable
        var responseAdd = await Dio().post(
          'https://crudcrud.com/api/${MyData.hashKey}/users', 
          data:  {
            "name": "${user.name}",
            "email": "${user.email}",
            "birthDate": "${user.birthDate}",
            "pass": "${user.pass}"
          }
        );
        userModel = user;

      } catch (e) {
        print(e);
      }
      return userModel;
    }
  
  @override
  Future<String> deleteUser(String id) async {
    String result = '';
    try {
      // ignore: unused_local_variable
      var response = await Dio().delete('https://crudcrud.com/api/${MyData.hashKey}/users/$id');
      result = 'OK';
    } catch (e) {
      result = 'ERRO';
      print(e);
    }
    return result;
  }

  @override
  Future<UserModel> editUser(UserModel user)async {
    UserModel userModel = UserModel();

    try {
      // ignore: unused_local_variable
      var response = await Dio().put(
        'https://crudcrud.com/api/${MyData.hashKey}/users/${user.id}', 
        data:  {
          "name": "${user.name}",
          "email": "${user.email}",
          "birthDate": "${user.birthDate}",
          "pass": "${encodeMD5(user.pass)}"
        }
      );

      userModel = UserModel(
        name: user.name, 
        email: user.email, 
        birthDate: user.birthDate, 
        pass: encodeMD5(user.pass)
      );

    } catch (e) {
      print(e);
    }
    return userModel;
  }

  @override
  Future<UserModel> login(String email, String pass) async {
    UserModel myUser = UserModel(name: 'ERRO');

    await getAllusers().then((list){

      for (UserModel user in list) {
        if(user.email == email && user.pass == pass){
          myUser = user;
          break;
        }
      }
    }).catchError((e){
      myUser = UserModel(name: 'ERRO');
    });

    return myUser;

  }

  @override
  Future<String> changePassword(String email, String newPass)async {
    UserModel myUser = UserModel();
    bool isEmail = false;

    await getAllusers().then((list) async {

      for (UserModel user in list) {
        if(user.email == email){
          isEmail = true;
          myUser = UserModel(id: user.id, name: user.name, email: user.email, birthDate: user.birthDate, pass: newPass);
          await editUser(myUser).then((newValue){
            
          }).catchError((e){
            print(e);
            isEmail = false;
          });
          break;
        }
      }
    });

    return isEmail == true ? 'OK' : 'ERRO: 404';

  }
  

}
