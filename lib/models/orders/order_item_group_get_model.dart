class OrderItemGroupGetModel {
  String? condition;
  String? message;
  String? categoryCode;
  String? groupCode;
  String? groupName;
  String? description;
  String? imageUrl;
  int? orderQty;
  double? orderInKg;

  OrderItemGroupGetModel(
      {this.condition,
        this.message,
        this.categoryCode,
        this.groupCode,
        this.groupName,
        this.description,
        this.imageUrl,
        this.orderQty,
        this.orderInKg});

  OrderItemGroupGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    categoryCode = json['category_code'];
    groupCode = json['group_code'];
    groupName = json['group_name'];
    description = json['description'];
    imageUrl = json['image_url'];
    orderQty = json['order_qty'];
    orderInKg = json['order_in_kg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['category_code'] = this.categoryCode;
    data['group_code'] = this.groupCode;
    data['group_name'] = this.groupName;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['order_qty'] = this.orderQty;
    data['order_in_kg'] = this.orderInKg;
    return data;
  }
}