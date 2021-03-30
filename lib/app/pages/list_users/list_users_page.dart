import 'package:flutter/material.dart';
import 'package:teste_pro_mobile/app/api/crud_crud_services.dart';
import 'package:teste_pro_mobile/app/change_hash/change_hash.dart';
import 'package:teste_pro_mobile/app/models/model_list_user_model.dart';
import 'package:teste_pro_mobile/app/pages/auth/login.dart';
import 'package:teste_pro_mobile/app/shared_local_storage/shared_local_storage_view_model.dart';
import 'package:teste_pro_mobile/app/utils/my_data.dart';

import 'user_box.dart';

class ListsUsersPage extends StatefulWidget {
  @override
  _ListsUsersPageState createState() => _ListsUsersPageState();
}

class _ListsUsersPageState extends State<ListsUsersPage> {

  List<UserModel> listUser = [];
  bool load = false;

  @override
  void initState() {
    CrudCrudSerives().getAllusers().then((value){
      setState(() {
        listUser = value;
        load = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários', style: TextStyle(color: Colors.blue, fontSize: 20),),
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
      
      body: Container(
        width: MyData.widthFull(context), height: MyData.heightFull(context),
        child: load == false ? Center(child: CircularProgressIndicator()) :
        
        ListView.builder(
          itemCount: listUser.length,
          itemBuilder: (context, index){
            return UserBox(user: listUser[index],);
          }
        )
      ) 
    );
  }
}