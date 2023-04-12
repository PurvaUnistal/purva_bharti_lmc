class LoginDetails {
  int status;
  bool error;
  String messages;
  String token;
  User user;
  String exptime;

  LoginDetails(
      {this.status,
        this.error,
        this.messages,
        this.token,
        this.user,
        this.exptime});

  LoginDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    messages = json['messages'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    exptime = json['exptime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['messages'] = this.messages;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['exptime'] = this.exptime;
    return data;
  }
}

class User {
  String id;
  String email;
  String name;
  String schema;
  String role;

  User({this.id, this.email, this.name, this.schema, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    schema = json['schema'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['schema'] = this.schema;
    data['role'] = this.role;
    return data;
  }
}