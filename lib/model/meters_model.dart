class Meters {
  int success;
  bool error;
  List<MeterData> data;

  Meters({this.success, this.error, this.data});

  Meters.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = new List<MeterData>();
      json['data'].forEach((v) {
        data.add(new MeterData.fromJson(v));
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

class MeterData {
  String id;
  String serialNumber;
  String materialCost;
  String installationCost;
  String status;
  String createdOn;
  String materialId;
  String purchaseDate;
  String qty;
  String materialType;
  String orderRefNumber;
  String description;
  String make;
  String meterType;
  String modelNo;
  String manufacturer;

  MeterData(
      {this.id,
        this.serialNumber,
        this.materialCost,
        this.installationCost,
        this.status,
        this.createdOn,
        this.materialId,
        this.purchaseDate,
        this.qty,
        this.materialType,
        this.orderRefNumber,
        this.description,
        this.make,
        this.meterType,
        this.modelNo,
        this.manufacturer});

  MeterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    materialCost = json['material_cost'];
    installationCost = json['installation_cost'];
    status = json['status'];
    createdOn = json['created_on'];
    materialId = json['material_id'];
    purchaseDate = json['purchase_date'];
    qty = json['qty'];
    materialType = json['material_type'];
    orderRefNumber = json['order_ref_number'];
    description = json['description'];
    make = json['make'];
    meterType = json['meter_type'];
    modelNo = json['model_no'];
    manufacturer = json['manufacturer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serial_number'] = this.serialNumber;
    data['material_cost'] = this.materialCost;
    data['installation_cost'] = this.installationCost;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['material_id'] = this.materialId;
    data['purchase_date'] = this.purchaseDate;
    data['qty'] = this.qty;
    data['material_type'] = this.materialType;
    data['order_ref_number'] = this.orderRefNumber;
    data['description'] = this.description;
    data['make'] = this.make;
    data['meter_type'] = this.meterType;
    data['model_no'] = this.modelNo;
    data['manufacturer'] = this.manufacturer;
    return data;
  }
}