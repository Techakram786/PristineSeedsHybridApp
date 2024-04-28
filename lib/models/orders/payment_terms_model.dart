class PaymentTermModel {
  String? condition;
  String? message;
  String? code;
  String? name;
  int? noOfDays;
  String? updatedOn;
  String? updatedBy;

  PaymentTermModel(
      {
        this.condition,
        this.message,
        this.code,
        this.name,
        this.noOfDays,
        this.updatedOn,
        this.updatedBy});

  PaymentTermModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    code = json['code'];
    name = json['name'];
    noOfDays = json['no_of_days'];
    updatedOn = json['updated_on'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['code'] = this.code;
    data['name'] = this.name;
    data['no_of_days'] = this.noOfDays;
    data['updated_on'] = this.updatedOn;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}