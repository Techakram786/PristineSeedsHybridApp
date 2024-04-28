class ProductOnGroundDiscardModal {
  String? condition;
  String? message;

  ProductOnGroundDiscardModal({this.condition, this.message});

  ProductOnGroundDiscardModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    return data;
  }
}