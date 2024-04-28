class NotificationModel {
  String? condition;
  int? id;
  String? emailid;
  String? documenttype;
  String? documentno;
  String? subdocumentno;
  String? message;
  int? acknowledgement;
  String? createdon;
  String? updatedon;
  String? createdby;

  NotificationModel({this.condition, this.id, this.emailid, this.documenttype, this.documentno, this.subdocumentno, this.message, this.acknowledgement, this.createdon, this.updatedon, this.createdby});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    emailid = json['email_id'];
    documenttype = json['document_type'];
    documentno = json['document_no'];
    subdocumentno = json['sub_document_no'];
    message = json['message'];
    acknowledgement = json['acknowledgement'];
    createdon = json['created_on'];
    updatedon = json['updated_on'];
    createdby = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['id'] = id;
    data['email_id'] = emailid;
    data['document_type'] = documenttype;
    data['document_no'] = documentno;
    data['sub_document_no'] = subdocumentno;
    data['message'] = message;
    data['acknowledgement'] = acknowledgement;
    data['created_on'] = createdon;
    data['updated_on'] = updatedon;
    data['created_by'] = createdby;
    return data;
  }
}
