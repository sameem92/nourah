class BaseResponse {
 late String message;
 late List<MessagesModal>? data;
 late String code;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <MessagesModal>[];
      json['data'].forEach((v) {
        data?.add(MessagesModal.fromJson(v));
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

class MessagesModal {
 late int id;
 late int senderId;
 late int receiverId;
 late String message;
 late int parent;
 late String createdAt;
 late String name;
 late String type;

 MessagesModal({required this.type,required this.id,required this.name,required this.message,required this.createdAt});

  MessagesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id']??0;
    receiverId = json['receiver_id']??0;
    message = json['message']??'';
    parent = json['parent']??0;
    type = json['type']??'';
    createdAt = json['created_at']??'';
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['parent'] = parent;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['name'] = name;
    return data;
  }
}