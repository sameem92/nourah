// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:producer_family_app/chat/firebaseApi.dart';
// import 'package:producer_family_app/style/style_text.dart';
// import 'message_widge.dart';
//
// class MessagesWidget extends StatelessWidget {
//   final String idSender;
//
//   const MessagesWidget({
//     required this.idSender,
//   });
//
//   @override
//   Widget build(BuildContext context){
//    return   StreamBuilder<QuerySnapshot>(
//         stream: FirebaseApi().getMessages(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child:  indicator_nourah_loading());
//           }
//
//           else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//             List<QueryDocumentSnapshot> data = snapshot.data!.docs;
//
//           return  ListView.builder(
//               reverse: true,
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return MessageWidget(
//                   message: data[index].get('message'),
//                   isMe: data[index].get('idUser')==idUser,
//                 );
//               },
//             );
//           }
//
//           else {
//             return Center(child: StyleText('Say Hi..'));
//           }
//         });}
//
//   Widget buildText(String text) => Center(
//         child: StyleText(text),
//
//       );
//
//
// }
