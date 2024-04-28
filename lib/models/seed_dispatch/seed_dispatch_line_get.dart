class  SeedDispatchLineHeaderModal {
  String? condition;
  String? message;
  List<HeaderImage?>? headerimages;
  String? dispatchNo;
  String? refrenceNo;
  String? documentType;
  String? date;
  String? locationName;
  String? locationCode;
  String? supervisor;
  String? transporter;
  String? organizerName;
  String? organizerCode;
  String? truckNumber;
  String? seasonCode;
  String? campAt;
  String? remarks;
  String? createdOn;
  String? createdBy;
  int? status;
  String? navSync;
  String? navMessage;
  String? completedon;
  double? frightamount;

  List<Lines>? lines;

  SeedDispatchLineHeaderModal(
      {this.condition,
        this.message,
        this.headerimages,
        this.dispatchNo,
        this.refrenceNo,
        this.documentType,
        this.date,
        this.locationName,
        this.locationCode,
        this.supervisor,
        this.transporter,
        this.organizerName,
        this.organizerCode,
        this.truckNumber,
        this.seasonCode,
        this.campAt,
        this.remarks,
        this.createdOn,
        this.createdBy,
        this.status,
        this.navSync,
        this.navMessage,
        this.completedon,
        this.frightamount,
        this.lines});

  SeedDispatchLineHeaderModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    if (json['header_images'] != null) {
      headerimages = <HeaderImage>[];
      json['header_images'].forEach((v) {
        headerimages!.add(HeaderImage.fromJson(v));
      });
    }
    dispatchNo = json['dispatch_no'];
    refrenceNo = json['refrence_no'];
    documentType = json['document_type'];
    date = json['date'];
    locationName = json['location_name'];
    locationCode = json['location_code'];
    supervisor = json['supervisor'];
    transporter = json['transporter'];
    organizerName = json['organizer_name'];
    organizerCode = json['organizer_code'];
    truckNumber = json['truck_number'];
    seasonCode = json['season_code'];
    campAt = json['camp_at'];
    remarks = json['remarks'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    status = json['status'];
    navSync = json['nav_sync'];
    navMessage = json['nav_message'];
    completedon = json['completed_on'];
    frightamount = json['fright_amount'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['header_images'] =headerimages != null ? headerimages!.map((v) => v?.toJson()).toList() : null;
    data['dispatch_no'] = this.dispatchNo;
    data['refrence_no'] = this.refrenceNo;
    data['document_type'] = this.documentType;
    data['date'] = this.date;
    data['location_name'] = this.locationName;
    data['location_code'] = this.locationCode;
    data['supervisor'] = this.supervisor;
    data['transporter'] = this.transporter;
    data['organizer_name'] = this.organizerName;
    data['organizer_code'] = this.organizerCode;
    data['truck_number'] = this.truckNumber;
    data['season_code'] = this.seasonCode;
    data['camp_at'] = this.campAt;
    data['remarks'] = this.remarks;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['status'] = this.status;
    data['nav_sync'] = this.navSync;
    data['nav_message'] = this.navMessage;
    data['completed_on'] = completedon;
    data['fright_amount'] = frightamount;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? dispatchNo;
  int? lineNo;
  String? farmerCode;
  String? farmerName;
  String? lotNumber;
  String? categoryCode;
  String?  itemgroupcode;
  String? itemNo;
  double? quantity;
  double? companybags;
  double? farmerbags;
  double? numberOfBags;
  String? createdOn;
  String? remarks;
  double? moisturePrcnt;
  double? harvestedAcreage;
  int? got;
  String? updatedOn;
  String? updatedBy;
  Lines(
      {this.dispatchNo,
        this.lineNo,
        this.farmerCode,
        this.farmerName,
        this.lotNumber,
        this.categoryCode,
        this.itemgroupcode,
        this.itemNo,
        this.quantity,
        this.companybags,
        this.farmerbags,
        this.numberOfBags,
        this.createdOn,
        this.remarks,
        this.moisturePrcnt,
        this.harvestedAcreage,
        this.got,
        this.updatedOn,
        this.updatedBy});

  Lines.fromJson(Map<String, dynamic> json) {
    dispatchNo = json['dispatch_no'];
    lineNo = json['line_no'];
    farmerCode = json['farmer_code'];
    farmerName = json['farmer_name'];
    lotNumber = json['lot_number'];
    categoryCode = json['category_code'];
    itemgroupcode = json['item_group_code'];
    itemNo = json['item_no'];
    quantity = json['quantity'];
    companybags = json['company_bags'];
    farmerbags = json['farmer_bags'];
    numberOfBags = json['number_of_bags'];
    createdOn = json['created_on'];
    remarks = json['remarks'];
    moisturePrcnt = json['moisture_prcnt'];
    harvestedAcreage = json['harvested_acreage'];
    got = json['got'];
    updatedOn = json['updated_on'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dispatch_no'] = this.dispatchNo;
    data['line_no'] = this.lineNo;
    data['farmer_code'] = this.farmerCode;
    data['farmer_name'] = this.farmerName;
    data['lot_number'] = this.lotNumber;
    data['category_code'] = this.categoryCode;
    data['item_group_code'] = this.itemgroupcode;
    data['item_no'] = this.itemNo;
    data['quantity'] = this.quantity;
    data['company_bags'] = this.companybags;
    data['farmer_bags'] = this.farmerbags;
    data['number_of_bags'] = this.numberOfBags;
    data['created_on'] = this.createdOn;
    data['remarks'] = this.remarks;
    data['moisture_prcnt'] = this.moisturePrcnt;
    data['harvested_acreage'] = this.harvestedAcreage;
    data['got'] = this.got;
    data['updated_on'] = this.updatedOn;
    data['updated_by'] = this.updatedBy;
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