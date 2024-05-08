class BaseResponse {
 late String message;
 late List<CategoriesModalFamily>? data;
 late String code;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CategoriesModalFamily>[];
      json['data'].forEach((v) {
        data?.add(CategoriesModalFamily.fromJson(v));
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

class CategoriesModalFamily {
 late int? id;
 late int? userId;
 late String arname;
 late String enname;
 late int? deleted;
 late String? createdAt;

 CategoriesModalFamily({required this.arname,required this.enname,required this.id});

  CategoriesModalFamily.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    userId = json['user_id']??'';
    arname = json['arname']??'';
    enname = json['enname']??'';
    deleted = json['deleted']??'';
    createdAt = json['created_at']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id??'';
    data['user_id'] = userId;
    data['arname'] = arname;
    data['enname'] = enname;
    data['deleted'] = deleted;
    data['created_at'] = createdAt;
    return data;
  }
}

