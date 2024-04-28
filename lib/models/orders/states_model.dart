class StateModel {
  String? condition;
  String? stateCode;
  String? stateName;
  int? governmentStateCode;
  String? countryCode;
  String? createdOn;

  StateModel(
      {this.condition,
        this.stateCode,
        this.stateName,
        this.governmentStateCode,
        this.countryCode,
        this.createdOn});

  StateModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    governmentStateCode = json['government_state_code'];
    countryCode = json['country_code'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['government_state_code'] = this.governmentStateCode;
    data['country_code'] = this.countryCode;
    data['created_on'] = this.createdOn;
    return data;
  }
}