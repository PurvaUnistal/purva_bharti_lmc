class CheckFeasibleModel {
  String? key;
  String? value;


  CheckFeasibleModel({this.key, this.value});

  CheckFeasibleModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  static List<CheckFeasibleModel> mapToList(Map<String, dynamic> mapData) {
    return mapData.entries.map((e) => CheckFeasibleModel(key: e.key, value: e.value)).toList();
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