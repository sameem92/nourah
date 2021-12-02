import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/headers/header_app.dart';
import 'package:producer_family_app/storage/providersAndGetx/app_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: wPadding,
          end: wPadding,
          bottom: hPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              header_app(
                context,
                title: AppLocalizations.of(context)!.notifications,
              ),

              GetX<getNotificationsGetx>(
                  init: getNotificationsGetx(),
                  builder: (getNotificationsGetx controller) {
                    return controller.isLoading.value
                        ? Column(
                      children: [
                        SizedBox(height: SizeConfig.scaleHeight(350),),
                        Center(child:  indicator_nourah_loading()   ),
                      ],
                    )
                        : controller.notifications.length!=0
                        ?ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: controller.notifications.length,
                            itemBuilder: (context, index) {
                              return

                                controller.notifications[index].deleted==0
                                  ?    ContainerApp(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: hSpace,),
                                            Row(
                                              children: [
                                                SizedBox(width: wSpace,),
                                                Icon(
                                                  Icons.notifications,
                                                  color: kSpecialColor,
                                                  size: fIcon,
                                                ),
                                                Spacer(),

                                                StyleText(
                                                  Localizations.localeOf(context)
                                                              .languageCode ==
                                                          "ar"
                                                      ? controller.notifications[index]
                                                          .notification
                                                      : controller.notifications[index]
                                                          .ennotification,
                                                  maxLines: 10,
                                                  width: SizeConfig.scaleHeight(360),
                                                  height: SizeConfig.scaleWidth(1.8),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            SizedBox(height: hSpace,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                StyleText(
                                                  controller.notifications[index].createdAt,
                                                  width: SizeConfig.scaleWidth(300),
                                                  textAlign: TextAlign.end,
                                                  fontSize: fSmall,
                                                ),
                                                SizedBox(width: wSpace,)
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                   : Column();

                            }
                            )
                        : noContent(context,AppLocalizations.of(context)!.thereIsnoNotifications);
                  }),
            ],
          ),
        ),
      ),
    );
  }


}
