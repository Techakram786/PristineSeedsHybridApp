/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class SuperVisorModal {
  String? condition;
  String? manageremailid;

  SuperVisorModal({this.condition, this.manageremailid});

  SuperVisorModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    manageremailid = json['manager_email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['manager_email_id'] = manageremailid;
    return data;
  }
}

