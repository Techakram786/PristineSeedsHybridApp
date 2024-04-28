
class ProductOnGroundUpdateModal {
  String? condition;
  String? message;
  String? pogcode;
  String? zone;
  String? empname;
  String? season;
  String? seasonname;
  String? categorycode;
  String? categoryname;
  String? itemgroupcode;
  String? itemgroupname;
  String? itemno;
  String? itemname;
  String? customerordistributor;
  String? customerordistributorname;
  double? pogqty;
  String? date;
  String? remarks;
  String? createdby;
  String? createdon;
  String? status;
  String? reason;
  String? approverid;
  int? navsync;
  String? navmessage;
  int? isupdated;

  ProductOnGroundUpdateModal({this.condition, this.message, this.pogcode, this.zone, this.empname, this.season, this.seasonname, this.categorycode, this.categoryname, this.itemgroupcode, this.itemgroupname, this.itemno, this.itemname, this.customerordistributor, this.customerordistributorname, this.pogqty, this.date, this.remarks, this.createdby, this.createdon, this.status, this.reason, this.approverid, this.navsync, this.navmessage, this.isupdated});

  ProductOnGroundUpdateModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    pogcode = json['pog_code'];
    zone = json['zone'];
    empname = json['emp_name'];
    season = json['season'];
    seasonname = json['season_name'];
    categorycode = json['category_code'];
    categoryname = json['category_name'];
    itemgroupcode = json['item_group_code'];
    itemgroupname = json['item_group_name'];
    itemno = json['item_no'];
    itemname = json['item_name'];
    customerordistributor = json['customer_or_distributor'];
    customerordistributorname = json['customer_or_distributor_name'];
    pogqty = json['pog_qty'];
    date = json['date'];
    remarks = json['remarks'];
    createdby = json['created_by'];
    createdon = json['created_on'];
    status = json['status'];
    reason = json['reason'];
    approverid = json['approver_id'];
    navsync = json['nav_sync'];
    navmessage = json['nav_message'];
    isupdated = json['is_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    data['pog_code'] = pogcode;
    data['zone'] = zone;
    data['emp_name'] = empname;
    data['season'] = season;
    data['season_name'] = seasonname;
    data['category_code'] = categorycode;
    data['category_name'] = categoryname;
    data['item_group_code'] = itemgroupcode;
    data['item_group_name'] = itemgroupname;
    data['item_no'] = itemno;
    data['item_name'] = itemname;
    data['customer_or_distributor'] = customerordistributor;
    data['customer_or_distributor_name'] = customerordistributorname;
    data['pog_qty'] = pogqty;
    data['date'] = date;
    data['remarks'] = remarks;
    data['created_by'] = createdby;
    data['created_on'] = createdon;
    data['status'] = status;
    data['reason'] = reason;
    data['approver_id'] = approverid;
    data['nav_sync'] = navsync;
    data['nav_message'] = navmessage;
    data['is_updated'] = isupdated;
    return data;
  }
}

