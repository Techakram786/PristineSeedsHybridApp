
class ProductOnGroundDataListModal {
  String? condition;
  String? message;
  int? totalrows;
  String? pogcode;
  String? zone;
  String? empname;
  String? season;
  String? categorycode;
  String? itemgroupcode;
  String? itemgroupname;
  String? itemno;
  String? itemname;
  String? seasonname;
  String? customerordistributor;
  double? pogqty;
  String? date;
  String? remarks;
  String? createdby;
  String? createdon;
  String? status;
  String? approverid;

  ProductOnGroundDataListModal({this.condition,this.message, this.totalrows, this.pogcode, this.zone, this.empname, this.season, this.categorycode, this.itemgroupcode, this.itemgroupname, this.itemno, this.itemname, this.seasonname, this.customerordistributor, this.pogqty, this.date, this.remarks, this.createdby, this.createdon, this.status, this.approverid});

  ProductOnGroundDataListModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalrows = json['total_rows'];
    pogcode = json['pog_code'];
    zone = json['zone'];
    empname = json['emp_name'];
    season = json['season'];
    categorycode = json['category_code'];
    itemgroupcode = json['item_group_code'];
    itemgroupname = json['item_group_name'];
    itemno = json['item_no'];
    itemname = json['item_name'];
    seasonname = json['season_name'];
    customerordistributor = json['customer_or_distributor'];
    pogqty = json['pog_qty'];
    date = json['date'];
    remarks = json['remarks'];
    createdby = json['created_by'];
    createdon = json['created_on'];
    status = json['status'];
    approverid = json['approver_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    data['total_rows'] = totalrows;
    data['pog_code'] = pogcode;
    data['zone'] = zone;
    data['emp_name'] = empname;
    data['season'] = season;
    data['category_code'] = categorycode;
    data['item_group_code'] = itemgroupcode;
    data['item_group_name'] = itemgroupname;
    data['item_no'] = itemno;
    data['item_name'] = itemname;
    data['season_name'] = seasonname;
    data['customer_or_distributor'] = customerordistributor;
    data['pog_qty'] = pogqty;
    data['date'] = date;
    data['remarks'] = remarks;
    data['created_by'] = createdby;
    data['created_on'] = createdon;
    data['status'] = status;
    data['approver_id'] = approverid;
    return data;
  }
}

