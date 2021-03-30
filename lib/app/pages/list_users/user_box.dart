import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:teste_pro_mobile/app/api/crud_crud_services.dart';
import 'package:teste_pro_mobile/app/components/progress_dialog/progress_dialog.dart';
import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';
import 'package:teste_pro_mobile/app/pages/edit_user/edit_user.dart';
import 'package:teste_pro_mobile/app/utils/my_data.dart';

import 'list_users_page.dart';

class UserBox extends StatefulWidget {
  final UserModel user;

  const UserBox({Key key, @required this.user}) : super(key: key);

  @override
  _UserBoxState createState() => _UserBoxState();
}

class _UserBoxState extends State<UserBox> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.8),
              offset: Offset( 1, 1 )
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ExpansionTile(
            title: Text(
              "${widget.user.name}",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue
              ),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Nome: ${widget.user.name}',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
              ListTile(
                title: Text(
                  'E-mail: ${widget.user.email}',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
              ListTile(
                title: Text(
                  'Data de nascimento: ${widget.user.birthDate}',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.blue,)
                      ),
                      ),
                      onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EditUserPage(userModel: widget.user,))), 
                      
                      child: Container(
                        width: MyData.widthFull(context) * 0.35,
                        height: 40,
                        child: Center(child: Text('Editar', style: TextStyle(color: Colors.blue, fontSize: 17,),))
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.blue,)
                      ),
                      ),
                      onPressed: (){
                        pr.style(message: 'Aguarde...');
                        pr.show();
                        CrudCrudSerives().deleteUser(widget.user.id).then((value){
                          pr.hide();
                          if(value == 'OK'){
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Usuário excluído!",
                              desc: "O usuário ${widget.user.name} foi excluído com sucesso!.",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Voltar",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () =>  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ListsUsersPage())),
                                  width: 120,
                                )
                              ],
                            ).show();
                          } else {
                            Alert(
                              context: context,
                              type: AlertType.error,
                              title: "OPS!",
                              desc: "Parece que ocorreu um erro, por favor tente novamente.",
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
                        
                        width: MyData.widthFull(context) * 0.35,
                        height: 40,
                        child: Center(child: Text('Excluir', style: TextStyle(color: Colors.blue, fontSize: 17,),))
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        ),
      ),  
    );
  }
}