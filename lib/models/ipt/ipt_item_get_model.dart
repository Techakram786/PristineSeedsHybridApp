class IptItemGetResponse{
  String? condition;
  String? message;
  String? categorycode;
  String? groupcode;
  String? groupname;
  String? groupdesc;
  String? itemno;
//  String? lotno;
  String? itemname;
  double? secondarypacking;
  double? fgpacksize;
  String? baseunitofmeasure;
  double? unitprice;
  String? imageurl;
  int? orderqty;
  double? orderinkg;

  IptItemGetResponse({this.condition, this.categorycode, this.groupcode, this.groupname, this.groupdesc, this.itemno, this.itemname, this.secondarypacking, this.fgpacksize, this.baseunitofmeasure, this.unitprice, this.imageurl, this.orderqty, this.orderinkg,
    this.message});

  IptItemGetResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  message = json['message'];
  categorycode = json['category_code'];
  groupcode = json['group_code'];
  groupname = json['group_name'];
  groupdesc = json['group_desc'];
  itemno = json['item_no'];
 // lotno = json['lot_no'];
  itemname = json['item_name'];
  secondarypacking = json['secondary_packing'];
  fgpacksize = json['fg_pack_size'];
  baseunitofmeasure = json['base_unit_of_measure'];
  unitprice = json['unit_price'];
  imageurl = json['image_url'];
  orderqty = json['order_qty'];
  orderinkg = json['order_in_kg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['category_code'] = categorycode;
  data['message'] = message;
  data['group_code'] = groupcode;
  data['group_name'] = groupname;
  data['group_desc'] = groupdesc;
  data['item_no'] = itemno;
 // data['lot_no'] = lotno;
  data['item_name'] = itemname;
  data['secondary_packing'] = secondarypacking;
  data['fg_pack_size'] = fgpacksize;
  data['base_unit_of_measure'] = baseunitofmeasure;
  data['unit_price'] = unitprice;
  data['image_url'] = imageurl;
  data['order_qty'] = orderqty;
  data['order_in_kg'] = orderinkg;
  return data;
  }
  }













