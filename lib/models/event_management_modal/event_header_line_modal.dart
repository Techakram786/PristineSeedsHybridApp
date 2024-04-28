

/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/


class EventHeaderLineMngModal {
  String? condition;
  String? message;
  double? totalexpenseamount;
  List<HeaderImage?>? headerimages;
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
  List<Line?>? lines;

  EventHeaderLineMngModal({this.condition, this.message, this.totalexpenseamount, this.headerimages, this.eventcode, this.eventdesc, this.eventdate, this.eventtype, this.eventbudget, this.itemcategorycode, this.itemgroupcode, this.farmercode, this.farmername, this.farmermobileno, this.expectedfarmers, this.expecteddealers, this.expecteddistributer, this.eventcovervillages, this.createdon, this.createdby, this.approveremail, this.status, this.rejectreason, this.approveon, this.actualfarmers, this.actualdistributers, this.actualdealers, this.lines});

  EventHeaderLineMngModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalexpenseamount = json['total_expense_amount'];
    if (json['header_images'] != null) {
      headerimages = <HeaderImage>[];
      json['header_images'].forEach((v) {
        headerimages!.add(HeaderImage.fromJson(v));
      });
    }
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
    if (json['lines'] != null) {
      lines = <Line>[];
      json['lines'].forEach((v) {
        lines!.add(Line.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    data['total_expense_amount'] = totalexpenseamount;
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
    data['lines'] =lines != null ? lines!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}
class Line {
  String? eventcode;
  int? lineno;
  String? expensetype;
  int? quantity;
  double? rateunitcost;
  double? amount;
  String? createdon;
  String? imageurl1;
  String? imageurl2;
  String? imageurl3;
  String? imageurl4;
  String? local_image_path1;
  String? local_image_path2;
  String? local_image_path3;
  String? local_image_path4;
  int? imagecount;

  Line({this.eventcode, this.lineno, this.expensetype, this.quantity, this.rateunitcost, this.amount, this.createdon, this.imageurl1, this.imageurl2, this.imageurl3, this.imageurl4, this.imagecount});

  Line.fromJson(Map<String, dynamic> json) {
    eventcode = json['event_code'];
    lineno = json['line_no'];
    expensetype = json['expense_type'];
    quantity = json['quantity'];
    rateunitcost = json['rate_unit_cost'];
    amount = json['amount'];
    createdon = json['created_on'];
    imageurl1 = json['image_url1'];
    imageurl2 = json['image_url2'];
    imageurl3 = json['image_url3'];
    imageurl4 = json['image_url4'];
    imagecount = json['image_count'];
    local_image_path1=null;
    local_image_path2=null;
    local_image_path3=null;
    local_image_path4=null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['event_code'] = eventcode;
    data['line_no'] = lineno;
    data['expense_type'] = expensetype;
    data['quantity'] = quantity;
    data['rate_unit_cost'] = rateunitcost;
    data['amount'] = amount;
    data['created_on'] = createdon;
    data['image_url1'] = imageurl1;
    data['image_url2'] = imageurl2;
    data['image_url3'] = imageurl3;
    data['image_url4'] = imageurl4;
    data['image_count'] = imagecount;
    return data;
  }
}
class HeaderImage {
  String? fileurl;
  HeaderImage({this.fileurl});

  HeaderImage.fromJson(Map<String, dynamic> json) {
    fileurl = json['file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['file_url'] = fileurl;
    return data;
  }
}






