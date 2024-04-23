class GetConstantModel {
  String? key;
  String? value;
  bool? isSelected;

  GetConstantModel({this.key, this.value, this.isSelected = false});

  GetConstantModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    isSelected = false;
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
