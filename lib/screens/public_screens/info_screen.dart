import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.info,
        onPressed: () {},
      ),
      body: Center(
        child: Container(
          padding: EdgeInsetsDirectional.only(
            start: wSpace,
            end: wSpace,
            top: hCardMar,
            bottom: hCard,
          ),
          margin: EdgeInsets.only(
            bottom: hSpaceLargev,
            top: hSpaceLarge,
            left: wCardMar,
            right: wCardMar,
          ),
          width: SizeConfig.scaleWidth(370),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
              boxShadow: [
                BoxShadow(
                    color: kSecondaryColor.withOpacity(.1),
                    blurRadius: 5,
                    spreadRadius: 4)
              ],
              color: Colors.white),
          alignment: Alignment.topCenter,
          child: GetX<getAboutUsGetx>(
              init: getAboutUsGetx(
                  Language: Localizations.localeOf(context).languageCode == "ar"
                      ? "ar"
                      : "en"),
              builder: (getAboutUsGetx controller) {
                return controller.isLoading.value
                    ? Center(child:  indicator_nourah_loading())
                    : Center(
                        heightFactor: 1.5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              StyleText(
                                '${controller.aboutUs['about'] ?? " "}',
                                maxLines: 300,
                                height: 1.6,
                                letterSpacing: 1.3,
                                wordSpacing: 1.2,
                              ),
                            ],
                          ),
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
