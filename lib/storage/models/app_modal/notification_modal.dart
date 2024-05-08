class NotificationsModal {
 late int id;
 late int userId;
 late String notification;
 late String ennotification;
 late int readed;
 late int deleted;
 late String createdAt;

  NotificationsModal.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    userId = json['user_id']??0;
    notification = json['notification']??"";
    ennotification = json['ennotification']??"";
    readed = json['readed']??0;
    deleted = json['deleted']??0;
    createdAt = json['created_at']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['notification'] = notification;
    data['ennotification'] = ennotification;
    data['readed'] = readed;
    data['deleted'] = deleted;
    data['created_at'] = createdAt;
    return data;
  }
}
