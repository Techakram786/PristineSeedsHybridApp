class SeasonGetModel {
  String? condition;
  String? message;
  String? seasonCode;
  String? seasonName;
  String? createdBy;
  String? createdOn;

  SeasonGetModel(
      {this.condition,
        this.message,
        this.seasonCode,
        this.seasonName,
        this.createdBy,
        this.createdOn});

  SeasonGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    seasonCode = json['season_code'];
    seasonName = json['season_name'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['season_code'] = this.seasonCode;
    data['season_name'] = this.seasonName;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}