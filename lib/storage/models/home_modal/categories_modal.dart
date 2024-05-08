class BaseResponse {
 late String message;
 late List<CategoriesModal>? data;
 late String code;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoriesModal>[];
      json['data'].forEach((v) {
        data?.add(CategoriesModal.fromJson(v));
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

class CategoriesModal {
 late int id;
 late String arname;
 late String enname;
 late int deleted;
 late int suspensed;
 late String createdAt;
 bool selected = false;

  

  CategoriesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arname = json['arname'];
    enname = json['enname'];
    deleted = json['deleted'];
    suspensed = json['suspensed'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arname'] = arname;
    data['enname'] = enname;
    data['deleted'] = deleted;
    data['suspensed'] = suspensed;
    data['created_at'] = createdAt;
    return data;
  }
}