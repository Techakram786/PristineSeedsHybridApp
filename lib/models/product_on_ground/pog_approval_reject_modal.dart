
class ProductOnGroundApproveRejectModal {
  String? condition;
  String? message;

  ProductOnGroundApproveRejectModal({this.condition, this.message});

  ProductOnGroundApproveRejectModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    return data;
  }
}

