class FreeMaterial {
  int success;
  bool error;
  List<MaterialData> data;

  FreeMaterial({this.success, this.error, this.data});

  FreeMaterial.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new MaterialData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaterialData {
  String id;
  String materialUnit;
  String materialCost;
  String status;
  String createdOn;
  String make;
  String materialType;
  String materialCategory;
  String materialName;
  String warrantyMonth;
  String installationCost;

  MaterialData(
      {this.id,
        this.materialUnit,
        this.materialCost,
        this.status,
        this.createdOn,
        this.make,
        this.materialType,
        this.materialCategory,
        this.materialName,
        this.warrantyMonth,
        this.installationCost});

  MaterialData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialUnit = json['material_unit'];
    materialCost = json['material_cost'];
    status = json['status'];
    createdOn = json['created_on'];
    make = json['make'];
    materialType = json['material_type'];
    materialCategory = json['material_category'];
    materialName = json['material_name'];
    warrantyMonth = json['warranty_month'];
    installationCost = json['installation_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['material_unit'] = this.materialUnit;
    data['material_cost'] = this.materialCost;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['make'] = this.make;
    data['material_type'] = this.materialType;
    data['material_category'] = this.materialCategory;
    data['material_name'] = this.materialName;
    data['warranty_month'] = this.warrantyMonth;
    data['installation_cost'] = this.installationCost;
    return data;
  }
}