// class ErrorResponse {
//   int success;
//   List<String> errors;
//
//   ErrorResponse({this.success, this.errors});
//
//   ErrorResponse.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     errors = json['errors'].cast<String>();
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['errors'] = this.errors;
//     return data;
//   }
// }