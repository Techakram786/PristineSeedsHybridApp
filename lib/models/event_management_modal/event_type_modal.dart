
class EventTypeModal {
  String? condition;
  int? id;
  String? eventtype;
  int? qty;
  double? rate;
  int? parentid;
  String? noofattendee;
  int? isimagerequired;

  EventTypeModal({this.condition, this.id, this.eventtype, this.qty, this.rate, this.parentid, this.noofattendee, this.isimagerequired});

  EventTypeModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    eventtype = json['event_type'];
    qty = json['qty'];
    rate = json['rate'];
    parentid = json['parent_id'];
    noofattendee = json['no_of_attendee'];
    isimagerequired = json['is_image_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['id'] = id;
    data['event_type'] = eventtype;
    data['qty'] = qty;
    data['rate'] = rate;
    data['parent_id'] = parentid;
    data['no_of_attendee'] = noofattendee;
    data['is_image_required'] = isimagerequired;
    return data;
  }
}

