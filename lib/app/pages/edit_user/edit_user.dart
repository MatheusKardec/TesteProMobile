import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste_pro_mobile/app/api/crud_crud_services.dart';
import 'package:teste_pro_mobile/app/change_hash/change_hash.dart';
import 'package:teste_pro_mobile/app/components/progress_dialog/progress_dialog.dart';
import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';
import 'package:teste_pro_mobile/app/pages/auth/login.dart';
import 'package:teste_pro_mobile/app/pages/list_users/list_users_page.dart';
import 'package:teste_pro_mobile/app/shared_local_storage/shared_local_storage_view_model.dart';
import 'package:teste_pro_mobile/app/utils/my_data.dart';

class EditUserPage extends StatefulWidget {
  final UserModel userModel;

  const EditUserPage({Key key, @required this.userModel}) : super(key: key);
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  
  ProgressDialog pr;
  
  @override
  void initState() {
    _emailController.text = widget.userModel.email;
    _birthDateController.text = widget.userModel.birthDate;
    _nameController.text = widget.userModel.name;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário', style: TextStyle(color: Colors.blue, fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.vpn_key, color: Colors.blue, size: 35), onPressed: ()=> HashKeycontroller().changeKey(context) ),
        actions: [
          TextButton(
            onPressed: (){
              SharedLocalStorageViewModel().setLogin(false);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginPage()));
            }, 
            child: Text('Sair', style: TextStyle(fontSize: 18),)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MyData.widthFull(context),
          height: MyData.heightFull(context) *0.9,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nome',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        child: TextField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey[800]
                            ),
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // E-mail
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'E-mail',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
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
                // Birth Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Data de nascimento',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        child: TextField(
                          controller: _birthDateController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            DataInputFormatter()
                          ],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Colors.grey[800]
                            ),
                            hintText: 'Data de nascimento',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                // Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Senha',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50.0,
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
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
                            hintText: 'Senha',
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                
                Expanded(
                  child: Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                      onPressed: (){
                        pr.style(message: 'Aguarde...');
                        pr.show();
                        UserModel myUser = UserModel(
                          id: widget.userModel.id,
                          name: _nameController.text,
                          email: _emailController.text,
                          birthDate: _birthDateController.text,
                          pass:  _passwordController.text
                        );
                        CrudCrudSerives().editUser(myUser).then((value){
                          pr.hide();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ListsUsersPage()));
                        });
                      }, 
                      child: Container(
                        width: MyData.widthFull(context) * 0.9,
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
                        height: 60,
                        child: Center(child: Text('Salvar', style: TextStyle(color: Colors.white, fontSize: 20),))
                      )
                    ),
                  )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}