class UserExpenseModel {
  String? condition;
  String? message;
  String? documentNo;
  String? grade;
  String? createdBy;
  String? createdOn;
  String? daCode;
  String? daName;
  double? daAmount;
  String? remarks;
  String? expenseDate;
  int? isDone;
  String? completedOn;
  int? isApprove;
  String? approveStatus;
  String? approveBy;
  String? approveOn;
  List<Lines>? lines;

  UserExpenseModel(
      {this.condition,
        this.message,
        this.documentNo,
        this.grade,
        this.createdBy,
        this.createdOn,
        this.daCode,
        this.daName,
        this.daAmount,
        this.remarks,
        this.expenseDate,
        this.isDone,
        this.completedOn,
        this.isApprove,
        this.approveStatus,
        this.approveBy,
        this.approveOn,
        this.lines});

  UserExpenseModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    documentNo = json['document_no'];
    grade = json['grade'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    daCode = json['da_code'];
    daName = json['da_name'];
    daAmount = json['da_amount'];
    remarks = json['remarks'];
    expenseDate = json['expense_date'];
    isDone = json['is_done'];
    completedOn = json['completed_on'];
    isApprove = json['is_approve'];
    approveStatus = json['approve_status'];
    approveBy = json['approve_by'];
    approveOn = json['approve_on'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['document_no'] = this.documentNo;
    data['grade'] = this.grade;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['da_code'] = this.daCode;
    data['da_name'] = this.daName;
    data['da_amount'] = this.daAmount;
    data['remarks'] = this.remarks;
    data['expense_date'] = this.expenseDate;
    data['is_done'] = this.isDone;
    data['completed_on'] = this.completedOn;
    data['is_approve'] = this.isApprove;
    data['approve_status'] = this.approveStatus;
    data['approve_by'] = this.approveBy;
    data['approve_on'] = this.approveOn;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? documentNo;
  int? expenseId;
  String? expenseName;
  double? expenseAmount;
  String? imageUrl;

  Lines(
      {this.documentNo,
        this.expenseId,
        this.expenseName,
        this.expenseAmount,
        this.imageUrl});

  Lines.fromJson(Map<String, dynamic> json) {
    documentNo = json['document_no'];
    expenseId = json['expense_id'];
    expenseName = json['expense_name'];
    expenseAmount = json['expense_amount'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_no'] = this.documentNo;
    data['expense_id'] = this.expenseId;
    data['expense_name'] = this.expenseName;
    data['expense_amount'] = this.expenseAmount;
    data['image_url'] = this.imageUrl;
    return data;
  }
}