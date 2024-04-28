class IptResponseModel{
  String? condition;
  String? totalrows;
  String? iptno;
  String? iptdate;
  String? fromcustomerno;
  String? fromcustomername;
  String? fromcustomeraddress;
  String? fromcustomerstatecode;
  String? fromcustomergstregistrationno;
  String? tocustomerno;
  String? tocustomername;
  String? tocustomeraddress;
  String? tocustomerstatecode;
  String? tocustomergstregistrationno;
  int? totalqty;
  double? totalprice;
  double? totalnoofbags;
  double? totalorderinkg;
  int? totalapproveqty;
  double? totalapproveprice;
  double? totalapprovenoofbags;
  double? totalapproveorderinkg;
  String? iptstatus;
  String? description;
  String? createdby;
  String? createdon;
  String? completedon;
  String? rejectreason;
  String? approveby;
  String? approveon;
  double? pendingamount;
  double? underapproveamount;
  double? pendingshipmentamount;

  IptResponseModel({this.condition, this.totalrows, this.iptno, this.iptdate, this.fromcustomerno, this.fromcustomername, this.fromcustomeraddress, this.fromcustomerstatecode, this.fromcustomergstregistrationno, this.tocustomerno, this.tocustomername, this.tocustomeraddress, this.tocustomerstatecode, this.tocustomergstregistrationno, this.totalqty, this.totalprice, this.totalnoofbags, this.totalorderinkg, this.totalapproveqty, this.totalapproveprice, this.totalapprovenoofbags, this.totalapproveorderinkg, this.iptstatus, this.description, this.createdby, this.createdon, this.completedon, this.rejectreason, this.approveby, this.approveon, this.pendingamount, this.underapproveamount, this.pendingshipmentamount});

  IptResponseModel.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  totalrows = json['total_rows'];
  iptno = json['ipt_no'];
  iptdate = json['ipt_date'];
  fromcustomerno = json['from_customer_no'];
  fromcustomername = json['from_customer_name'];
  fromcustomeraddress = json['from_customer_address'];
  fromcustomerstatecode = json['from_customer_state_code'];
  fromcustomergstregistrationno = json['from_customer_gst_registration_no'];
  tocustomerno = json['to_customer_no'];
  tocustomername = json['to_customer_name'];
  tocustomeraddress = json['to_customer_address'];
  tocustomerstatecode = json['to_customer_state_code'];
  tocustomergstregistrationno = json['to_customer_gst_registration_no'];
  totalqty = json['total_qty'];
  totalprice = json['total_price'];
  totalnoofbags = json['total_no_of_bags'];
  totalorderinkg = json['total_order_in_kg'];
  totalapproveqty = json['total_approve_qty'];
  totalapproveprice = json['total_approve_price'];
  totalapprovenoofbags = json['total_approve_no_of_bags'];
  totalapproveorderinkg = json['total_approve_order_in_kg'];
  iptstatus = json['ipt_status'];
  description = json['description'];
  createdby = json['created_by'];
  createdon = json['created_on'];
  completedon = json['completed_on'];
  rejectreason = json['reject_reason'];
  approveby = json['approve_by'];
  approveon = json['approve_on'];
  pendingamount = json['pending_amount'];
  underapproveamount = json['under_approve_amount'];
  pendingshipmentamount = json['pending_shipment_amount'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['total_rows'] = totalrows;
  data['ipt_no'] = iptno;
  data['ipt_date'] = iptdate;
  data['from_customer_no'] = fromcustomerno;
  data['from_customer_name'] = fromcustomername;
  data['from_customer_address'] = fromcustomeraddress;
  data['from_customer_state_code'] = fromcustomerstatecode;
  data['from_customer_gst_registration_no'] = fromcustomergstregistrationno;
  data['to_customer_no'] = tocustomerno;
  data['to_customer_name'] = tocustomername;
  data['to_customer_address'] = tocustomeraddress;
  data['to_customer_state_code'] = tocustomerstatecode;
  data['to_customer_gst_registration_no'] = tocustomergstregistrationno;
  data['total_qty'] = totalqty;
  data['total_price'] = totalprice;
  data['total_no_of_bags'] = totalnoofbags;
  data['total_order_in_kg'] = totalorderinkg;
  data['total_approve_qty'] = totalapproveqty;
  data['total_approve_price'] = totalapproveprice;
  data['total_approve_no_of_bags'] = totalapprovenoofbags;
  data['total_approve_order_in_kg'] = totalapproveorderinkg;
  data['ipt_status'] = iptstatus;
  data['description'] = description;
  data['created_by'] = createdby;
  data['created_on'] = createdon;
  data['completed_on'] = completedon;
  data['reject_reason'] = rejectreason;
  data['approve_by'] = approveby;
  data['approve_on'] = approveon;
  data['pending_amount'] = pendingamount;
  data['under_approve_amount'] = underapproveamount;
  data['pending_shipment_amount'] = pendingshipmentamount;
  return data;
  }




}