class SeedDispatLocationchModal {
  String? condition;
  String? locationid;
  String? locationname;
  String? companyid;
  String? locationtype;
  String? address;
  String? city;
  String? state;
  String? country;
  String? gsttype;
  String? gstno;
  String? contactno;
  String? email;
  int? isho;
  String? statename;
  String? postcode;
  String? govermentstatecode;
  String? createdby;
  String? createdon;
  String? locprefix;

  SeedDispatLocationchModal({this.condition, this.locationid, this.locationname, this.companyid, this.locationtype, this.address, this.city, this.state, this.country, this.gsttype, this.gstno, this.contactno, this.email, this.isho, this.statename, this.postcode, this.govermentstatecode, this.createdby, this.createdon, this.locprefix});

  SeedDispatLocationchModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    locationid = json['location_id'];
    locationname = json['location_name'];
    companyid = json['company_id'];
    locationtype = json['location_type'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    gsttype = json['gst_type'];
    gstno = json['gst_no'];
    contactno = json['contact_no'];
    email = json['email'];
    isho = json['is_ho'];
    statename = json['state_name'];
    postcode = json['post_code'];
    govermentstatecode = json['goverment_state_code'];
    createdby = json['created_by'];
    createdon = json['created_on'];
    locprefix = json['loc_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['location_id'] = locationid;
    data['location_name'] = locationname;
    data['company_id'] = companyid;
    data['location_type'] = locationtype;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['gst_type'] = gsttype;
    data['gst_no'] = gstno;
    data['contact_no'] = contactno;
    data['email'] = email;
    data['is_ho'] = isho;
    data['state_name'] = statename;
    data['post_code'] = postcode;
    data['goverment_state_code'] = govermentstatecode;
    data['created_by'] = createdby;
    data['created_on'] = createdon;
    data['loc_prefix'] = locprefix;
    return data;
  }
}