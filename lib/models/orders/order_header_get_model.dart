class OrderHeaderGetModel {
  String? condition;
  String? totalRows;
  String? message;
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
  double? pendingAmount;
  double? underApproveAmount;
  double? pendingShipmentAmount;

  OrderHeaderGetModel(
      {this.condition,
      this.message,
        this.totalRows,
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
        this.pendingAmount,
        this.underApproveAmount,
        this.pendingShipmentAmount});

  OrderHeaderGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
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
    pendingAmount = json['pending_amount'];
    underApproveAmount = json['under_approve_amount'];
    pendingShipmentAmount = json['pending_shipment_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
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
    data['pending_amount'] = this.pendingAmount;
    data['under_approve_amount'] = this.underApproveAmount;
    data['pending_shipment_amount'] = this.pendingShipmentAmount;
    return data;
  }
}