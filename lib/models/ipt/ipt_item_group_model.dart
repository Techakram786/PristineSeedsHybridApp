class ItemGroupResponse {
  String? condition;
  String? categorycode;
  String? groupcode;
  String? groupname;
  String? description;
  String? imageurl;
  int? orderqty;
  double? orderinkg;

  ItemGroupResponse({this.condition, this.categorycode, this.groupcode, this.groupname, this.description, this.imageurl, this.orderqty, this.orderinkg});

  ItemGroupResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  categorycode = json['category_code'];
  groupcode = json['group_code'];
  groupname = json['group_name'];
  description = json['description'];
  imageurl = json['image_url'];
  orderqty = json['order_qty'];
  orderinkg = json['order_in_kg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['category_code'] = categorycode;
  data['group_code'] = groupcode;
  data['group_name'] = groupname;
  data['description'] = description;
  data['image_url'] = imageurl;
  data['order_qty'] = orderqty;
  data['order_in_kg'] = orderinkg;
  return data;
  }

}