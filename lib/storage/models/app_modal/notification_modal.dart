class NotificationsModal {
 late int id;
 late int userId;
 late String notification;
 late String ennotification;
 late int readed;
 late int deleted;
 late String createdAt;

  NotificationsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    notification = json['notification'];
    ennotification = json['ennotification'];
    readed = json['readed'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['notification'] = this.notification;
    data['ennotification'] = this.ennotification;
    data['readed'] = this.readed;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    return data;
  }
}
