import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/message/message_admin.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/style/style_colors.dart';

class ReviewsScreen extends StatelessWidget {
  final int id;

  const ReviewsScreen({this.id = 0});
  @override
  Widget build(BuildContext context) {
    GetShowFamilyGetXMap getShowFamilyGetXMap = Get.find();

    return Scaffold(
      appBar: appBarWhite(
        context,
        title: AppLocalizations.of(context)!.reviews,
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: wPadding,
            end: wPadding,
            top: hPadding,
            bottom: hPadding,
          ),
          child: getShowFamilyGetXMap.isLoading.value
              ? Center(child: indicatorNourahLoading())
              : getShowFamilyGetXMap.showfamily["family"]['comments'].length !=
                      0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: getShowFamilyGetXMap
                          .showfamily["family"]['comments'].length,
                      itemBuilder: (context, index) {
                        return getShowFamilyGetXMap.showfamily["family"]
                                    ['comments'][index]['comment'] !=
                                null
                            ? MessageAdmin(
                                comment:
                                    "${getShowFamilyGetXMap.showfamily["family"]['comments'][index]['comment'] ?? ''}",
                                rate:
                                    "${getShowFamilyGetXMap.showfamily["family"]['comments'][index]['rate'] ?? ''}",
                                when:
                                    "${getShowFamilyGetXMap.showfamily["family"]['comments'][index]['created_at'] ?? ""}",
                                sender:
                                    "${getShowFamilyGetXMap.showfamily["family"]['comments'][index]['username'] ?? ''}",
                                star: true)
                            : const SizedBox();
                      })
                  : noContent(
                      context,
                      AppLocalizations.of(context)!
                          .thereIsnoCommentsInThislocation,
                      height: 340),
        ),
      ),
    );
  }
}
