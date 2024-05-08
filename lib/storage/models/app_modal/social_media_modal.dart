class BaseResponseModal {
 late String message;
 late List<SocialMediaModal>? data;
 late String code;


  BaseResponseModal.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <SocialMediaModal>[];
      json['data'].forEach((v) {
        data?.add(SocialMediaModal.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class SocialMediaModal {
 late String link;
 late String icon;


  SocialMediaModal.fromJson(Map<String, dynamic> json) {
    link = json['link']??"";
    icon = json['icon']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['icon'] = icon;
    return data;
  }
}