class itemCategoryResponse {

  String? condition;
  String? categorycode;
  String? categorydescription;
  String? croptype;
  int? orderqty;
  int? itemgroupcount;

  itemCategoryResponse({this.condition, this.categorycode, this.categorydescription, this.croptype, this.orderqty, this.itemgroupcount});

  itemCategoryResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  categorycode = json['category_code'];
  categorydescription = json['category_description'];
  croptype = json['crop_type'];
  orderqty = json['order_qty'];
  itemgroupcount = json['item_group_count'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['category_code'] = categorycode;
  data['category_description'] = categorydescription;
  data['crop_type'] = croptype;
  data['order_qty'] = orderqty;
  data['item_group_count'] = itemgroupcount;
  return data;
  }
  }







