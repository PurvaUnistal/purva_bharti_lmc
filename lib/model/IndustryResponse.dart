
import 'dart:convert';
/*
IndustryResponse industryListeResponseFromJson(String str) =>
    IndustryResponse.fromJson(json.decode(str));

String industryListeResponseToJson(IndustryResponse data) =>
    json.encode(data.toJson());*/
class IndustryResponse {
  String code;
  Result result;

  IndustryResponse({this.code, this.result});

  IndustryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String msg;
  List<IndustryList> industryList;

  Result({this.msg, this.industryList});

  Result.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['IndustryList'] != null) {
      industryList = new List<IndustryList>();
      json['IndustryList'].forEach((v) {
        industryList.add(new IndustryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.industryList != null) {
      data['IndustryList'] = this.industryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IndustryList {
  String id;
  String industryName;
  String status;
  String createdDate;

  IndustryList({this.id, this.industryName, this.status, this.createdDate});

  IndustryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    industryName = json['industry_name'];
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['industry_name'] = this.industryName;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    return data;
  }
}