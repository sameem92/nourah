import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';

class PoliciesScreen extends StatelessWidget {
  final int id;

  const PoliciesScreen({this.id = 0});
  @override
  Widget build(BuildContext context) {
    GetShowFamilyGetXMap getShowFamilyGetXMap = Get.find();

    return Scaffold(
      appBar: appBarWhite(
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
                    color: kGrey.withOpacity(.1),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              color: Colors.white),
          alignment: Alignment.topCenter,
          child: getShowFamilyGetXMap.isLoading.value
              ? Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(360),
                    ),
                    Center(child: indicatorNourahLoading()),
                  ],
                )
              : Center(
                  heightFactor: 1.5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        getShowFamilyGetXMap.showfamily['family']['policy'] !=
                                null
                            ? StyleText(
                                Localizations.localeOf(context).languageCode ==
                                        "ar"
                                    ? getShowFamilyGetXMap.showfamily['family']
                                                ['policy']['arpolicy'] !=
                                            null
                                        ? getShowFamilyGetXMap
                                                    .showfamily['family']
                                                ['policy']['arpolicy'] ??
                                            ''
                                        : ""
                                    : getShowFamilyGetXMap.showfamily['family']
                                                ['policy']['enpolicy'] !=
                                            null
                                        ? getShowFamilyGetXMap
                                                    .showfamily['family']
                                                ['policy']['enpolicy'] ??
                                            ''
                                        : "",
                                maxLines: 300,
                                height: 1.6,
                                letterSpacing: 1.3,
                                wordSpacing: 1.2,
                              )
                            : noContent(context,
                                AppLocalizations.of(context)!.thereIsnoPolices,
                                height: 280)
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
