

import 'package:flutter/material.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/order_controller.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Reporting extends StatefulWidget {
  bool user;
  bool driver;
  bool family;
  String id;

Reporting({this.driver=false,this.family=false,this.user=false,this.id=""});
  @override
  _ReportingState createState() => _ReportingState();
}

class _ReportingState extends State<Reporting> {
  late TextEditingController report;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    report = TextEditingController();
    report.addListener(() => setState(() {}));

  }

  @override
  void dispose() {
    super.dispose();
    report.dispose();
  }
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBarWhite(context,title:           AppLocalizations.of(context)!.reporting, onPressed: (){},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: wPadding,
            end: wPadding,
            top: hPadding,
            bottom: hPadding,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: hSpaceLarge,
                ),
                SizedBox(
                    width: double.infinity,
                    child: StyleText(
                      AppLocalizations.of(context)!.complaintAbout,
                      textAlign: TextAlign.start,
                      fontSize: fLargev,
                    )),
                SizedBox(
                  height: hSpaceLarge,
                ),
                ContainerApp(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      if(widget.user == true)
                      Row(
                        children: [
                          Radio(
                              value: 3,
                              activeColor: kSpecialColor,
                              groupValue: groupValue,
                              onChanged: (int? val) {
                                groupValue = val!;
                                print(groupValue);
                                setState(() {});
                              }),
                          StyleText(
                            AppLocalizations.of(context)!.user,
                          ),
                        ],
                      ),
                      if(widget.family == true)

                        Row(
                        children: [
                          Radio(
                              value: 1,
                              activeColor: kSpecialColor,
                              groupValue: groupValue,
                              onChanged: (int? val) {
                                groupValue = val!;
                                setState(() {});
                                print(groupValue);

                              }),
                          StyleText(
                            AppLocalizations.of(context)!.family,
                          ),
                        ],
                      ),
                      if(widget.driver == true)

                      Row(
                        children: [
                          Radio(
                              value: 2,
                              activeColor: kSpecialColor,
                              groupValue: groupValue,
                              onChanged: (int? val) {
                                groupValue = val!;
                                setState(() {});
                                print(groupValue);

                              }),
                          StyleText(
                            AppLocalizations.of(context)!.driver,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Radio(
                              value: 0,
                              activeColor: kSpecialColor,
                              groupValue: groupValue,
                              onChanged: (int? val) {
                                groupValue = val!;
                                print(groupValue);
                                setState(() {});
                              }),
                          StyleText(
                            AppLocalizations.of(context)!.public,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),

                SizedBox(
                  height: hSpaceLarge,
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(400),
                  child: StyleField(
                    title: AppLocalizations.of(context)!.complaintContent,
                    width: double.infinity,
                    controller: report,
                    padding: 20,
                    maxLines: 15,
                  ),
                ),
                SizedBox(
                  height: hSpaceLarge,
                ),
                StyleButton(
                  AppLocalizations.of(context)!.send,
                  backgroundColor: kRefuse,onPressed: ()async{

                await  reporting(order_id:widget.id);
                print(widget.id);
                },
                  sideColor: kRefuse,
                )
              ]),
        ),
      ),
    );
  }
  Future reporting({String order_id=""}) async {

    bool reportIt = await OrderController().reportOrdersController(
        order_id: order_id,
       language: Localizations.localeOf(context).languageCode=="ar"?"ar":"en",
       report: report.text,
        report_type: "$groupValue",
        context: context);
    print("$groupValue  ${report.text}");

  }

}

