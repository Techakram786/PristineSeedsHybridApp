class ItemGroupCategory {
  String? condition;
  String? groupcode;
  String? groupname;
  String? description;
  String? categorycode;
  String? imageurl;
  String? updatedon;
  String? updatedby;

  ItemGroupCategory({this.condition, this.groupcode, this.groupname, this.description, this.categorycode, this.imageurl, this.updatedon, this.updatedby});

  ItemGroupCategory.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    groupcode = json['group_code'];
    groupname = json['group_name'];
    description = json['description'];
    categorycode = json['category_code'];
    imageurl = json['image_url'];
    updatedon = json['updated_on'];
    updatedby = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['group_code'] = groupcode;
    data['group_name'] = groupname;
    data['description'] = description;
    data['category_code'] = categorycode;
    data['image_url'] = imageurl;
    data['updated_on'] = updatedon;
    data['updated_by'] = updatedby;
    return data;
  }
}