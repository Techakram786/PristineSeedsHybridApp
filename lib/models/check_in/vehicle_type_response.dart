class VehicleTypeResponse{
  String? condition;
  String? message;
  int? id;
  String? vehicleType;
  String? grade;
  String? ownerType;
  String? rateType;
  double? ratePerKm;
  int? isMaintainKm;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  int? isuniversal;

  VehicleTypeResponse(
      {
        this.condition,
        this.message,
        this.id,
        this.vehicleType,
        this.grade,
        this.ownerType,
        this.rateType,
        this.ratePerKm,
        this.isMaintainKm,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.isuniversal});

  VehicleTypeResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    id = json['id'];
    vehicleType = json['vehicle_type'];
    grade = json['grade'];
    ownerType = json['owner_type'];
    rateType = json['rate_type'];
    ratePerKm = json['rate_per_km'];
    isMaintainKm = json['is_maintain_km'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    isuniversal = json['is_universal'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['id'] = this.id;
    data['vehicle_type'] = this.vehicleType;
    data['grade'] = this.grade;
    data['owner_type'] = this.ownerType;
    data['rate_type'] = this.rateType;
    data['rate_per_km'] = this.ratePerKm;
    data['is_maintain_km'] = this.isMaintainKm;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['is_universal'] = isuniversal;
    return data;
  }
}