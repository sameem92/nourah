import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PoliciesScreen extends StatelessWidget {
  String id;

  PoliciesScreen({this.id = ''});
  @override
  Widget build(BuildContext context) {
    getShowFamilyGetXMap _getShowFamilyGetXMap = Get.find();

    return Scaffold(
      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.policies,
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
          child: _getShowFamilyGetXMap.isLoading.value
              ? Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(360),
                    ),
                    Center(child:  indicator_nourah_loading()),
                  ],
                )
              : Center(
                  heightFactor: 1.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _getShowFamilyGetXMap.showfamily['family']
                        ['policy']!=null
                            ? StyleText(
                                Localizations.localeOf(context).languageCode ==
                                        "ar"
                                    ? _getShowFamilyGetXMap.showfamily['family']
                                                ['policy']['arpolicy'] !=
                                            null
                                        ? _getShowFamilyGetXMap
                                                    .showfamily['family']
                                                ['policy']['arpolicy'] ??
                                            ''
                                        : ""
                                    : _getShowFamilyGetXMap.showfamily['family']
                                                ['policy']['enpolicy'] !=
                                            null
                                        ? _getShowFamilyGetXMap
                                                    .showfamily['family']
                                                ['policy']['enpolicy'] ??
                                            ''
                                        : "",
                                maxLines: 300,
                                height: 1.6,
                                letterSpacing: 1.3,
                                wordSpacing: 1.2,
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
