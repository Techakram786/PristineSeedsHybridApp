class PasswordResponse{
  String? condition;
  String? message;

  PasswordResponse({this.condition, this.message});

  PasswordResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    return data;
  }
}