class ExtraPipePrice {
  bool error;
  Data data;

  ExtraPipePrice({this.error, this.data});

  ExtraPipePrice.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  dynamic qty;
  dynamic price;
  String pipeUm;
  String priceUm;
  String pipeProvided;

  Data({this.qty, this.price, this.pipeUm, this.priceUm, this.pipeProvided});

  Data.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    price = json['price'];
    pipeUm = json['pipe_um'];
    priceUm = json['price_um'];
    pipeProvided = json['pipe_provided'];
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