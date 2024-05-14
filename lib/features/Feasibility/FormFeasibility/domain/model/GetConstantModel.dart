class GetConstantModel {
  final dynamic key;
  final String value;
  bool isSelected;

  GetConstantModel({
    required this.key,
    required this.value,
    this.isSelected = false,
  });

  factory GetConstantModel.fromJson(Map<String, dynamic> json) => GetConstantModel(
    key: json["key"],
    value: json["value"],
  );
  static List<GetConstantModel> mapToList(Map<String, dynamic> mapData) {
    return mapData.entries.map((e) => GetConstantModel(key: e.key, value: e.value)).toList();
  }

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };

  @override
  String toString() {
    return this.value;
  }
}
