class PlantingHeaderGetModel {
  String? condition;
  String? message;
  String? totalRows;
  String? code;
  String? productionCenterLoc;
  String? plantingDate;
  String? dateOfHarvest;
  String? seasonCode;
  String? seasonName;
  String? organizerCode;
  String? organizerName;
  int? status;
  String? createdBy;
  String? createdOn;
  String? completedOn;
  double? totalLandInAcres;
  double? totalSowingAreaInAcres;
  int? navSync;
  String? navMessage;

  PlantingHeaderGetModel(
      {this.condition,
        this.message,
        this.totalRows,
        this.code,
        this.productionCenterLoc,
        this.plantingDate,
        this.dateOfHarvest,
        this.seasonCode,
        this.seasonName,
        this.organizerCode,
        this.organizerName,
        this.status,
        this.createdBy,
        this.createdOn,
        this.completedOn,
        this.totalLandInAcres,
        this.totalSowingAreaInAcres,
        this.navSync,
        this.navMessage});

  PlantingHeaderGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    code = json['code'];
    productionCenterLoc = json['production_center_loc'];
    plantingDate = json['planting_date'];
    dateOfHarvest = json['date_of_harvest'];
    seasonCode = json['season_code'];
    seasonName = json['season_name'];
    organizerCode = json['organizer_code'];
    organizerName = json['organizer_name'];
    status = json['status'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    completedOn = json['completed_on'];
    totalLandInAcres = json['total_land_in_acres'];
    totalSowingAreaInAcres = json['total_sowing_area_in_acres'];
    navSync = json['nav_sync'];
    navMessage = json['nav_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['code'] = this.code;
    data['production_center_loc'] = this.productionCenterLoc;
    data['planting_date'] = this.plantingDate;
    data['date_of_harvest'] = this.dateOfHarvest;
    data['season_code'] = this.seasonCode;
    data['season_name'] = this.seasonName;
    data['organizer_code'] = this.organizerCode;
    data['organizer_name'] = this.organizerName;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['completed_on'] = this.completedOn;
    data['total_land_in_acres'] = this.totalLandInAcres;
    data['total_sowing_area_in_acres'] = this.totalSowingAreaInAcres;
    data['nav_sync'] = this.navSync;
    data['nav_message'] = this.navMessage;
    return data;
  }
}