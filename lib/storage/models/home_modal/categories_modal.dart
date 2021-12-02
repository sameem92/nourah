class BaseResponse {
 late String message;
 late List<CategoriesModal>? data;
 late String code;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoriesModal>[];
      json['data'].forEach((v) {
        data?.add(new CategoriesModal.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arname'] = this.arname;
    data['enname'] = this.enname;
    data['deleted'] = this.deleted;
    data['suspensed'] = this.suspensed;
    data['created_at'] = this.createdAt;
    return data;
  }
}