
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:html/parser.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsScreen extends StatefulWidget {
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.termsandcondions,
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
          child:
          GetX<GetNetworkGetx>(
              init: GetNetworkGetx(),
              builder: (GetNetworkGetx network) {
                return
                  network.connectionType.value==0?noContent(context,  AppLocalizations.of(context)!.noInternet):

                  GetX<GetprivacyGetx>(
              init: GetprivacyGetx(
                  language: Localizations.localeOf(context).languageCode == "ar"
                      ? "ar"
                      : "en"),
              builder: (GetprivacyGetx controller) {
                return controller.isLoading.value
                    ? Center(child: indicatorNourahLoading())
                    : Center(
                        heightFactor: 1.5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              StyleText(
                                parse(controller.privacies['privacy'] ?? " ").body?.text??'',

                                maxLines: 300,
                                height: 1.6,
                                letterSpacing: 1.3,
                                wordSpacing: 1.2,
                              ),
                            ],
                          ),
                        ),
                      );
              });}),
        ),
      ),
    );
  }
}
