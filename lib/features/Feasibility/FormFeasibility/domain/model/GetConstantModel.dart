class GetConstantModel {
  String? key;
  String? value;

  GetConstantModel({this.key, this.value});

  GetConstantModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  static List<GetConstantModel> mapToList(Map<String, dynamic> mapData) {
    return mapData.entries.map((e) => GetConstantModel(key: e.key, value: e.value)).toList();
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
