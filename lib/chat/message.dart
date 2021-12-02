import 'package:flutter/material.dart';


class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String idUser;
  final String message;
  final String idFamily;
  final String idDriver;
  final String idOrder;
  // final DateTime createdAt;

  const Message({
    required this.idUser,
    required this.idFamily,
    required this.idDriver,
    required this.message,
    required this.idOrder,
    // required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
    idUser: json['idUser'],
    message: json['message'],
    idOrder: json['idOrder'],
    idDriver: json['idDriver'],
    idFamily: json['idFamily'],
    // createdAt: Utils.toDateTime(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'message': message,
    'idOrder': idOrder,
    'idFamily': idFamily,
    'idDriver': idDriver,
    // 'createdAt': Utils.fromDateTimeToJson(createdAt),
  };
}