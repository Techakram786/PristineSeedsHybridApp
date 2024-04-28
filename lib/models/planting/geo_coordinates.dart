class GeoCoordinates {
  int? id;
  double? fromLatitude;
  double? fromLongitude;

  GeoCoordinates(
      {
        this.fromLatitude,
        this.fromLongitude,
       });

  GeoCoordinates.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']):json['id'];
    fromLatitude = json['from_latitude'] is String ? double.tryParse(json['from_latitude']) : json['from_latitude'];
    fromLongitude = json['from_longitude'] is String ? double.tryParse(json['from_longitude']) : json['from_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_latitude'] = this.fromLatitude;
    data['from_longitude'] = this.fromLongitude;
    return data;
  }
}