import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/headers/app_bar_family.dart';
import 'package:producer_family_app/storage/api/family_controller/family_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPolicies extends StatefulWidget {
  @override
  _AddPoliciesState createState() => _AddPoliciesState();
}

class _AddPoliciesState extends State<AddPolicies> {
  late TextEditingController _arabicPolicies;
  late TextEditingController _englishPolicies;
  getFamilyPolicyGetx controller2 = Get.find();

  @override
  void initState() {
    super.initState();
    _arabicPolicies = TextEditingController(text:controller2.policies['arpolicy'] ?? "" );
    _englishPolicies = TextEditingController(text:  controller2.policies['enpolicy'] ?? "");
    _arabicPolicies.addListener(() => setState(() {}));
    _englishPolicies.addListener(() => setState(() {}));

  }
  @override
  void dispose() {
    super.dispose();

    _arabicPolicies.dispose();
    _englishPolicies.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWhite(
        context,
        title: AppLocalizations.of(context)!.addPolicies,
        onPressed: () {},
      ),
      body: GetX<getFamilyPolicyGetx>(
        init:getFamilyPolicyGetx() ,
          builder: (getFamilyPolicyGetx controller) {
            return

              SingleChildScrollView(
              child:

              controller.isLoading.value
                  ? Column(
                    children: [
                      SizedBox(height: SizeConfig.scaleHeight(350),),
                      Center(
                child:  indicator_nourah_loading()
              ),
                    ],
                  )
                  :
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: SizeConfig.scaleWidth(20),
                  end: SizeConfig.scaleWidth(20),
                  top: SizeConfig.scaleHeight(30),
                  bottom: SizeConfig.scaleHeight(30),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StyleField(
                          controller: _arabicPolicies,
                          title: AppLocalizations.of(context)!.arabicPolicies,
                          prefixIcon: Icon(Icons.event_note),
                          maxLines: 10,
                          padding:20 ,
                          height: 5,
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(40),
                        ),
                        StyleField(
                          controller: _englishPolicies,
                          title: AppLocalizations.of(context)!.englishPolicies,
                          prefixIcon: Icon(Icons.event_note),
                          padding:20 ,

                          maxLines: 10,
                          height: 5,
                        ),
                        SizedBox(
                          height: SizeConfig.scaleHeight(25),
                        ),
                        StyleButton(
                          AppLocalizations.of(context)!.saveinfo,
                          onPressed: ()async {
                            await addPolicies();

                          },
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }

  Future addPolicies ()async{


await controller2.addPolicies(context: context,
        arPolicy:_arabicPolicies.text ,
        enPolicy: _englishPolicies.text,);


  }
}
