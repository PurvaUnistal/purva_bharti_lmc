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
  String? qty;
  int? price;
  int? cupipeextra;
  int? gipipe;
  int? giprice;
  int? cupipe;
  int? cuprice;
  String? pipeUm;
  String? priceUm;
  String? pipeProvided;

  ExtraPipePriceData(
      {this.qty,
        this.price,
        this.cupipeextra,
        this.gipipe,
        this.giprice,
        this.cupipe,
        this.cuprice,
        this.pipeUm,
        this.priceUm,
        this.pipeProvided});

  ExtraPipePriceData.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    price = json['price'];
    cupipeextra = json['cupipeextra'];
    gipipe = json['gipipe'];
    giprice = json['giprice'];
    cupipe = json['cupipe'];
    cuprice = json['cuprice'];
    pipeUm = json['pipe_um'];
    priceUm = json['price_um'];
    pipeProvided = json['pipe_provided'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['cupipeextra'] = this.cupipeextra;
    data['gipipe'] = this.gipipe;
    data['giprice'] = this.giprice;
    data['cupipe'] = this.cupipe;
    data['cuprice'] = this.cuprice;
    data['pipe_um'] = this.pipeUm;
    data['price_um'] = this.priceUm;
    data['pipe_provided'] = this.pipeProvided;
    return data;
  }
}
