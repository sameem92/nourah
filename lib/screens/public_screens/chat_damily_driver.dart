import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/shared_preferences_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../storage/api/app_controller.dart';

final _fireStore = FirebaseFirestore.instance;
String senderr = '';

class ChatFamily extends StatefulWidget {
  final String orderNo;
  final int driverId;
  final int familyId;
  final String phone;

  const ChatFamily({
    this.orderNo = "",
    this.driverId = 0,
    this.familyId = 0,
    this.phone = "",
  });
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatFamily> {
  void messageStream() async {
    await for (var snapshot in _fireStore
        .collection('chats/${widget.orderNo}driverFamily/messages')
        .snapshots()) {
      for (var message in snapshot.docs.reversed) {
        // print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(context, title: AppLocalizations.of(context)!.details,
          onPressed: () {
        _makePhoneCall(widget.phone);
      }, icon: Icons.call),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: hPadding,
          left: wPadding,
          right: wPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _fireStore
                        .collection(
                            'chats/${widget.orderNo}driverFamily/messages')
                        .orderBy('time')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: indicatorNourahLoading());
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        final messages = snapshot.data!.docs.reversed;
                        List<MessageLine> messageWidgets = [];
                        for (var message in messages) {
                          final text = message.get('text');
                          final sender = message.get('sender');

                          final messageWidget = MessageLine(
                            text: text,
                            isMe: sender == "driver" ? true : false,
                          );
                          messageWidgets.add(messageWidget);
                          // setState(() {
                          senderr = sender;
                          // });
                        }

                        return ListView(
                            reverse: true, children: messageWidgets);
                      } else {
                        return const Center(child: StyleText('Say Hi..'));
                      }
                    }),
              ),
            ),
            NewMessageWidget(
              orderNo: widget.orderNo,
              familyId: widget.familyId,
              driverId: widget.driverId,
            ),
          ],
        ),
      ),
    );
  }
}

class NewMessageWidget extends StatefulWidget {
  final String orderNo;
  final int familyId;
  final int driverId;

  const NewMessageWidget({
    required this.orderNo,
    required this.familyId,
    required this.driverId,
  });
  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  late TextEditingController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: StyleField(
                title: AppLocalizations.of(context)!.send,
                filled: true,
                controller: _controller,
              ),
            ),
            SizedBox(width: wSpace),
            GestureDetector(
              onTap: _controller.text.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSpecialColor,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
  void sendMessage() async {
    FocusScope.of(context).unfocus();
    _fireStore.collection('chats/${widget.orderNo}driverFamily/messages').add({
      'text': _controller.text,
      'time': FieldValue.serverTimestamp(),
      // 'sender':SharedPreferencesController()
      //     .isLoggedInUser ==
      //     true
      //     ? "user:${widget.user}"
      //     : SharedPreferencesController()
      //     .isLoggedInDriver ==
      //     true
      //     ?"driver:${widget.driver}":"family:${widget.family}"
      'sender': SharedPreferencesController().isLoggedInUser == true
          ? "user"
          : SharedPreferencesController().isLoggedInDriver == true
              ? "driver"
              : "family"
    });
    await AppController().sendChatController(
        receiverId: senderr == "driver" ? widget.familyId : widget.driverId,
        orderNo: widget.orderNo);
    _controller.clear();
  }
}

class MessageLine extends StatelessWidget {
  final String? text;
  final String? sender;
  final bool isMe;

  MessageLine({this.text, this.sender, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final radius = const Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(SizeConfig.scaleWidth(15)),
            margin: EdgeInsets.all(SizeConfig.scaleWidth(10)),
            constraints: BoxConstraints(maxWidth: SizeConfig.scaleWidth(250)),
            decoration: BoxDecoration(
              color: isMe ? kSpecialColor : kSpecialColor,
              borderRadius: isMe
                  ? borderRadius
                      .subtract(BorderRadius.only(bottomRight: radius))
                  : borderRadius
                      .subtract(BorderRadius.only(bottomLeft: radius)),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  text!,
                  style: const TextStyle(color: Colors.white),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            )),
      ],
    );
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
