// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final int? status;
  final bool? error;
  final String? messages;
  final String? token;
  final User? user;
  final String? exptime;

  LoginModel({
    this.status,
    this.error,
    this.messages,
    this.token,
    this.user,
    this.exptime,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"] ?? "",
    error: json["error"] ?? "",
    messages: json["messages"] ?? "",
    token: json["token"] ?? "",
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    exptime: json["exptime"] == null ? null : json["exptime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "messages": messages,
    "token": token,
    "user": user!.toJson(),
    "exptime": exptime,
  };
}

class User {
  final String? id;
  final String? email;
  final String? moduleId;
  final String? name;
  final String? userStatus;
  final String? pwdChanged;
  final dynamic modules;
  final String? schema;
  final String? role;
  final List<Accessright>? accessright;
  final String? spreadId;
  final String? sectionId;
  final String? smartLogo;
  final String? projectLogo;
  final String? projectUrl;

  User({
    this.id,
    this.email,
    this.moduleId,
    this.name,
    this.userStatus,
    this.pwdChanged,
    this.modules,
    this.schema,
    this.role,
    this.accessright,
    this.spreadId,
    this.sectionId,
    this.smartLogo,
    this.projectLogo,
    this.projectUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    moduleId: json["module_id"] ?? "",
    name: json["name"] ?? "",
    userStatus: json["user_status"] ?? "",
    pwdChanged: json["pwd_changed"] ?? "",
    modules: json["modules"] ?? "",
    schema: json["schema"] ?? "",
    role: json["role"] ?? "",
    accessright: json["accessright"] == null ? [] : List<Accessright>.from(json["accessright"].map((x) => Accessright.fromJson(x))),
    spreadId: json["spread_id"] ?? "",
    sectionId: json["section_id"] ?? "",
    smartLogo: json["smartLogo"] ?? "",
    projectLogo: json["projectLogo"] ?? "",
    projectUrl: json["projectUrl"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "module_id": moduleId,
    "name": name,
    "user_status": userStatus,
    "pwd_changed": pwdChanged,
    "modules": modules,
    "schema": schema,
    "role": role?.trim().toString(),
    "accessright": List<dynamic>.from(accessright!.map((x) => x.toJson())),
    "spread_id": spreadId,
    "section_id": sectionId,
    "smartLogo": smartLogo,
    "projectLogo": projectLogo,
    "projectUrl": projectUrl,
  };
}

class Accessright {
  final String? menuCode;
  final String? id;
  final String? name;
  final String? submoduleAlias;

  Accessright({
    this.menuCode,
    this.id,
    this.name,
    this.submoduleAlias,
  });

  static accessrightListFromJson(String json) {
    return List<Accessright>.from(jsonDecode(json).map((x) => Accessright.fromJson(x)));
  }

  static jsonFromAccessrightList(List<Accessright> list) {
    return jsonEncode(list);
  }

  factory Accessright.fromJson(Map<String, dynamic> json) => Accessright(
    menuCode: json["menu_code"] ?? "",
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    submoduleAlias: json["submodule_alias"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "menu_code": menuCode,
    "id": id,
    "name": name,
    "submodule_alias": submoduleAlias,
  };
}
