class FSIOBSIOLotDetailsGetModel {
  String? condition;
  String? documentNo;
  String? message;
  String? itemNo;
  String? lotNo;
  double? qty;
  double? noOfBags;
  String? parentItemNo;
  String? cropCode;
  String? varietyCode;
  String? itemProductGroupCode;
  String? itemClassOfSeeds;
  String? itemCropType;
  String? itemName;

  FSIOBSIOLotDetailsGetModel(
      {this.condition,
        this.message,
        this.documentNo,
        this.itemNo,
        this.lotNo,
        this.qty,
        this.noOfBags,
        this.parentItemNo,
        this.cropCode,
        this.varietyCode,
        this.itemProductGroupCode,
        this.itemClassOfSeeds,
        this.itemCropType,
        this.itemName});

  FSIOBSIOLotDetailsGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    documentNo = json['document_no'];
    message = json['message'];
    itemNo = json['item_no'];
    lotNo = json['lot_no'];
    qty = json['qty'];
    noOfBags = json['no_of_bags'];
    parentItemNo = json['parent_item_no'];
    cropCode = json['crop_code'];
    varietyCode = json['variety_code'];
    itemProductGroupCode = json['item_product_group_code'];
    itemClassOfSeeds = json['item_class_of_seeds'];
    itemCropType = json['item_crop_type'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['document_no'] = this.documentNo;
    data['message'] = this.message;
    data['item_no'] = this.itemNo;
    data['lot_no'] = this.lotNo;
    data['qty'] = this.qty;
    data['no_of_bags'] = this.noOfBags;
    data['parent_item_no'] = this.parentItemNo;
    data['crop_code'] = this.cropCode;
    data['variety_code'] = this.varietyCode;
    data['item_product_group_code'] = this.itemProductGroupCode;
    data['item_class_of_seeds'] = this.itemClassOfSeeds;
    data['item_crop_type'] = this.itemCropType;
    data['item_name'] = this.itemName;
    return data;
  }
}