class CustomerTypeResponse {
  String? condition;
  String? customerType;

  CustomerTypeResponse({this.condition, this.customerType});

  CustomerTypeResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    customerType = json['CustomerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['CustomerType'] = customerType;
    return data;
  }
}
