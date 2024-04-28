class CustomerRequestListResponse{
  String? condition;
  String? requestno;
  String? name;
  String? address;
  String? contact;
  String? phoneno;
  String? salespersoncode;
  String? countryregioncode;
  String? postcode;
  String? email;
  String? mobilephoneno;
  String? gstregistractionno;
  String? gstregistractiontype;
  String? gstcustomertype;
  String? panno;
  String? statecode;
  String? zone;
  String? district;
  String? region;
  String? taluka;
  String? customertype;
  String? vendortype;
  String? territorytype;
  String? seedlicenseno;
  String? status;
  String? createdby;
  String? createdon;
  String? updatedon;

  CustomerRequestListResponse({this.condition, this.requestno, this.name, this.address, this.contact, this.phoneno, this.salespersoncode, this.countryregioncode, this.postcode, this.email, this.mobilephoneno, this.gstregistractionno, this.gstregistractiontype, this.gstcustomertype, this.panno, this.statecode, this.zone, this.district, this.region, this.taluka, this.customertype, this.vendortype, this.territorytype, this.seedlicenseno, this.status, this.createdby, this.createdon, this.updatedon});

  CustomerRequestListResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  requestno = json['request_no'];
  name = json['name'];
  address = json['address'];
  contact = json['contact'];
  phoneno = json['phone_no'];
  salespersoncode = json['sales_person_code'];
  countryregioncode = json['country_region_code'];
  postcode = json['post_code'];
  email = json['email'];
  mobilephoneno = json['mobile_phone_no'];
  gstregistractionno = json['gst_registraction_no'];
  gstregistractiontype = json['gst_registraction_type'];
  gstcustomertype = json['gst_customer_type'];
  panno = json['pan_no'];
  statecode = json['state_code'];
  zone = json['zone'];
  district = json['district'];
  region = json['region'];
  taluka = json['taluka'];
  customertype = json['customer_type'];
  vendortype = json['vendor_type'];
  territorytype = json['territory_type'];
  seedlicenseno = json['seed_license_no'];
  status = json['status'];
  createdby = json['created_by'];
  createdon = json['created_on'];
  updatedon = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['request_no'] = requestno;
  data['name'] = name;
  data['address'] = address;
  data['contact'] = contact;
  data['phone_no'] = phoneno;
  data['sales_person_code'] = salespersoncode;
  data['country_region_code'] = countryregioncode;
  data['post_code'] = postcode;
  data['email'] = email;
  data['mobile_phone_no'] = mobilephoneno;
  data['gst_registraction_no'] = gstregistractionno;
  data['gst_registraction_type'] = gstregistractiontype;
  data['gst_customer_type'] = gstcustomertype;
  data['pan_no'] = panno;
  data['state_code'] = statecode;
  data['zone'] = zone;
  data['district'] = district;
  data['region'] = region;
  data['taluka'] = taluka;
  data['customer_type'] = customertype;
  data['vendor_type'] = vendortype;
  data['territory_type'] = territorytype;
  data['seed_license_no'] = seedlicenseno;
  data['status'] = status;
  data['created_by'] = createdby;
  data['created_on'] = createdon;
  data['updated_on'] = updatedon;
  return data;
  }

}


