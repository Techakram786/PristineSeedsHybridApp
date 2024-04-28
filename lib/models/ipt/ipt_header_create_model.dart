class IptHeaderCreateResponse{

  String? condition;
  String? message;
  String? iptNo;
  String? iptDate;
  String? fromCustomerNo;
  String? fromCustomerName;
  String? fromCustomerAddress;
  String? fromCustomerStateCode;
  String? fromCustomerGstRegistrationNo;
  String? toCustomerNo;
  String? toCustomerName;
  String? toCustomerAddress;
  String? toCustomerStateCode;
  String? toCustomerGstRegistrationNo;
  int? totalQty;
  double? totalPrice;
  double? totalNoOfBags;
  double? totalOrderInKg;
  int? totalApproveQty;
  double? totalApprovePrice;
  double? totalApproveNoOfBags;
  double? totalApproveOrderInKg;
  String? iptStatus;
  String? description;
  String? createdBy;
  String? createdOn;
  String? completedOn;
  String? rejectReason;
  String? approveBy;
  String? approveOn;
  String? captionForCategory;
  List<Lines>? lines;

  IptHeaderCreateResponse(
  {this.condition,
  this.message,
  this.iptNo,
  this.iptDate,
  this.fromCustomerNo,
  this.fromCustomerName,
  this.fromCustomerAddress,
  this.fromCustomerStateCode,
  this.fromCustomerGstRegistrationNo,
  this.toCustomerNo,
  this.toCustomerName,
  this.toCustomerAddress,
  this.toCustomerStateCode,
  this.toCustomerGstRegistrationNo,
  this.totalQty,
  this.totalPrice,
  this.totalNoOfBags,
  this.totalOrderInKg,
  this.totalApproveQty,
  this.totalApprovePrice,
  this.totalApproveNoOfBags,
  this.totalApproveOrderInKg,
  this.iptStatus,
  this.description,
  this.createdBy,
  this.createdOn,
  this.completedOn,
  this.rejectReason,
  this.approveBy,
  this.approveOn,
  this.captionForCategory,
  this.lines});

  IptHeaderCreateResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  message = json['message'];
  iptNo = json['ipt_no'];
  iptDate = json['ipt_date'];
  fromCustomerNo = json['from_customer_no'];
  fromCustomerName = json['from_customer_name'];
  fromCustomerAddress = json['from_customer_address'];
  fromCustomerStateCode = json['from_customer_state_code'];
  fromCustomerGstRegistrationNo = json['from_customer_gst_registration_no'];
  toCustomerNo = json['to_customer_no'];
  toCustomerName = json['to_customer_name'];
  toCustomerAddress = json['to_customer_address'];
  toCustomerStateCode = json['to_customer_state_code'];
  toCustomerGstRegistrationNo = json['to_customer_gst_registration_no'];
  totalQty = json['total_qty'];
  totalPrice = json['total_price'];
  totalNoOfBags = json['total_no_of_bags'];
  totalOrderInKg = json['total_order_in_kg'];
  totalApproveQty = json['total_approve_qty'];
  totalApprovePrice = json['total_approve_price'];
  totalApproveNoOfBags = json['total_approve_no_of_bags'];
  totalApproveOrderInKg = json['total_approve_order_in_kg'];
  iptStatus = json['ipt_status'];
  description = json['description'];
  createdBy = json['created_by'];
  createdOn = json['created_on'];
  completedOn = json['completed_on'];
  rejectReason = json['reject_reason'];
  approveBy = json['approve_by'];
  approveOn = json['approve_on'];
  captionForCategory = json['caption_for_category'];
  if (json['lines'] != null) {
  lines = <Lines>[];
  json['lines'].forEach((v) {
  lines!.add(new Lines.fromJson(v));
  });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['condition'] = this.condition;
  data['message'] = this.message;
  data['ipt_no'] = this.iptNo;
  data['ipt_date'] = this.iptDate;
  data['from_customer_no'] = this.fromCustomerNo;
  data['from_customer_name'] = this.fromCustomerName;
  data['from_customer_address'] = this.fromCustomerAddress;
  data['from_customer_state_code'] = this.fromCustomerStateCode;
  data['from_customer_gst_registration_no'] =
  this.fromCustomerGstRegistrationNo;
  data['to_customer_no'] = this.toCustomerNo;
  data['to_customer_name'] = this.toCustomerName;
  data['to_customer_address'] = this.toCustomerAddress;
  data['to_customer_state_code'] = this.toCustomerStateCode;
  data['to_customer_gst_registration_no'] = this.toCustomerGstRegistrationNo;
  data['total_qty'] = this.totalQty;
  data['total_price'] = this.totalPrice;
  data['total_no_of_bags'] = this.totalNoOfBags;
  data['total_order_in_kg'] = this.totalOrderInKg;
  data['total_approve_qty'] = this.totalApproveQty;
  data['total_approve_price'] = this.totalApprovePrice;
  data['total_approve_no_of_bags'] = this.totalApproveNoOfBags;
  data['total_approve_order_in_kg'] = this.totalApproveOrderInKg;
  data['ipt_status'] = this.iptStatus;
  data['description'] = this.description;
  data['created_by'] = this.createdBy;
  data['created_on'] = this.createdOn;
  data['completed_on'] = this.completedOn;
  data['reject_reason'] = this.rejectReason;
  data['approve_by'] = this.approveBy;
  data['approve_on'] = this.approveOn;
  data['caption_for_category'] = this.captionForCategory;
  if (this.lines != null) {
  data['lines'] = this.lines!.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class Lines {
  String? iptNo;
  String? itemNo;
  String? lotNo;
  double? secondaryPacking;
  double? fgPackSize;
  int? qty;
  double? unitPrice;
  double? totalPrice;
  double? noOfBags;
  double? orderInKg;
  int? approveQty;
  double? approvePrice;
  double? approveNoOfBags;
  double? approveOrderInKg;
  String? updatedOn;
  String? baseUnitOfMeasure;
  String? imageUrl;

  Lines(
  {this.iptNo,
  this.itemNo,
  this.lotNo,
  this.secondaryPacking,
  this.fgPackSize,
  this.qty,
  this.unitPrice,
  this.totalPrice,
  this.noOfBags,
  this.orderInKg,
  this.approveQty,
  this.approvePrice,
  this.approveNoOfBags,
  this.approveOrderInKg,
  this.updatedOn,
  this.baseUnitOfMeasure,
  this.imageUrl});

  Lines.fromJson(Map<String, dynamic> json) {
  iptNo = json['ipt_no'];
  itemNo = json['item_no'];
  lotNo = json['lot_no'];
  secondaryPacking = json['secondary_packing'];
  fgPackSize = json['fg_pack_size'];
  qty = json['qty'];
  unitPrice = json['unit_price'];
  totalPrice = json['total_price'];
  noOfBags = json['no_of_bags'];
  orderInKg = json['order_in_kg'];
  approveQty = json['approve_qty'];
  approvePrice = json['approve_price'];
  approveNoOfBags = json['approve_no_of_bags'];
  approveOrderInKg = json['approve_order_in_kg'];
  updatedOn = json['updated_on'];
  baseUnitOfMeasure = json['base_unit_of_measure'];
  imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ipt_no'] = this.iptNo;
  data['item_no'] = this.itemNo;
  data['lot_no'] = this.lotNo;
  data['secondary_packing'] = this.secondaryPacking;
  data['fg_pack_size'] = this.fgPackSize;
  data['qty'] = this.qty;
  data['unit_price'] = this.unitPrice;
  data['total_price'] = this.totalPrice;
  data['no_of_bags'] = this.noOfBags;
  data['order_in_kg'] = this.orderInKg;
  data['approve_qty'] = this.approveQty;
  data['approve_price'] = this.approvePrice;
  data['approve_no_of_bags'] = this.approveNoOfBags;
  data['approve_order_in_kg'] = this.approveOrderInKg;
  data['updated_on'] = this.updatedOn;
  data['base_unit_of_measure'] = this.baseUnitOfMeasure;
  data['image_url'] = this.imageUrl;
  return data;
  }
  }

