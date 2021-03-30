import 'package:teste_pro_mobile/app/api/crud_crud_services.dart';
import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';

class CrudCrudViewModel {

  Future<String> login(String email, String pass) async {

    String result = '';

    await CrudCrudSerives().login(email, pass).then((value){
      if(value.name == null || value.name == 'ERRO'){
        result = 'ERRO';
      }else {
        result = 'OK';
      }
      
    }).catchError((e){
      result = 'ERRO';
    });

    return result; 
  }

  Future<String> register(UserModel user) async {

    String result = '';
    
    await CrudCrudSerives().register(user).then((value){
      if(value.name == 'null' || value.name == null){
        result = 'ERRO';
      }else {
        result = 'OK';
      }
      
    }).catchError((e){
      result = 'ERRO';
    });

    return result; 
  }



}