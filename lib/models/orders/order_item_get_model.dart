class OrderItemGetModel {
  String? condition;
  String? message;
  String? categoryCode;
  String? groupCode;
  String? groupName;
  String? groupDesc;
  String? itemNo;
  String? itemName;
  String? baseUnitOfMeasure;
  double? secondaryPacking;
  double? fgPackSize;
  double? unitPrice;
  String? imageUrl;
  int? orderQty;
  double? orderInKg;

  OrderItemGetModel(
      {this.condition,
        this.message,
        this.categoryCode,
        this.groupCode,
        this.groupName,
        this.groupDesc,
        this.itemNo,
        this.itemName,
        this.secondaryPacking,
        this.baseUnitOfMeasure,
        this.fgPackSize,
        this.unitPrice,
        this.imageUrl,
        this.orderQty,
        this.orderInKg});

  OrderItemGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    categoryCode = json['category_code'];
    groupCode = json['group_code'];
    groupName = json['group_name'];
    groupDesc = json['group_desc'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    secondaryPacking = json['secondary_packing'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    fgPackSize = json['fg_pack_size'];
    unitPrice = json['unit_price'];
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
    data['group_desc'] = this.groupDesc;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['secondary_packing'] = this.secondaryPacking;
    data['fg_pack_size'] = this.fgPackSize;
    data['base_unit_of_measure'] = this.baseUnitOfMeasure;
    data['unit_price'] = this.unitPrice;
    data['image_url'] = this.imageUrl;
    data['order_qty'] = this.orderQty;
    data['order_in_kg'] = this.orderInKg;
    return data;
  }
}