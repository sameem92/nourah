import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/card_widget.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/screens/family_screens/family_enter/store_family/edit_products.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';

class ProductsFamily extends StatefulWidget {
  @override
  _ProductsFamilyState createState() => _ProductsFamilyState();
}

class _ProductsFamilyState extends State<ProductsFamily> {
  late TextEditingController thePriceAfter;
  late TextEditingController _toController;
  GetProductsFamilyGetx controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    thePriceAfter = TextEditingController();
    _toController = TextEditingController();

    thePriceAfter.addListener(() => setState(() {}));
    _toController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    thePriceAfter.dispose();
    _toController.dispose();
    super.dispose();
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
      child: GetX<GetProductsFamilyGetx>(
        builder: (GetProductsFamilyGetx controller) {
          Future<void> getData() async {
            await controller.refreshData();
          }

          return RefreshIndicator(
              onRefresh: getData,
              child: controller.isLoading.value
                  ? Center(child: indicatorNourahLoading())
                  : controller.productsFamily.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.productsFamily.length,
                          itemBuilder: (context, index) {
                            int reverseIndex =
                                controller.productsFamily.length - 1 - index;
                            int id = controller.productsFamily[reverseIndex].id;
                            return Column(
                              children: [
                                CardWidget(
                                  Column(),
                                  productName: Localizations.localeOf(context)
                                              .languageCode ==
                                          "ar"
                                      ? controller
                                          .productsFamily[reverseIndex].arname
                                      : controller
                                          .productsFamily[reverseIndex].enname,
                                  price:
                                      "${controller.productsFamily[reverseIndex].offerStatus == 1 ? controller.productsFamily[reverseIndex].offerPrice : controller.productsFamily[reverseIndex].price}  ${AppLocalizations.of(context)!.reyal}",
                                  priceBefore:
                                      "${controller.productsFamily[reverseIndex].price}",
                                  discount:
                                      "%${controller.productsFamily[reverseIndex].offerDiscount}",
                                  familyScreens: true,
                                  discountBoolCard: controller
                                              .productsFamily[reverseIndex]
                                              .offerStatus ==
                                          1
                                      ? true
                                      : false,
                                  time:
                                      "${controller.productsFamily[reverseIndex].durationTo}-${controller.productsFamily[reverseIndex].durationFrom} "
                                      "${controller.productsFamily[reverseIndex].durationUnit == "h" ? AppLocalizations.of(context)!.hour : controller.productsFamily[reverseIndex].durationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} ",
                                  timer: controller.productsFamily[reverseIndex]
                                              .offerStatus ==
                                          1
                                      ? "${controller.productsFamily[reverseIndex].offertime['days'] * 24 + controller.productsFamily[reverseIndex].offertime['hours']}:${controller.productsFamily[reverseIndex].offertime['minutes']}:${controller.productsFamily[reverseIndex].offertime['seconds']}"

                                      // "${controller.productsFamily[reverseIndex].offerDuration} "
                                      //     "${controller.productsFamily[reverseIndex].offerDurationUnit == "h" ? AppLocalizations.of(context)!.hour : controller.productsFamily[reverseIndex].offerDurationUnit == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} "
                                      : AppLocalizations.of(context)!
                                          .thereIsNoSale,
                                  state: 10,
                                  familyProfile: false,
                                  page:
                                      "${controller.productsFamily[reverseIndex].id}",
                                  image: controller.productsFamily[reverseIndex]
                                          .images!.isNotEmpty
                                      ? controller.productsFamily[reverseIndex]
                                          .images![0].image
                                      : controller.productsFamily[reverseIndex]
                                                  .images!.length ==
                                              2
                                          ? controller
                                              .productsFamily[reverseIndex]
                                              .images![1]
                                              .image
                                          : "",
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
                                                    EditProducts(
                                                        index: reverseIndex)),
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
                                        sideColor: kGrey,
                                        backgroundColor: kGrey,
                                        onPressed: () {
                                          showDialoge(context,
                                              onPressed: () async {
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
                                              message2: AppLocalizations
                                                      .of(context)!
                                                  .areyousureaboutdeletingtheProduct,
                                              iconMeassge: Icon(
                                                Icons.delete_outline,
                                                color: kRefuse,
                                                size:
                                                    SizeConfig.scaleHeight(80),
                                              ),
                                              colorButton2: kRefuse,
                                              colorButton1: kConfirm,
                                              button1:
                                                  AppLocalizations.of(context)!
                                                      .yes,
                                              button2:
                                                  AppLocalizations.of(context)!
                                                      .no);
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
                      : noContent(context,
                          AppLocalizations.of(context)!.thereIsnoProducts));
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
