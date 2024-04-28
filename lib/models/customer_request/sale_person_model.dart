class SalePersonResponse{

  String? condition;
  String? message;
  int? totalcount;
  String? code;
  String? name;
  String? updatedon;
  String? updatedby;
  SalePersonResponse({this.condition, this.message, this.totalcount, this.code, this.name, this.updatedon, this.updatedby});
  SalePersonResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  message = json['message'];
  totalcount = json['total_count'];
  code = json['code'];
  name = json['name'];
  updatedon = json['updated_on'];
  updatedby = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['message'] = message;
  data['total_count'] = totalcount;
  data['code'] = code;
  data['name'] = name;
  data['updated_on'] = updatedon;
  data['updated_by'] = updatedby;
  return data;
  }

}