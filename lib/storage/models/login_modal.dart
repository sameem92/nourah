class LoginModal {
  late String accesstoken;

  LoginModal();
  LoginModal.fromJson(Map<String, dynamic> json) {
    accesstoken = json['accesstoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accesstoken'] = this.accesstoken;
    return data;
  }
}
