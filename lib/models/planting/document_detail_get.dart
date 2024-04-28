class DocumentDetailGet {
  String? condition;
  String? message;
  String? cropCode;
  String? baseUnitOfMeasure;
  String? varietyCode;
  String? itemProductGroupCode;
  String? itemClassOfSeeds;
  String? itemCropType;

  DocumentDetailGet(
      {this.condition,
        this.message,
        this.cropCode,
        this.baseUnitOfMeasure,
        this.varietyCode,
        this.itemProductGroupCode,
        this.itemClassOfSeeds,
        this.itemCropType});

  DocumentDetailGet.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    cropCode = json['crop_code'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    varietyCode = json['variety_code'];
    itemProductGroupCode = json['item_product_group_code'];
    itemClassOfSeeds = json['item_class_of_seeds'];
    itemCropType = json['item_crop_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['crop_code'] = this.cropCode;
    data['base_unit_of_measure'] = this.baseUnitOfMeasure;
    data['variety_code'] = this.varietyCode;
    data['item_product_group_code'] = this.itemProductGroupCode;
    data['item_class_of_seeds'] = this.itemClassOfSeeds;
    data['item_crop_type'] = this.itemCropType;
    return data;
  }
}