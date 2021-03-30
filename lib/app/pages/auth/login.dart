import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:teste_pro_mobile/app/api/crud_crud_services.dart';
import 'package:teste_pro_mobile/app/change_hash/change_hash.dart';
import 'package:teste_pro_mobile/app/components/progress_dialog/progress_dialog.dart';
import 'package:teste_pro_mobile/app/pages/list_users/list_users_page.dart';
import 'package:teste_pro_mobile/app/shared_local_storage/shared_local_storage_view_model.dart';
import 'package:teste_pro_mobile/app/utils/my_data.dart';

import 'controllers/auth_controllers.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MyData.widthFull(context),
          height: MyData.heightFull(context),
          child: Stack(
            children: [
              // background Color
              Container(
                width: MyData.widthFull(context),
                height: MyData.heightFull(context) * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [
                      Colors.blue, Colors.deepPurple[900]
                    ]
                  )
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0, right: 20),
                    child: TextButton(
                      onPressed: ()=> HashKeycontroller().changeKey(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mudar a Hash', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Icon(Icons.vpn_key, color: Colors.white, size: 40),
                          )
                        ],
                      ),
                    )
                  
                  ),
                ),
              ),
              // Box Center 
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MyData.widthFull(context) * 0.85, 
                  height: 300,
                  child: Stack(
                    children: [
                      // Box
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MyData.widthFull(context) * 0.85, 
                          height: 270,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[700],
                                offset: Offset(2, 2),
                                blurRadius: 2
                              ),
                            ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text('LOGIN', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: Colors.grey[700], fontWeight: FontWeight.bold),),

                                //E-mail
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Email',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50.0,
                                        child: TextField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 14.0),
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Colors.grey[800]
                                            ),
                                            hintText: 'E-mail',
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                //Password
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Senha',
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15.0),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50.0,
                                        child: TextField(
                                          obscureText: true,
                                          controller: _passwordController,
                                          keyboardType: TextInputType.emailAddress,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 14.0),
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: Colors.grey[800]
                                            ),
                                            hintText: 'Senha',
                                            hintStyle: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),

                      //Button login
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(0),
                            ),
                            onPressed: (){
                              pr.style(message: 'Verificando...');
                              pr.show();
                              AuthContollers().login(_emailController.text, _passwordController.text, context).then((value){
                                pr.hide();
                                if(value == 'OK'){
                                  SharedLocalStorageViewModel().setLogin(true);
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ListsUsersPage()));
                                }else {
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "OPS!",
                                    desc: "E-mail ou senha Inválida, por favor tente novamente.",
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
                              });
                            }, 
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft, end: Alignment.bottomRight,
                                  colors: [
                                    Colors.blue, Colors.deepPurple[900]
                                  ]
                                )
                              ),
                              
                              child: Center(child: Text('LOGIN', style: TextStyle(fontSize: 16, color: Colors.white, ),)),
                            )
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),

              // Forogot password
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MyData.heightFull(context) * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Column(
                          children: [
                            TextButton(
                              onPressed: (){
                                _emailController.clear();
                                _passwordController.clear();
                                _newPasswordController.clear();
                                _recoveryPass(context);
                              }, 
                              child: Text('Perdeu a senha ?', textAlign: TextAlign.center, style: TextStyle(fontSize: 17, color: Colors.grey[700], fontWeight: FontWeight.bold),),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.1),
                                          Colors.black,
                                        ],
                                        begin: const FractionalOffset(0.0, 0.0),
                                        end: const FractionalOffset(1.0, 1.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp
                                      ),
                                    ),
                                    width: 100.0, height: 1.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                    child: Text(
                                      "Ou",
                                      style: TextStyle( color: Colors.black, fontSize: 16.0,),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: new LinearGradient(
                                        colors: [
                                          Colors.black,
                                          Colors.black.withOpacity(0.1),
                                        ],
                                        begin: const FractionalOffset(0.0, 0.0),
                                        end: const FractionalOffset(1.0, 1.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp
                                      ),
                                    ),
                                    width: 100.0, height: 1.0,
                                  ),
                                ],
                              ),
                            ),

                            TextButton(
                              onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterPage())),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Não tem uma conta ? ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Registre-se',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  
  _recoveryPass(context){
    Alert(
      context: context,
      title: "Mudar a senha",
      content: Column(
        children: [
          //E-mail
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Email',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50.0,
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey[800]
                      ),
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          // New Password
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Nova Senha',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50.0,
                  child: TextField(
                    obscureText: true,
                    controller: _newPasswordController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[800]
                      ),
                      hintText: 'Nova Senha',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: (){
            Navigator.pop(context);
            pr.style(message: 'Aguarde...');
            pr.show();
            CrudCrudSerives().changePassword(_emailController.text, _newPasswordController.text).then((value) {
              pr.hide();
              if(value == 'OK'){
                Alert(
                  context: context,
                  type: AlertType.success,
                  title: "SENHA ALTERADA!",
                  desc: "Sua senha foi alterada com sucesso!.",
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
              } else {
                Alert(
                  context: context,
                  type: AlertType.error,
                  title: "OPS!",
                  desc: "Parece que ocorreu um erro, por favor, verifique seu e-mail e tente novamente.",
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
              
            });
          },
          child: Text(
            "Salvar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]
    ).show();
  }

}