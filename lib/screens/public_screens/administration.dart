import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/header_app.dart';
import 'package:producer_family_app/components/message/message_admin.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';

class Administration extends StatefulWidget {
  final bool header;

  const Administration({this.header = false});

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
  }

  @override
  void dispose() {
    Get.delete<GetMessageGetx>();

    _message.dispose();
    super.dispose();
  }

  GetMessageGetx controller = Get.put(GetMessageGetx());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wPadding,
          end: wPadding,
          bottom: hPadding,
        ),
        child: GetX<GetNetworkGetx>(
            init: GetNetworkGetx(),
            builder: (GetNetworkGetx network) {
              return network.connectionType.value == 0
                  ? Column(
                      children: [
                        noContent(
                            context, AppLocalizations.of(context)!.noInternet),
                        SizedBox(
                          height: SizeConfig.scaleHeight(30),
                        ),
                        StyleButton(AppLocalizations.of(context)!.refresh,
                            sideColor: kSpecialColor,
                            backgroundColor: kSpecialColor,
                            onPressed: () async {
                          await network.refreshData();
                        })
                      ],
                    )
                  : Column(
                      children: [
                        widget.header == true
                            ? headerApp(
                                context,
                                title: AppLocalizations.of(context)!
                                    .chatWithAdminstration,
                              )
                            : Column(),
                        Expanded(
                          child: GetX<GetMessageGetx>(
                              init: GetMessageGetx(
                                  language: Localizations.localeOf(context)
                                              .languageCode ==
                                          "ar"
                                      ? "ar"
                                      : "en"),
                              builder: (GetMessageGetx controller) {
                                return controller.isLoading.value
                                    ? Center(child: indicatorNourahLoading())
                                    : controller.messages.isNotEmpty
                                        ? ListView.builder(
                                            reverse: true,
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.messages.length > 20
                                                    ? 20
                                                    : controller
                                                        .messages.length,
                                            itemBuilder: (context, index) {
                                              return MessageAdmin(
                                                colorContainer: controller
                                                            .messages[index]
                                                            .type ==
                                                        "admin"
                                                    ? kSpecialColor
                                                        .withOpacity(.1)
                                                    : Colors.white,
                                                sender: controller
                                                            .messages[index]
                                                            .name ==
                                                        'managment'
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .administration
                                                    : controller
                                                        .messages[index].name,
                                                rate: "",
                                                when: controller
                                                    .messages[index].createdAt,
                                                star: false,
                                                comment: controller
                                                    .messages[index].message,
                                              );
                                            })
                                        : noContent(
                                            context,
                                            AppLocalizations.of(context)!
                                                .thereIsnoMessages);
                              }),
                        ),
                        _buildMessageComposer()
                      ],
                    );
            }),
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
            icon: const Icon(Icons.send),
            color: kSpecialColor,
            onPressed: () async {
              if (_message.text.isNotEmpty) {
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
