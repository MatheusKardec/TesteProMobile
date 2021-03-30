import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:teste_pro_mobile/app/api/crud_crud_view_model.dart';
import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';

class AuthContollers{

  String encodeMD5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  bool birthDateValid(String birthDate){

    bool isValid = false;

    bool yearBi(year){
      return year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ? true : false;
    }

    int monthDays(int month){
      
      if(month == 2){
        return yearBi(month) ? 29 : 28; 
      } else if(month == 1 || month == 3 || month == 5|| month == 7 || month == 8 || month == 10 || month == 12){
        return 31;
      }else {
        return 30;
      }
    }

    List<String> date = birthDate.split('/');

    int dayCurrent = int.parse(date[0]);
    int monthCurrent = int.parse(date[1]);
    int yearCurrent = int.parse(date[2]);

    DateTime now = new DateTime.now();

    int maxDay = monthDays(monthCurrent);
    int maxYear = (now.year - 5);

    if(dayCurrent > maxDay){
      isValid = false;
    }else if(monthCurrent > 12){
      isValid = false;
    }else if(yearCurrent > maxYear){
      isValid = false;
    }else {
      isValid = true;
    }

    return isValid;
  }

  Future<String> login(String myEmail, String myPass, context) async {
    String result = '';
    String email = '';
    String pass = '';

    if(myEmail.contains(' ')){
      email = myEmail.replaceAll(' ', '');
    }else {
      email = myEmail;
    }

    if(pass.contains(' ')){
      pass = myPass.replaceAll(' ', '');
    }else {
      pass = myPass;
    }

    if( email.isNotEmpty && pass.isNotEmpty ){
      await CrudCrudViewModel().login(email, encodeMD5(pass)).then((value){
        result = value;
      });
      
    }else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "OPS!",
        desc: "E-mail ou senha está vazia, por favor preencha os campos para continuar.",
        buttons: [
          DialogButton(
            child: Text(
              "Voltar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    return result;

  }

  Future<String> register(String name, String email, String birthDate, String pass, context) async {
    String result = '';
    String myEmail = '';
    String myPass = '';

    if(email.contains(' ')){
      myEmail = email.replaceAll(' ', '');
    }else {
      myEmail = email;
    }

    if(pass.contains(' ')){
      myPass = pass.replaceAll(' ', '');
    }else {
      myPass = pass;
    }

    UserModel user = UserModel(
      name: name, email: myEmail, birthDate: birthDate, pass: encodeMD5(myPass)
    );

    if( myEmail.isNotEmpty && name.isNotEmpty && birthDate.isNotEmpty && myPass.isNotEmpty ){

      if(!myEmail.contains("@gmail.com")){
        Alert(
          context: context,
          type: AlertType.error,
          title: "OPS!",
          desc: "E-mail Inválido, por favor use um E-mail com '@gmail.com' e tente novamente.",
          buttons: [
            DialogButton(
              child: Text(
                "Voltar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else if( birthDateValid(birthDate) == false ){
        Alert(
          context: context,
          type: AlertType.error,
          title: "OPS!",
          desc: "Data de nascimento Inválida, por favor coloque uma data válida e tente novamente.\nOBS: para a data ser válida, você dever ter mais de 5 anos.",
          buttons: [
            DialogButton(
              child: Text(
                "Voltar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else if(myPass.length < 6){
        Alert(
          context: context,
          type: AlertType.error,
          title: "OPS!",
          desc: "A senha está muito curta, por favor digite uma senha com mais de 6 caracteres",
          buttons: [
            DialogButton(
              child: Text(
                "Voltar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
      else {
        await CrudCrudViewModel().register(user).then((value){
          result = value;
        });
     
      }

       
    }else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "OPS!",
        desc: "Acho que você esqueceu de preencher algum campo, por favor preencha todos os campos para continuar.",
        buttons: [
          DialogButton(
            child: Text(
              "Voltar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }

    return result;

  }

}