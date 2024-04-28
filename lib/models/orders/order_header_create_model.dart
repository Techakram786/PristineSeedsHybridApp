class OrderHeaderCreateModel {
  String? condition;
  String? message;
  double? currentOutstanding;
  double? creditLimit;
  String? orderNo;
  String? orderDate;
  String? paymentTermCode;
  String? expiryDate;
  String? customerNo;
  String? customerName;
  String? customerAddress;
  String? customerStateCode;
  String? customerGstRegistrationNo;
  String? consigneeId;
  String? consigneeName;
  String? consigneeAddress;
  String? consigneeStateCode;
  String? consigneeGstRegistrationNo;
  int? totalQty;
  double? totalPrice;
  double? totalNoOfBags;
  double? totalOrderInKg;
  int? totalApproveQty;
  double? totalApprovePrice;
  double? totalApproveNoOfBags;
  double? totalApproveOrderInKg;
  String? orderStatus;
  String? description;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? rejectReason;
  String? approveBy;
  String? approveOn;
  String? captionForCategory;
  List<Lines>? lines;

  OrderHeaderCreateModel(
      {this.condition,
        this.message,
        this.currentOutstanding,
        this.creditLimit,
        this.orderNo,
        this.orderDate,
        this.paymentTermCode,
        this.expiryDate,
        this.customerNo,
        this.customerName,
        this.customerAddress,
        this.customerStateCode,
        this.customerGstRegistrationNo,
        this.consigneeId,
        this.consigneeName,
        this.consigneeAddress,
        this.consigneeStateCode,
        this.consigneeGstRegistrationNo,
        this.totalQty,
        this.totalPrice,
        this.totalNoOfBags,
        this.totalOrderInKg,
        this.totalApproveQty,
        this.totalApprovePrice,
        this.totalApproveNoOfBags,
        this.totalApproveOrderInKg,
        this.orderStatus,
        this.description,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.rejectReason,
        this.approveBy,
        this.approveOn,
        this.captionForCategory,
        this.lines});

  OrderHeaderCreateModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    currentOutstanding = json['current_outstanding'];
    creditLimit = json['credit_limit'];
    orderNo = json['order_no'];
    orderDate = json['order_date'];
    paymentTermCode = json['payment_term_code'];
    expiryDate = json['expiry_date'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerStateCode = json['customer_state_code'];
    customerGstRegistrationNo = json['customer_gst_registration_no'];
    consigneeId = json['consignee_id'];
    consigneeName = json['consignee_name'];
    consigneeAddress = json['consignee_address'];
    consigneeStateCode = json['consignee_state_code'];
    consigneeGstRegistrationNo = json['consignee_gst_registration_no'];
    totalQty = json['total_qty'];
    totalPrice = json['total_price'];
    totalNoOfBags = json['total_no_of_bags'];
    totalOrderInKg = json['total_order_in_kg'];
    totalApproveQty = json['total_approve_qty'];
    totalApprovePrice = json['total_approve_price'];
    totalApproveNoOfBags = json['total_approve_no_of_bags'];
    totalApproveOrderInKg = json['total_approve_order_in_kg'];
    orderStatus = json['order_status'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
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
    data['current_outstanding'] = this.currentOutstanding;
    data['credit_limit'] = this.creditLimit;
    data['order_no'] = this.orderNo;
    data['order_date'] = this.orderDate;
    data['payment_term_code'] = this.paymentTermCode;
    data['expiry_date'] = this.expiryDate;
    data['customer_no'] = this.customerNo;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['customer_state_code'] = this.customerStateCode;
    data['customer_gst_registration_no'] = this.customerGstRegistrationNo;
    data['consignee_id'] = this.consigneeId;
    data['consignee_name'] = this.consigneeName;
    data['consignee_address'] = this.consigneeAddress;
    data['consignee_state_code'] = this.consigneeStateCode;
    data['consignee_gst_registration_no'] = this.consigneeGstRegistrationNo;
    data['total_qty'] = this.totalQty;
    data['total_price'] = this.totalPrice;
    data['total_no_of_bags'] = this.totalNoOfBags;
    data['total_order_in_kg'] = this.totalOrderInKg;
    data['total_approve_qty'] = this.totalApproveQty;
    data['total_approve_price'] = this.totalApprovePrice;
    data['total_approve_no_of_bags'] = this.totalApproveNoOfBags;
    data['total_approve_order_in_kg'] = this.totalApproveOrderInKg;
    data['order_status'] = this.orderStatus;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
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
  String? orderNo;
  String? itemNo;
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
  String? imageUrl;
  String? baseUnitOfMeasure;

  Lines(
      {this.orderNo,
        this.itemNo,
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
        this.imageUrl
        });

  Lines.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    itemNo = json['item_no'];
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
    data['order_no'] = this.orderNo;
    data['item_no'] = this.itemNo;
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