class LMCReasonModel {
  String? key;
  String? value;


  LMCReasonModel({this.key, this.value});

  LMCReasonModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  static List<LMCReasonModel> mapToList(Map<String, dynamic> mapData) {
    return mapData.entries.map((e) => LMCReasonModel(key: e.key, value: e.value)).toList();
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }

  @override
  String toString() {
    return this.value ?? "";
  }
}