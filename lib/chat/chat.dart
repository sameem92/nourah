import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/chat/firebaseApi.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';

import 'message_widget.dart';

class Chat extends StatefulWidget {
 final String idUser;
 final String idFamily;
 final String idDriver;
 final String idOrder;

  const Chat({
    this.idUser="",
    this.idFamily="",
    this.idDriver="",
    this.idOrder="",
  });
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarWhite(context,title:AppLocalizations.of(context)!.details,
      onPressed: (){}, icon: Icons.call
      ),      body: Padding(
        padding: EdgeInsets.only(
          bottom: hPadding,
          left: wPadding,
          right: wPadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                // child: MessagesWidget(idSender: widget.idDriver,),
              ),
            ),

            NewMessageWidget(idUser:widget.idUser ,idDriver: widget.idDriver,idFamily: widget.idFamily,idOrder: widget.idOrder,),
          ],
        ),
      ),
    );
  }
}


class NewMessageWidget extends StatefulWidget {
  final String idUser;
  final String idOrder;
  final String idDriver;
  final String idFamily;

  const NewMessageWidget({
    required this.idUser,
    required this.idOrder,
    required this.idDriver,
    required this.idFamily,
    Key? key,
  }) : super(key: key);
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
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) => Container(
    color: Colors.white,
    padding: EdgeInsets.all(8),
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
          onTap: _controller.text.trim().isEmpty ? null :sendMessage,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryColor,
            ),
            child: Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    ),
  );
  void sendMessage() async {
    print(_controller.text);
    print("widget.idUser:${widget.idUser}");
    print(" widget.idDriver:${ widget.idDriver}");
    print("widget.idFamily:${widget.idFamily}");
    print("widget.idOrder:${widget.idOrder}");
    FocusScope.of(context).unfocus();
    await FirebaseApi.uploadMessage(
        idUser: widget.idUser,
        message: _controller.text,
        idDriver: widget.idDriver,
        idFamily: widget.idFamily ,
        idOrder:  widget.idOrder);
    _controller.clear();
  }
}