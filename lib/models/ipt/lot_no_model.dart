class LotNoModel{
  String? condition;
  String? message;
  String? lotNo;
  int? qty;

  LotNoModel({this.condition, this.message, this.lotNo, this.qty});

  LotNoModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    lotNo = json['lot_no'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['lot_no'] = this.lotNo;
    data['qty'] = this.qty;
    return data;
  }



}