import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/expantion_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.faq,
        onPressed: () {},
      ),
      body: GetX<getFaqGetx>(
          init: getFaqGetx(Language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en"),
          builder: (getFaqGetx controller) {
            return  controller.isLoading.value
                ? Center(
              child:  indicator_nourah_loading()
            )
                :ListView.builder(
              shrinkWrap: true,
              itemCount: controller.faqs.length,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MainExpantion(
                        mainTitle:
                        Localizations.localeOf(context).languageCode=="ar"

                      ?  controller.faqs[index].arname
                      :  controller.faqs[index].enname,
                        Column:

                        controller.isLoading.value
                            ? Center(
                          child: CircularProgressIndicator.adaptive()
                        )
                            :ListView.builder(
                                shrinkWrap: true,

                                itemCount: controller
                                  .faqs[index].questions!.length,
                              itemBuilder: (context, indexx) {
                                return
                                    Column(
                                      children: [
                                        SubExpantion(

                                          title:
                                          Localizations.localeOf(context).languageCode=="ar"
                                        ?  controller
                                              .faqs[index].questions![indexx].arquestion
                                          :controller
                                              .faqs[index].questions![indexx].enquestion,
                                          subject:
                                          Localizations.localeOf(context).languageCode=="ar"
                                        ?  controller
                                              .faqs[index].questions![indexx].aranswer
                                              :controller
                                              .faqs[index].questions![indexx].enanswer
                                       ),
                                        SizedBox(height: hSpaceLargev,),


                                  ],
                                );

                              }
                            ),




                          ),

                    ]);
              },
            );
          }),
    );
  }
}

