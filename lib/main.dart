import 'package:flutter/material.dart';

import 'app/pages/auth/login.dart';
import 'app/pages/list_users/list_users_page.dart';
import 'app/shared_local_storage/shared_local_storage_view_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste-Pro Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Muli'
      ),
      home: LoadIsLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadIsLogin extends StatefulWidget {

  @override
  _LoadIsLoginState createState() => _LoadIsLoginState();
}

class _LoadIsLoginState extends State<LoadIsLogin> {


  _loadIsLogin() async {
    await SharedLocalStorageViewModel().isLogin().then((value){
      if(value){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ListsUsersPage()));
      }else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginPage()));
      }
    });
  }

  @override
  void initState() {
    _loadIsLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}
