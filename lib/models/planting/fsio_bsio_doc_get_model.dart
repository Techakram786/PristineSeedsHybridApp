class FSIOBSIODocGetModel {
  String? condition;
  String? message;
  String? documentNo;
  String? documentType;

  FSIOBSIODocGetModel({
    this.condition,
    this.message,
    this.documentNo,
    this.documentType});

  FSIOBSIODocGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    documentNo = json['document_no'];
    documentType = json['document_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['document_no'] = this.documentNo;
    data['document_type'] = this.documentType;
    return data;
  }
}