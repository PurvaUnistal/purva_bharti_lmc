// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';
LoginModel loginModel(String res)=> LoginModel.fromJson(jsonDecode(res));

class LoginModel {
  final int status;
  final bool error;
  final String messages;
  final String token;
  final User user;
  final String exptime;

  LoginModel({
    this.status,
    this.error,
    this.messages,
    this.token,
    this.user,
    this.exptime,
  });

  factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());


  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    error: json["error"],
    messages: json["messages"],
    token: json["token"],
    user: User.fromJson(json["user"]),
    exptime: json["exptime"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "messages": messages,
    "token": token,
    "user": user.toJson(),
    "exptime": exptime,
  };



}

class User {
  final String id;
  final String email;
  final String name;
  final String userStatus;
  final String modules;
  final String schema;
  final String role;

  User({
    this.id,
    this.email,
    this.name,
    this.userStatus,
    this.modules,
    this.schema,
    this.role,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    userStatus: json["user_status"],
    modules: json["modules"],
    schema: json["schema"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "user_status": userStatus,
    "modules": modules,
    "schema": schema,
    "role": role,
  };



}


