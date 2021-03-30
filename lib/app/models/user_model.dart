// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
