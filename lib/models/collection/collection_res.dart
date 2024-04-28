class CollectionResponse {
  String? condition;
  String? message;
  String? collectioncode;
  double? amount;
  String? date;
  String? partyname;
  String? place;
  String? chqddrtgsno;
  String? drawnonbankname;
  String? depositedbank;
  String? depositedat;
  String? collectiontype;
  String? bank;
  String? dateofreceipt;
  String? remark;
  String? createdby;
  String? createdon;
  int? navsync;

  CollectionResponse({this.condition, this.message, this.collectioncode, this.amount, this.date, this.partyname, this.place, this.chqddrtgsno, this.drawnonbankname, this.depositedbank, this.depositedat, this.collectiontype, this.bank, this.dateofreceipt, this.remark, this.createdby, this.createdon, this.navsync});

  CollectionResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    collectioncode = json['collection_code'];
    amount = json['amount'];
    date = json['date'];
    partyname = json['party_name'];
    place = json['place'];
    chqddrtgsno = json['chq_dd_rtgs_no'];
    drawnonbankname = json['drawn_on_bank_name'];
    depositedbank = json['deposited_bank'];
    depositedat = json['deposited_at'];
    collectiontype = json['collection_type'];
    bank = json['bank'];
    dateofreceipt = json['date_of_receipt'];
    remark = json['remark'];
    createdby = json['created_by'];
    createdon = json['created_on'];
    navsync = json['nav_sync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    data['collection_code'] = collectioncode;
    data['amount'] = amount;
    data['date'] = date;
    data['party_name'] = partyname;
    data['place'] = place;
    data['chq_dd_rtgs_no'] = chqddrtgsno;
    data['drawn_on_bank_name'] = drawnonbankname;
    data['deposited_bank'] = depositedbank;
    data['deposited_at'] = depositedat;
    data['collection_type'] = collectiontype;
    data['bank'] = bank;
    data['date_of_receipt'] = dateofreceipt;
    data['remark'] = remark;
    data['created_by'] = createdby;
    data['created_on'] = createdon;
    data['nav_sync'] = navsync;
    return data;
  }
}
