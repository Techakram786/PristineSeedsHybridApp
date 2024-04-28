
class ZoneModal {
  String? condition;
  String? message;
  String? zone;

  ZoneModal({this.condition, this.message, this.zone});

  ZoneModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    data['zone'] = zone;
    return data;
  }
}

