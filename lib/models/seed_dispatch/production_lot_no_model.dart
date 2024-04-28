class ProductionLotModel {
  String? condition;
  String? productionlotno;
  ProductionLotModel({this.condition, this.productionlotno});

  ProductionLotModel.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  productionlotno = json['production_lot_no'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['production_lot_no'] = productionlotno;
  return data;
  }


}