class VendarTypeResponse{

  String? condition;
  String? vendorType;
  VendarTypeResponse({this.condition, this.vendorType});

  VendarTypeResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  vendorType = json['VendorType'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['VendorType'] = vendorType;
  return data;
  }


}