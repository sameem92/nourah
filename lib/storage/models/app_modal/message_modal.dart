class BaseResponse {
 late String message;
 late List<MessagesModal>? data;
 late String code;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <MessagesModal>[];
      json['data'].forEach((v) {
        data?.add(new MessagesModal.fromJson(v));
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

class MessagesModal {
 late int id;
 late int senderId;
 late int receiverId;
 late String message;
 late int parent;
 late String createdAt;
 late String name;



  MessagesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message']??'';
    parent = json['parent'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['message'] = this.message;
    data['parent'] = this.parent;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    return data;
  }
}