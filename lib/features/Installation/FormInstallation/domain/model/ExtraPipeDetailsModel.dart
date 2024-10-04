class ExtraPipePriceModel {
  bool? error;
  ExtraPipePriceData? data;

  ExtraPipePriceModel({this.error, this.data});

  ExtraPipePriceModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new ExtraPipePriceData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ExtraPipePriceData {
  dynamic qty;
  dynamic price;
  String? pipeUm;
  String? priceUm;
  String? pipeProvided;

  ExtraPipePriceData({this.qty, this.price, this.pipeUm, this.priceUm, this.pipeProvided});

  ExtraPipePriceData.fromJson(Map<String, dynamic> json) {
    qty = json['qty'] ?? "";
    price = json['price']?? "";
    pipeUm = json['pipe_um']?? "";
    priceUm = json['price_um']?? "";
    pipeProvided = json['pipe_provided']?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['pipe_um'] = this.pipeUm;
    data['price_um'] = this.priceUm;
    data['pipe_provided'] = this.pipeProvided;
    return data;
  }
}