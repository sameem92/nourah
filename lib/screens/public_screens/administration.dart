import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/header_app.dart';
import 'package:producer_family_app/components/message/message_admin.dart';
import 'package:producer_family_app/storage/api/app_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Administration extends StatefulWidget {
  bool header;

  Administration({this.header=false});

  @override
  _AdministrationState createState() => _AdministrationState();
}

class _AdministrationState extends State<Administration> {
  late TextEditingController _message;

  @override
  void initState() {
    super.initState();

    _message = TextEditingController();
    _message.addListener(() => setState(() {}));

    @override
    void dispose() {
      super.dispose();

      _message.dispose();
    }
  }
  getMessageGetx controller = Get.put(getMessageGetx());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wPadding,
          end: wPadding,

          bottom: hPadding,
        ),
        child:
        Column(
            children: [
           widget.header==true?   header_app(
                context,
                title: AppLocalizations.of(context)!.chat,
              ):Column(),
              Expanded(
                child: GetX<getMessageGetx>(
                    init: getMessageGetx(language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en"),
                    builder: (getMessageGetx controller) {
                      return  controller.isLoading.value
                          ? Center(
                        child: indicator_nourah_loading()
                      )
                          :  controller.messages.length != 0
                          ?ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: controller.messages.length,
                          itemBuilder: (context, index) {
                            return MessageAdmin(
                              sender: controller.messages[index].name,
                              rate: "",
                              when: controller.messages[index].createdAt,
                              star: false,
                              comment: controller.messages[index].message,
                            );
                          })
                          : noContent(context,AppLocalizations.of(context)!.thereIsnoMessages);

                    }),
              ),
              _buildMessageComposer()
            ],
          ),
        
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: SizeConfig.scaleWidth(100),

              child: StyleField(
textAlign: TextAlign.center,
                maxLines: 5,
                padding: SizeConfig.scaleWidth(5),
                title: AppLocalizations.of(context)!.send,
                onChanged: (value) {},
                controller: _message,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            color: kSecondaryColor,
            onPressed: () async {
              if(_message.text.isNotEmpty){
                await sendMessage();
                FocusScope.of(context).unfocus();
                _message.clear();

              }
            },
          ),
        ],
      ),
    );
  }

  Future sendMessage() async {
    await controller.sendMessage(
      context: context,
      message: _message.text,
      );
  }
}
