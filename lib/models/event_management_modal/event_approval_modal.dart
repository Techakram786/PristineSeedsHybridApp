
class EventApprovalModal {
  String? condition;
  String? pendingcount;
  String? rejectedcount;
  String? approvecount;
  String? eventcode;
  String? eventdesc;
  String? eventdate;
  String? eventtype;
  double? eventbudget;
  String? itemcategorycode;
  String? itemgroupcode;
  String? farmercode;
  String? farmername;
  String? farmermobileno;
  int? expectedfarmers;
  int? expecteddealers;
  int? expecteddistributer;
  String? eventcovervillages;
  String? createdon;
  String? createdby;
  String? approveremail;
  String? status;
  String? rejectreason;
  String? approveon;
  int? actualfarmers;
  int? actualdistributers;
  int? actualdealers;
  String? imageurl;
  String? empName;

  EventApprovalModal({this.condition, this.pendingcount, this.rejectedcount, this.approvecount, this.eventcode, this.eventdesc, this.eventdate,
    this.eventtype, this.eventbudget, this.itemcategorycode, this.itemgroupcode, this.farmercode, this.farmername,
    this.farmermobileno, this.expectedfarmers, this.expecteddealers, this.expecteddistributer, this.eventcovervillages,
    this.createdon, this.createdby, this.approveremail, this.status, this.rejectreason, this.approveon, this.actualfarmers,
    this.actualdistributers, this.actualdealers,
    this.imageurl, this.empName});

  EventApprovalModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    pendingcount = json['pending_count'];
    rejectedcount = json['rejected_count'];
    approvecount = json['approve_count'];
    eventcode = json['event_code'];
    eventdesc = json['event_desc'];
    eventdate = json['event_date'];
    eventtype = json['event_type'];
    eventbudget = json['event_budget'];
    itemcategorycode = json['item_category_code'];
    itemgroupcode = json['item_group_code'];
    farmercode = json['farmer_code'];
    farmername = json['farmer_name'];
    farmermobileno = json['farmer_mobile_no'];
    expectedfarmers = json['expected_farmers'];
    expecteddealers = json['expected_dealers'];
    expecteddistributer = json['expected_distributer'];
    eventcovervillages = json['event_cover_villages'];
    createdon = json['created_on'];
    createdby = json['created_by'];
    approveremail = json['approver_email'];
    status = json['status'];
    rejectreason = json['reject_reason'];
    approveon = json['approve_on'];
    actualfarmers = json['actual_farmers'];
    actualdistributers = json['actual_distributers'];
    actualdealers = json['actual_dealers'];
    imageurl = json['image_url'];
    empName = json['emp_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['pending_count'] = pendingcount;
    data['rejected_count'] = rejectedcount;
    data['approve_count'] = approvecount;
    data['event_code'] = eventcode;
    data['event_desc'] = eventdesc;
    data['event_date'] = eventdate;
    data['event_type'] = eventtype;
    data['event_budget'] = eventbudget;
    data['item_category_code'] = itemcategorycode;
    data['item_group_code'] = itemgroupcode;
    data['farmer_code'] = farmercode;
    data['farmer_name'] = farmername;
    data['farmer_mobile_no'] = farmermobileno;
    data['expected_farmers'] = expectedfarmers;
    data['expected_dealers'] = expecteddealers;
    data['expected_distributer'] = expecteddistributer;
    data['event_cover_villages'] = eventcovervillages;
    data['created_on'] = createdon;
    data['created_by'] = createdby;
    data['approver_email'] = approveremail;
    data['status'] = status;
    data['reject_reason'] = rejectreason;
    data['approve_on'] = approveon;
    data['actual_farmers'] = actualfarmers;
    data['actual_distributers'] = actualdistributers;
    data['actual_dealers'] = actualdealers;
    data['image_url'] = imageurl;
    data['emp_name'] = this.empName;
    return data;
  }
}

