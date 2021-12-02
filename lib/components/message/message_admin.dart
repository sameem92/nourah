import 'package:flutter/material.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextEditingController? _message;


class MessageAdmin extends StatefulWidget {
  String sender;
   String rate;
   String when;
  String comment;
  bool star =false;

  MessageAdmin({required this.sender,required this.rate,
    required this.when,required this.comment,required this.star});

  @override
  _MessageAdminState createState() => _MessageAdminState();
}

class _MessageAdminState extends State<MessageAdmin> {
  @override
  Widget build(BuildContext context) {
    return ContainerApp(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: wCard, end: wCard, bottom: hCard, top: hCard),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: wSpace,
                ),
                Expanded(
                  flex: 3,
                  child: StyleText(
                    widget.sender,
                    textAlign: TextAlign.start,
                  ),
                ),
                if (widget.star == true)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StyleText(
                          widget.rate,
                          textAlign: TextAlign.end,
                          height: 1.4,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: fIconSmall,

                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: SizeConfig.scaleWidth(30),
                end: SizeConfig.scaleWidth(30),
                top: SizeConfig.scaleHeight(5),
                bottom: SizeConfig.scaleHeight(5),
              ),
              child: StyleText(
                widget.comment,
                maxLines: 10,
                height: 1.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StyleText(
                  widget. when,
                  width: SizeConfig.scaleWidth(300),
                  textAlign: TextAlign.end,
                  fontSize: fSmall,
                ),
                SizedBox(width: wSpaceSmall,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}




class MessageAdminField extends StatefulWidget {
String message;
MessageAdminField({required this.message});
  @override
  _MessageAdminFieldState createState() => _MessageAdminFieldState();
}

class _MessageAdminFieldState extends State<MessageAdminField> {
  late TextEditingController message;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message  = TextEditingController();
    message.addListener(() => setState(() {}));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    message.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StyleField(

          controller: message,
          title: AppLocalizations.of(context)!.yourMessage,
          maxLines: 10,
          height: SizeConfig.scaleHeight(150),
          width: double.infinity,
        ),
        SizedBox(
          height: hSpace,
        ),
        Row(
          children: [
            Spacer(),
            StyleButton(
              AppLocalizations.of(context)!.send,
              backgroundColor: kSpecialColor,
              sideColor: kSpecialColor,
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}


