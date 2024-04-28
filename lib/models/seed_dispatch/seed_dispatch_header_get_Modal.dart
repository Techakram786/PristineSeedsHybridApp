class SeedDispatchGetHeaderModal {
  String? condition;
  String? totalrows;
  String? dispatchno;
  String? transporter;
  String? locationname;
  String? locationcode;
  String? trucknumber;
  String? date;

  SeedDispatchGetHeaderModal({this.condition, this.totalrows, this.dispatchno, this.transporter, this.locationname, this.locationcode, this.trucknumber, this.date});

  SeedDispatchGetHeaderModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalrows = json['total_rows'];
    dispatchno = json['dispatch_no'];
    transporter = json['transporter'];
    locationname = json['location_name'];
    locationcode = json['location_code'];
    trucknumber = json['truck_number'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['total_rows'] = totalrows;
    data['dispatch_no'] = dispatchno;
    data['transporter'] = transporter;
    data['location_name'] = locationname;
    data['location_code'] = locationcode;
    data['truck_number'] = trucknumber;
    data['date'] = date;
    return data;
  }
}