class ItemCategoryMstGetModal {
  String? condition;
  String? categoryCode;
  String? categoryDescription;
  String? cropType;
  int? active;
  String? updatedBy;
  String? updatedOn;

  ItemCategoryMstGetModal(
      {this.condition,
        this.categoryCode,
        this.categoryDescription,
        this.cropType,
        this.active,
        this.updatedBy,
        this.updatedOn});

  ItemCategoryMstGetModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    categoryCode = json['category_code'];
    categoryDescription = json['category_description'];
    cropType = json['crop_type'];
    active = json['active'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['category_code'] = this.categoryCode;
    data['category_description'] = this.categoryDescription;
    data['crop_type'] = this.cropType;
    data['active'] = this.active;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}