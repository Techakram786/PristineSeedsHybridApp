class CustomerRequestApproverResponse {
  String? condition;
  String? pendingCount;
  String? approvedCount;
  String? rejectedCount;
  String? requestNo;
  String? name;
  String? address;
  String? contact;
  String? phoneNo;
  String? salesPersonCode;
  String? countryRegionCode;
  String? postCode;
  String? email;
  String? mobilePhoneNo;
  String? gstRegistractionNo;
  String? gstRegistractionType;
  String? gstCustomerType;
  String? panNo;
  String? stateCode;
  String? zone;
  String? district;
  String? region;
  String? taluka;
  String? customerType;
  String? vendorType;
  String? territoryType;
  String? seedLicenseNo;
  String? status;
  String? createdBy;
  String? createdOn;
  String? updatedOn;
  int? isApprove;
  String? approveBy;
  String? approveRemark;
  String? approveOn;

  CustomerRequestApproverResponse(
      {this.condition,
        this.pendingCount,
        this.approvedCount,
        this.rejectedCount,
        this.requestNo,
        this.name,
        this.address,
        this.contact,
        this.phoneNo,
        this.salesPersonCode,
        this.countryRegionCode,
        this.postCode,
        this.email,
        this.mobilePhoneNo,
        this.gstRegistractionNo,
        this.gstRegistractionType,
        this.gstCustomerType,
        this.panNo,
        this.stateCode,
        this.zone,
        this.district,
        this.region,
        this.taluka,
        this.customerType,
        this.vendorType,
        this.territoryType,
        this.seedLicenseNo,
        this.status,
        this.createdBy,
        this.createdOn,
        this.updatedOn,
        this.isApprove,
        this.approveBy,
        this.approveRemark,
        this.approveOn});

  CustomerRequestApproverResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    pendingCount = json['pending_count'];
    approvedCount = json['approved_count'];
    rejectedCount = json['rejected_count'];
    requestNo = json['request_no'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    phoneNo = json['phone_no'];
    salesPersonCode = json['sales_person_code'];
    countryRegionCode = json['country_region_code'];
    postCode = json['post_code'];
    email = json['email'];
    mobilePhoneNo = json['mobile_phone_no'];
    gstRegistractionNo = json['gst_registraction_no'];
    gstRegistractionType = json['gst_registraction_type'];
    gstCustomerType = json['gst_customer_type'];
    panNo = json['pan_no'];
    stateCode = json['state_code'];
    zone = json['zone'];
    district = json['district'];
    region = json['region'];
    taluka = json['taluka'];
    customerType = json['customer_type'];
    vendorType = json['vendor_type'];
    territoryType = json['territory_type'];
    seedLicenseNo = json['seed_license_no'];
    status = json['status'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    isApprove = json['is_approve'];
    approveBy = json['approve_by'];
    approveRemark = json['approve_remark'];
    approveOn = json['approve_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['pending_count'] = this.pendingCount;
    data['approved_count'] = this.approvedCount;
    data['rejected_count'] = this.rejectedCount;
    data['request_no'] = this.requestNo;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['phone_no'] = this.phoneNo;
    data['sales_person_code'] = this.salesPersonCode;
    data['country_region_code'] = this.countryRegionCode;
    data['post_code'] = this.postCode;
    data['email'] = this.email;
    data['mobile_phone_no'] = this.mobilePhoneNo;
    data['gst_registraction_no'] = this.gstRegistractionNo;
    data['gst_registraction_type'] = this.gstRegistractionType;
    data['gst_customer_type'] = this.gstCustomerType;
    data['pan_no'] = this.panNo;
    data['state_code'] = this.stateCode;
    data['zone'] = this.zone;
    data['district'] = this.district;
    data['region'] = this.region;
    data['taluka'] = this.taluka;
    data['customer_type'] = this.customerType;
    data['vendor_type'] = this.vendorType;
    data['territory_type'] = this.territoryType;
    data['seed_license_no'] = this.seedLicenseNo;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['is_approve'] = this.isApprove;
    data['approve_by'] = this.approveBy;
    data['approve_remark'] = this.approveRemark;
    data['approve_on'] = this.approveOn;
    return data;
  }
}