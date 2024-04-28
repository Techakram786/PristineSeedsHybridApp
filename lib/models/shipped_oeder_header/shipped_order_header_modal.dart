
class ShippedOrderHeaderModal {
  String? condition;
  String? message;
  String? dcNo;
  String? deliveryOrderNo;
  String? postingDate;
  String? deliveryDate;
  String? dcRemarks;
  String? totalLineQuantity;
  String? lrNo;
  String? truckNo;
  String? transporterName;
  String? salesOrderNo;
  String? createdBy;
  String? createdOn;
  List<Sol>? sol;

  ShippedOrderHeaderModal(
      {this.condition,
        this.dcNo,
        this.message,
        this.deliveryOrderNo,
        this.postingDate,
        this.deliveryDate,
        this.dcRemarks,
        this.totalLineQuantity,
        this.lrNo,
        this.truckNo,
        this.transporterName,
        this.salesOrderNo,
        this.createdBy,
        this.createdOn,
        this.sol});

  ShippedOrderHeaderModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    dcNo = json['dc_no'];
    deliveryOrderNo = json['delivery_order_no'];
    postingDate = json['posting_date'];
    deliveryDate = json['delivery_date'];
    dcRemarks = json['dc_remarks'];
    totalLineQuantity = json['total_line_quantity'];
    lrNo = json['lr_no'];
    truckNo = json['truck_no'];
    transporterName = json['transporter_name'];
    salesOrderNo = json['sales_order_no'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    if (json['sol'] != null) {
      sol = <Sol>[];
      json['sol'].forEach((v) {
        sol!.add(new Sol.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['dc_no'] = this.dcNo;
    data['delivery_order_no'] = this.deliveryOrderNo;
    data['posting_date'] = this.postingDate;
    data['delivery_date'] = this.deliveryDate;
    data['dc_remarks'] = this.dcRemarks;
    data['total_line_quantity'] = this.totalLineQuantity;
    data['lr_no'] = this.lrNo;
    data['truck_no'] = this.truckNo;
    data['transporter_name'] = this.transporterName;
    data['sales_order_no'] = this.salesOrderNo;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    if (this.sol != null) {
      data['sol'] = this.sol!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sol {
  String? documentNo;
  String? lineNo;
  String? type;
  String? variantCode;
  String? description;
  String? doNo;
  String? doLineNo;
  String? blanketOrderNo;
  String? blanketOrderLineNo;
  String? description2;
  String? locationCode;
  double? quantity;
  String? unitOfMeasureCode;
  String? unitOfMeasure;
  int? applToItemEntry;
  String? shipmentDate;
  int? quantityInvoiced;

  Sol(
      {this.documentNo,
        this.lineNo,
        this.type,
        this.variantCode,
        this.description,
        this.doNo,
        this.doLineNo,
        this.blanketOrderNo,
        this.blanketOrderLineNo,
        this.description2,
        this.locationCode,
        this.quantity,
        this.unitOfMeasureCode,
        this.unitOfMeasure,
        this.applToItemEntry,
        this.shipmentDate,
        this.quantityInvoiced});

  Sol.fromJson(Map<String, dynamic> json) {
    documentNo = json['document_no'];
    lineNo = json['line_no'];
    type = json['type'];
    variantCode = json['variant_code'];
    description = json['description'];
    doNo = json['do_no'];
    doLineNo = json['do_line_no'];
    blanketOrderNo = json['blanket_order_no'];
    blanketOrderLineNo = json['blanket_order_line_no'];
    description2 = json['description_2'];
    locationCode = json['location_code'];
    quantity = json['quantity'];
    unitOfMeasureCode = json['unit_of_measure_code'];
    unitOfMeasure = json['unit_of_measure'];
    applToItemEntry = json['appl_to_Item_entry'];
    shipmentDate = json['shipment_Date'];
    quantityInvoiced = json['quantity_invoiced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_no'] = this.documentNo;
    data['line_no'] = this.lineNo;
    data['type'] = this.type;
    data['variant_code'] = this.variantCode;
    data['description'] = this.description;
    data['do_no'] = this.doNo;
    data['do_line_no'] = this.doLineNo;
    data['blanket_order_no'] = this.blanketOrderNo;
    data['blanket_order_line_no'] = this.blanketOrderLineNo;
    data['description_2'] = this.description2;
    data['location_code'] = this.locationCode;
    data['quantity'] = this.quantity;
    data['unit_of_measure_code'] = this.unitOfMeasureCode;
    data['unit_of_measure'] = this.unitOfMeasure;
    data['appl_to_Item_entry'] = this.applToItemEntry;
    data['shipment_Date'] = this.shipmentDate;
    data['quantity_invoiced'] = this.quantityInvoiced;
    return data;
  }
}