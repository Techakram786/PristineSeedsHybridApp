class ExpenseLineResponse {
  String? condition;
  String? documentNo;
  int? expenseId;
  String? expenseName;
  int? expenseAmount;
  String? imageUrl;

  ExpenseLineResponse(
      {this.condition,
        this.documentNo,
        this.expenseId,
        this.expenseName,
        this.expenseAmount,
        this.imageUrl});

  ExpenseLineResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    documentNo = json['document_no'];
    expenseId = json['expense_id'];
    expenseName = json['expense_name'];
    expenseAmount = json['expense_amount'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['document_no'] = this.documentNo;
    data['expense_id'] = this.expenseId;
    data['expense_name'] = this.expenseName;
    data['expense_amount'] = this.expenseAmount;
    data['image_url'] = this.imageUrl;
    return data;
  }
}