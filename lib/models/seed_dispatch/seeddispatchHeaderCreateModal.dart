class SeedDispatchHeaderCreateModal {
  String? refrenceno;
  String? documenttype;
  String? date;
  String? locationname;
  String? locationcode;
  String? supervisor;
  String? transporter;
  String? organizercode;
  String? organizername;
  String? trucknumber;
  String? seasoncode;
  String? campat;
  String? remarks;
  String? createdby;

  SeedDispatchHeaderCreateModal({this.refrenceno, this.documenttype, this.date, this.locationname, this.locationcode, this.supervisor, this.transporter, this.organizercode, this.organizername, this.trucknumber, this.seasoncode, this.campat, this.remarks, this.createdby});

  SeedDispatchHeaderCreateModal.fromJson(Map<String, dynamic> json) {
    refrenceno = json['refrence_no'];
    documenttype = json['document_type'];
    date = json['date'];
    locationname = json['location_name'];
    locationcode = json['location_code'];
    supervisor = json['supervisor'];
    transporter = json['transporter'];
    organizercode = json['organizer_code'];
    organizername = json['organizer_name'];
    trucknumber = json['truck_number'];
    seasoncode = json['season_code'];
    campat = json['camp_at'];
    remarks = json['remarks'];
    createdby = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['refrence_no'] = refrenceno;
    data['document_type'] = documenttype;
    data['date'] = date;
    data['location_name'] = locationname;
    data['location_code'] = locationcode;
    data['supervisor'] = supervisor;
    data['transporter'] = transporter;
    data['organizer_code'] = organizercode;
    data['organizer_name'] = organizername;
    data['truck_number'] = trucknumber;
    data['season_code'] = seasoncode;
    data['camp_at'] = campat;
    data['remarks'] = remarks;
    data['created_by'] = createdby;
    return data;
  }
}
