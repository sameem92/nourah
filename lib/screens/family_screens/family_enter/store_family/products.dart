import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/card_widget.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/edit_products.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';

class products extends StatefulWidget {
  @override
  _productsState createState() => _productsState();
}

class _productsState extends State<products> {
  late TextEditingController thePriceAfter;
  late TextEditingController _toController;
  getProductsFamilyGetx controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thePriceAfter = TextEditingController();
    _toController = TextEditingController();

    thePriceAfter.addListener(() => setState(() {}));
    _toController.addListener(() => setState(() {}));
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    thePriceAfter.dispose();
    _toController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: wPadding,
        right: wPadding,
        top: hPadding,
        bottom: hPadding,
      ),
      child: GetX<getProductsFamilyGetx>(
        builder: (getProductsFamilyGetx controller) {
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator.adaptive())
              : controller.productsFamily.length != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.productsFamily.length,
                      itemBuilder: (context, index) {
                        int id = controller.productsFamily[index].id;
                        return Column(
                          children: [
                            CardWidget(
                              Column(),
                              productName:
                                  "${Localizations.localeOf(context).languageCode == "ar" ? controller.productsFamily[index].arname : controller.productsFamily[index].enname}",
                              price:
                                  "${controller.productsFamily[index].offerPrice}  ${AppLocalizations.of(context)!.reyal}",
                              priceBefore:
                                  "${controller.productsFamily[index].price}",
                              discount:
                                  "%${controller.productsFamily[index].offerDiscount}",
                              familyScreens: true,
                              time:
                                  "${controller.productsFamily[index].durationTo} - ${controller.productsFamily[index].durationFrom} "
                                  "${controller.productsFamily[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.productsFamily[index].durationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                              timer:
                                  "${controller.productsFamily[index].offerDuration} "
                                  "${controller.productsFamily[index].offerDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${controller.productsFamily[index].offerDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                              state: 10,
                              page: "${controller.productsFamily[index].id}",
                              image:
                                  "${controller.productsFamily[index].images!.length !=0 ?controller.productsFamily[index].images![0].image:null}",
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: StyleButton(
                                    AppLocalizations.of(context)!.edit,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProducts(index: index)),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: wSpace,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: StyleButton(
                                    AppLocalizations.of(context)!.delete,
                                    sideColor: kRefuse,
                                    backgroundColor: kRefuse,
                                    onPressed: () {
                                      ShowDialoge(context, onPressed: () async {
                                        Navigator.pop(context);

                                        await deleteProduct(
                                          id: id,
                                        );
                                      },
                                          message3: SizedBox(
                                            height: 0,
                                            width: 0,
                                          ),
                                          height: 280,
                                          message1:
                                              AppLocalizations.of(context)!
                                                  .deleteProduct,
                                          message2: AppLocalizations.of(
                                                  context)!
                                              .areyousureaboutdeletingtheProduct,
                                          iconMeassge: Icon(
                                            Icons.delete_outline,
                                            color: kRefuse,
                                            size: SizeConfig.scaleHeight(80),
                                          ),
                                          colorButton2: kRefuse,
                                          colorButton1: kConfirm,
                                          button1:
                                              AppLocalizations.of(context)!.yes,
                                          button2:
                                              AppLocalizations.of(context)!.no);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: hSpace,
                            )
                          ],
                        );
                      },
                    )
                  : noContent(
                      context, AppLocalizations.of(context)!.thereIsnoProducts);
        },
      ),
    );
  }

  Future deleteProduct({
    required int id,
  }) async {
    await controller.deleteProduct(context: context, id: id);
  }
}
