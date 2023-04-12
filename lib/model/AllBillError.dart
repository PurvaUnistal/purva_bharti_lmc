// class AllBillError {
//   bool success;
//   int code;
//   bool error;
//   String data;
//   AllBillError({this.success, this.code, this.error, this.data});
//   AllBillError.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     code = json['code'];
//     error = json['error'];
//     data = json['data'];
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['code'] = this.code;
//     data['error'] = this.error;
//     data['data'] = this.data;
//     return data;
//   }
// }