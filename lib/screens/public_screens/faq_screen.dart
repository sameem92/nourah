import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:html/parser.dart';
import 'package:producer_family_app/components/expantion_tile.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/style_colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.faq,
        onPressed: () {},
      ),
      body: GetX<GetNetworkGetx>(
          init: GetNetworkGetx(),
          builder: (GetNetworkGetx network) {
            return network.connectionType.value == 0
                ? noContent(context, AppLocalizations.of(context)!.noInternet)
                : GetX<GetFaqGetx>(
                    init: GetFaqGetx(
                        language:
                            Localizations.localeOf(context).languageCode == "ar"
                                ? "ar"
                                : "en"),
                    builder: (GetFaqGetx controller) {
                      return controller.isLoading.value
                          ? Center(child: indicatorNourahLoading())
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.faqs.length,
                              itemBuilder: (context, index) {
                                return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MainExpantion(
                                        mainTitle:
                                            Localizations.localeOf(context)
                                                        .languageCode ==
                                                    "ar"
                                                ? parse(controller
                                                            .faqs[index].arname)
                                                        .body
                                                        ?.text ??
                                                    ''
                                                : parse(controller
                                                            .faqs[index].enname)
                                                        .body
                                                        ?.text ??
                                                    '',
                                        column: controller.isLoading.value
                                            ? const Center(
                                                child: CircularProgressIndicator
                                                    .adaptive())
                                            : ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: controller
                                                    .faqs[index]
                                                    .questions!
                                                    .length,
                                                itemBuilder: (context, indexx) {
                                                  return Column(
                                                    children: [
                                                      SubExpantion(
                                                        title: Localizations.localeOf(
                                                                        context)
                                                                    .languageCode ==
                                                                "ar"
                                                            ? parse(controller
                                                                        .faqs[
                                                                            index]
                                                                        .questions![
                                                                            indexx]
                                                                        .arquestion)
                                                                    .body
                                                                    ?.text ??
                                                                ''
                                                            : parse(controller
                                                                        .faqs[
                                                                            index]
                                                                        .questions![
                                                                            indexx]
                                                                        .enquestion)
                                                                    .body
                                                                    ?.text ??
                                                                '',
                                                        subject: Localizations.localeOf(
                                                                        context)
                                                                    .languageCode ==
                                                                "ar"
                                                            ? parse(controller
                                                                        .faqs[
                                                                            index]
                                                                        .questions![
                                                                            indexx]
                                                                        .aranswer)
                                                                    .body
                                                                    ?.text ??
                                                                ''
                                                            : parse(controller
                                                                        .faqs[
                                                                            index]
                                                                        .questions![
                                                                            indexx]
                                                                        .enanswer)
                                                                    .body
                                                                    ?.text ??
                                                                "",
                                                      ),
                                                      SizedBox(
                                                        height: hSpaceLargev,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                      ),
                                    ]);
                              },
                            );
                    });
          }),
    );
  }
}
