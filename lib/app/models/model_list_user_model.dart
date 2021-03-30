// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
    UserModel({
        this.id,
        this.name,
        this.email,
        this.birthDate,
        this.pass,
    });

    String id;
    String name;
    String email;
    String birthDate;
    String pass;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        birthDate: json["birthDate"],
        pass: json["pass"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "birthDate": birthDate,
        "pass": pass,
    };
}
