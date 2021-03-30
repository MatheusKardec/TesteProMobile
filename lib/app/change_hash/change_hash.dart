import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:teste_pro_mobile/app/shared_local_storage/shared_local_storage_view_model.dart';

class HashKeycontroller {

  TextEditingController _textEditingController = TextEditingController();

  changeKey(context) async {
    SharedLocalStorageViewModel().getHashKey();
    Alert(
      context: context,
      title: "Trocar HASH",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'NOVA HASH',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50.0,
              child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.grey[800]
                  ),
                  hintText: 'HASH',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: (){
            Navigator.pop(context);
            SharedLocalStorageViewModel().setHashKey(_textEditingController.text).then((value){
              Alert(
                context: context,
                type: AlertType.success,
                title: "HASH ALTERADA!",
                desc: "a HASH foi alterada com sucesso!.",
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