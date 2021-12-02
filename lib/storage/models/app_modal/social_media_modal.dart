class BaseResponseModal {
 late String message;
 late List<SocialMediaModal>? data;
 late String code;


  BaseResponseModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SocialMediaModal>[];
      json['data'].forEach((v) {
        data?.add(new SocialMediaModal.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class SocialMediaModal {
 late String link;
 late String icon;


  SocialMediaModal.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['icon'] = this.icon;
    return data;
  }
}