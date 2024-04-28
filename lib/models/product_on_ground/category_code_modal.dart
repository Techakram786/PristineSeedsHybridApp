class CategoryCodeModal {
  String? condition;
  String? message;
  String? categorycode;
  String? categorydescription;
  String? croptype;
  int? active;
  String? updatedby;
  String? updatedon;

  CategoryCodeModal({this.condition,this.message, this.categorycode, this.categorydescription, this.croptype, this.active, this.updatedby, this.updatedon});

  CategoryCodeModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    categorycode = json['category_code'];
    categorydescription = json['category_description'];
    croptype = json['crop_type'];
    active = json['active'];
    updatedby = json['updated_by'];
    updatedon = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    data['category_code'] = categorycode;
    data['category_description'] = categorydescription;
    data['crop_type'] = croptype;
    data['active'] = active;
    data['updated_by'] = updatedby;
    data['updated_on'] = updatedon;
    return data;
  }
}
