
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:producer_family_app/chat/message.dart';

class FirebaseApi {

  static Future uploadMessage({String idUser='',String idFamily='',String idOrder='',String idDriver='', String message=''}) async {
    final refMessages =
    FirebaseFirestore.instance.collection('chats/$idOrder/messages');

    final newMessage = Message(
      idUser: idUser,
      idFamily: idFamily,
      idOrder: idOrder,
      idDriver: idDriver,
      message: message,
    );
    await refMessages.add(newMessage.toJson());}


    Stream <QuerySnapshot> getMessages() async* {
    yield* FirebaseFirestore.instance.collection('chats').snapshots();
    }
}