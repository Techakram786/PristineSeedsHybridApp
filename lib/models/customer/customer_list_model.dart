class CustomerResponse{
  String? condition;
  int? totalcount;
  String? customerno;
  String? name;
  String? address;
  String? address2;
  String? postcode;
  String? statecode;
  String? statename;
  String? countrycode;
  String? countryname;
  String? salespersoncode;
  String? salespersonname;
  String? phoneno;
  String? emailid;
  String? contactpersonname;
  String? mobileno;
  String? customertype;
  String? customerpricegroup;
  String? customerdiscountgroup;
  String? paymentterm;
  String? gstregistrationno;
  String? panno;
  String? aadharno;
  String? seedlicenceno;
  String? validity;
  double? creditlimit;
  double? sixtydaysoutstanding;
  double? currentoutstanding;
  double? appordervalue;
  int? isactive;
  String? createdby;
  String? createdon;
  String? updatedby;
  String? updatedon;
  String? appordervalueupdatedby;
  String? appordervalueupdatedon;
  int? expirynoofdays;
  String? latitude;
  String? longitude;

  CustomerResponse({this.condition, this.totalcount, this.customerno, this.name, this.address, this.address2, this.postcode, this.statecode, this.statename, this.countrycode, this.countryname, this.salespersoncode, this.salespersonname, this.phoneno, this.emailid, this.contactpersonname, this.mobileno, this.customertype, this.customerpricegroup, this.customerdiscountgroup, this.paymentterm, this.gstregistrationno, this.panno, this.aadharno, this.seedlicenceno, this.validity, this.creditlimit, this.sixtydaysoutstanding, this.currentoutstanding, this.appordervalue, this.isactive, this.createdby, this.createdon, this.updatedby, this.updatedon, this.appordervalueupdatedby, this.appordervalueupdatedon, this.expirynoofdays,this.latitude, this.longitude});

  CustomerResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  totalcount = json['total_count'];
  customerno = json['customer_no'];
  name = json['name'];
  address = json['address'];
  address2 = json['address2'];
  postcode = json['post_code'];
  statecode = json['state_code'];
  statename = json['state_name'];
  countrycode = json['country_code'];
  countryname = json['country_name'];
  salespersoncode = json['sales_person_code'];
  salespersonname = json['sales_person_name'];
  phoneno = json['phone_no'];
  emailid = json['email_id'];
  contactpersonname = json['contact_person_name'];
  mobileno = json['mobile_no'];
  customertype = json['customer_type'];
  customerpricegroup = json['customer_price_group'];
  customerdiscountgroup = json['customer_discount_group'];
  paymentterm = json['payment_term'];
  gstregistrationno = json['gst_registration_no'];
  panno = json['pan_no'];
  aadharno = json['aadhar_no'];
  seedlicenceno = json['seed_licence_no'];
  validity = json['validity'];
  creditlimit = json['credit_limit'];
  sixtydaysoutstanding = json['sixty_days_outstanding'];
  currentoutstanding = json['current_outstanding'];
  appordervalue = json['app_order_value'];
  isactive = json['is_active'];
  createdby = json['created_by'];
  createdon = json['created_on'];
  updatedby = json['updated_by'];
  updatedon = json['updated_on'];
  appordervalueupdatedby = json['app_order_value_updated_by'];
  appordervalueupdatedon = json['app_order_value_updated_on'];
  expirynoofdays = json['expiry_no_of_days'];
  latitude = json['latitude'];
  longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['total_count'] = totalcount;
  data['customer_no'] = customerno;
  data['name'] = name;
  data['address'] = address;
  data['address2'] = address2;
  data['post_code'] = postcode;
  data['state_code'] = statecode;
  data['state_name'] = statename;
  data['country_code'] = countrycode;
  data['country_name'] = countryname;
  data['sales_person_code'] = salespersoncode;
  data['sales_person_name'] = salespersonname;
  data['phone_no'] = phoneno;
  data['email_id'] = emailid;
  data['contact_person_name'] = contactpersonname;
  data['mobile_no'] = mobileno;
  data['customer_type'] = customertype;
  data['customer_price_group'] = customerpricegroup;
  data['customer_discount_group'] = customerdiscountgroup;
  data['payment_term'] = paymentterm;
  data['gst_registration_no'] = gstregistrationno;
  data['pan_no'] = panno;
  data['aadhar_no'] = aadharno;
  data['seed_licence_no'] = seedlicenceno;
  data['validity'] = validity;
  data['credit_limit'] = creditlimit;
  data['sixty_days_outstanding'] = sixtydaysoutstanding;
  data['current_outstanding'] = currentoutstanding;
  data['app_order_value'] = appordervalue;
  data['is_active'] = isactive;
  data['created_by'] = createdby;
  data['created_on'] = createdon;
  data['updated_by'] = updatedby;
  data['updated_on'] = updatedon;
  data['app_order_value_updated_by'] = appordervalueupdatedby;
  data['app_order_value_updated_on'] = appordervalueupdatedon;
  data['expiry_no_of_days'] = expirynoofdays;
  data['latitude'] = latitude;
  data['longitude'] = longitude;
  return data;
  }
  }
