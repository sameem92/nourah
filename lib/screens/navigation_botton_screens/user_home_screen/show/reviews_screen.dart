import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/message/message_admin.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsScreen extends StatelessWidget {
  String id;

  ReviewsScreen({this.id=''});
  @override
  Widget build(BuildContext context) {
    getShowFamilyGetXMap _getShowFamilyGetXMap = Get.find();

    return Scaffold(
      appBar: AppBarWhite(
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
                child:
                _getShowFamilyGetXMap.isLoading.value
                    ?  Center(child: indicator_nourah_loading()    )
                    :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _getShowFamilyGetXMap.showfamily["family"]['comments'].length,
                    itemBuilder: (context, index) {
                      return
                        MessageAdmin(
                          comment:  "${_getShowFamilyGetXMap.showfamily["family"]['comments'][index]['comment']??''}",
                          rate: "${_getShowFamilyGetXMap.showfamily["family"]['comments'][index]['rate']??''}" ,
                          when:  "${_getShowFamilyGetXMap.showfamily["family"]['comments'][index]['created_at']??""}",
                          sender:
                              "${_getShowFamilyGetXMap.showfamily["family"]['comments'][index]['username']??''}",
                          star: true);
                    }),
              ),

          ),
    );
  }
}
