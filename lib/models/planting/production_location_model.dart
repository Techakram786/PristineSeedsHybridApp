class ProductionLocationModel {
  String? condition;
  String? message;
  String? locationCode;
  String? locationName;
  String? createdBy;
  String? createdOn;

  ProductionLocationModel(
      {this.condition,
        this.message,
        this.locationCode,
        this.locationName,
        this.createdBy,
        this.createdOn});

  ProductionLocationModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    locationCode = json['location_code'];
    locationName = json['location_name'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['location_code'] = this.locationCode;
    data['location_name'] = this.locationName;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}