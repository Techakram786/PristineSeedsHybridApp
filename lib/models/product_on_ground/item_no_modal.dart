
class ItemNoModal {
  String? condition;
  String? message;
  String? totalRows;
  String? itemNo;
  String? name;
  String? baseUnitOfMeasure;
  String? categoryCode;
  String? classOfSeeds;
  double? fgPackSize;
  String? itemType;
  double? secondaryPacking;
  String? groupCode;
  String? cropType;
  String? hybridType;
  String? maleFemale;
  String? itemCategoryCode;
  String? gstGroupCode;
  String? hsnCode;
  double? unitPrice;
  String? productionCode;
  String? marketingCode;
  int? active;
  String? imageUrl;
  int? isVisible;
  String? updatedBy;
  String? updatedOn;
  String? description;
  String? groupName;

  ItemNoModal(
      {this.condition,
      this.message,
        this.totalRows,
        this.itemNo,
        this.name,
        this.baseUnitOfMeasure,
        this.categoryCode,
        this.classOfSeeds,
        this.fgPackSize,
        this.itemType,
        this.secondaryPacking,
        this.groupCode,
        this.cropType,
        this.hybridType,
        this.maleFemale,
        this.itemCategoryCode,
        this.gstGroupCode,
        this.hsnCode,
        this.unitPrice,
        this.productionCode,
        this.marketingCode,
        this.active,
        this.imageUrl,
        this.isVisible,
        this.updatedBy,
        this.updatedOn,
        this.description,
        this.groupName});

  ItemNoModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    itemNo = json['item_no'];
    name = json['name'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    categoryCode = json['category_code'];
    classOfSeeds = json['class_of_seeds'];
    fgPackSize = json['fg_pack_size'];
    itemType = json['item_type'];
    secondaryPacking = json['secondary_packing'];
    groupCode = json['group_code'];
    cropType = json['crop_type'];
    hybridType = json['hybrid_type'];
    maleFemale = json['male_female'];
    itemCategoryCode = json['item_category_code'];
    gstGroupCode = json['gst_group_code'];
    hsnCode = json['hsn_code'];
    unitPrice = json['unit_price'];
    productionCode = json['production_code'];
    marketingCode = json['marketing_code'];
    active = json['active'];
    imageUrl = json['image_url'];
    isVisible = json['is_visible'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    description = json['description'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['item_no'] = this.itemNo;
    data['name'] = this.name;
    data['base_unit_of_measure'] = this.baseUnitOfMeasure;
    data['category_code'] = this.categoryCode;
    data['class_of_seeds'] = this.classOfSeeds;
    data['fg_pack_size'] = this.fgPackSize;
    data['item_type'] = this.itemType;
    data['secondary_packing'] = this.secondaryPacking;
    data['group_code'] = this.groupCode;
    data['crop_type'] = this.cropType;
    data['hybrid_type'] = this.hybridType;
    data['male_female'] = this.maleFemale;
    data['item_category_code'] = this.itemCategoryCode;
    data['gst_group_code'] = this.gstGroupCode;
    data['hsn_code'] = this.hsnCode;
    data['unit_price'] = this.unitPrice;
    data['production_code'] = this.productionCode;
    data['marketing_code'] = this.marketingCode;
    data['active'] = this.active;
    data['image_url'] = this.imageUrl;
    data['is_visible'] = this.isVisible;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['description'] = this.description;
    data['group_name'] = this.groupName;
    return data;
  }

}

