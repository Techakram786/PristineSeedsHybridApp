class PlantingHeaderModel {
  String? condition;
  String? message;
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
  List<Lines>? lines;

  PlantingHeaderModel(
      {this.condition,
        this.message,
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
        this.navMessage,
        this.lines});

  PlantingHeaderModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
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
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? code;
  int? lineNo;
  String? documentType;
  String? documentNo;
  String? organizerCode;
  String? organizerName;
  String? parentMaleLot;
  String? parentFemaleLot;
  String? parentOtherLot;
  String? growerOwnerCode;
  String? growerLandOwnerName;
  String? supervisorName;
  String? cropCode;
  String? varietyCode;
  String? itemProductGroupCode;
  String? itemClassOfSeeds;
  String? itemCropType;
  String? itemName;
  double? expectedYield;
  String? revisedYieldRaw;
  int? landLease;
  String? unitOfMeasureCode;
  String? sowingDateMale;
  String? sowingDateFemale;
  String? sowingDateOther;
  double? sowingAreaInAcres;
  double? quantityMale;
  double? quantityFemale;
  double? quantityOther;
  String? createdOn;
  String? productionLotNo;
  double? standingAcres;
  double? pldAcre;
  double? netAcre;
  String? pldReason;
  double? mapSowingAreaInAcres;
  String? mapCordinateLatitude;
  String? mapCordinateLongitude;
  String? mapAllCordinate;

  Lines(
      {this.code,
        this.lineNo,
        this.documentType,
        this.documentNo,
        this.organizerCode,
        this.organizerName,
        this.parentMaleLot,
        this.parentFemaleLot,
        this.parentOtherLot,
        this.growerOwnerCode,
        this.growerLandOwnerName,
        this.supervisorName,
        this.cropCode,
        this.varietyCode,
        this.itemProductGroupCode,
        this.itemClassOfSeeds,
        this.itemCropType,
        this.itemName,
        this.expectedYield,
        this.revisedYieldRaw,
        this.landLease,
        this.unitOfMeasureCode,
        this.sowingDateMale,
        this.sowingDateFemale,
        this.sowingDateOther,
        this.sowingAreaInAcres,
        this.quantityMale,
        this.quantityFemale,
        this.quantityOther,
        this.createdOn,
        this.productionLotNo,
        this.standingAcres,
        this.pldAcre,
        this.netAcre,
        this.pldReason,
        this.mapSowingAreaInAcres,
        this.mapCordinateLatitude,
        this.mapCordinateLongitude,
        this.mapAllCordinate});

  Lines.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    lineNo = json['line_no'];
    documentType = json['document_type'];
    documentNo = json['document_no'];
    organizerCode = json['organizer_code'];
    organizerName = json['organizer_name'];
    parentMaleLot = json['parent_male_lot'];
    parentFemaleLot = json['parent_female_lot'];
    parentOtherLot = json['parent_other_lot'];
    growerOwnerCode = json['grower_owner_code'];
    growerLandOwnerName = json['grower_land_owner_name'];
    supervisorName = json['supervisor_name'];
    cropCode = json['crop_code'];
    varietyCode = json['variety_code'];
    itemProductGroupCode = json['item_product_group_code'];
    itemClassOfSeeds = json['item_class_of_seeds'];
    itemCropType = json['item_crop_type'];
    itemName = json['item_name'];
    expectedYield = json['expected_yield'];
    revisedYieldRaw = json['revised_yield_raw'];
    landLease = json['land_lease'];
    unitOfMeasureCode = json['unit_of_measure_code'];
    sowingDateMale = json['sowing_date_male'];
    sowingDateFemale = json['sowing_date_female'];
    sowingDateOther = json['sowing_date_other'];
    sowingAreaInAcres = json['sowing_area_In_acres'];
    quantityMale = json['quantity_male'];
    quantityFemale = json['quantity_female'];
    quantityOther = json['quantity_other'];
    createdOn = json['created_on'];
    productionLotNo = json['production_lot_no'];
    standingAcres = json['standing_acres'];
    pldAcre = json['pld_acre'];
    netAcre = json['net_acre'];
    pldReason = json['pld_reason'];
    mapSowingAreaInAcres = json['map_sowing_area_In_acres'];
    mapCordinateLatitude = json['map_cordinate_latitude'];
    mapCordinateLongitude = json['map_cordinate_longitude'];
    mapAllCordinate = json['map_all_cordinate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['line_no'] = this.lineNo;
    data['document_type'] = this.documentType;
    data['document_no'] = this.documentNo;
    data['organizer_code'] = this.organizerCode;
    data['organizer_name'] = this.organizerName;
    data['parent_male_lot'] = this.parentMaleLot;
    data['parent_female_lot'] = this.parentFemaleLot;
    data['parent_other_lot'] = this.parentOtherLot;
    data['grower_owner_code'] = this.growerOwnerCode;
    data['grower_land_owner_name'] = this.growerLandOwnerName;
    data['supervisor_name'] = this.supervisorName;
    data['crop_code'] = this.cropCode;
    data['variety_code'] = this.varietyCode;
    data['item_product_group_code'] = this.itemProductGroupCode;
    data['item_class_of_seeds'] = this.itemClassOfSeeds;
    data['item_crop_type'] = this.itemCropType;
    data['item_name'] = this.itemName;
    data['expected_yield'] = this.expectedYield;
    data['revised_yield_raw'] = this.revisedYieldRaw;
    data['land_lease'] = this.landLease;
    data['unit_of_measure_code'] = this.unitOfMeasureCode;
    data['sowing_date_male'] = this.sowingDateMale;
    data['sowing_date_female'] = this.sowingDateFemale;
    data['sowing_date_other'] = this.sowingDateOther;
    data['sowing_area_In_acres'] = this.sowingAreaInAcres;
    data['quantity_male'] = this.quantityMale;
    data['quantity_female'] = this.quantityFemale;
    data['quantity_other'] = this.quantityOther;
    data['created_on'] = this.createdOn;
    data['production_lot_no'] = this.productionLotNo;
    data['standing_acres'] = this.standingAcres;
    data['pld_acre'] = this.pldAcre;
    data['net_acre'] = this.netAcre;
    data['pld_reason'] = this.pldReason;
    data['map_sowing_area_In_acres'] = this.mapSowingAreaInAcres;
    data['map_cordinate_latitude'] = this.mapCordinateLatitude;
    data['map_cordinate_longitude'] = this.mapCordinateLongitude;
    data['map_all_cordinate'] = this.mapAllCordinate;

    return data;
  }
}