import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:producer_family_app/components/containers/card_widget.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/family_profile_screen.dart';
import 'package:producer_family_app/screens/navigation_botton_screens/user_home_screen/show/product_profile_screen.dart';
import 'package:producer_family_app/components/containers/show_widget.dart';
import 'package:producer_family_app/storage/providersAndGetx/home_getx.dart';
import 'package:producer_family_app/storage/providersAndGetx/language_change.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  List special;
  List items;
  bool sales;
  bool family;

  HomeWidget(
      {required this.special,
      required this.items,
      this.sales = false,
      this.family = false});
  int choiceIndex = 0;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  CategoriesGetX _categoriesGetX = Get.find();
  @override
  Widget build(BuildContext context) {
    HomeGetx _homeGetx = Get.put(HomeGetx(
      language:
      Localizations.localeOf(context).languageCode == "ar"
          ? "ar"
          : "en",
      category: "${widget.choiceIndex}",

    ));
    return Padding(
      padding: EdgeInsets.only(
        left: wPadding,
        right: wPadding,
        bottom: hSpace,
      ),
      child: SingleChildScrollView(
        child: Obx(() {
          if (_homeGetx.isLoading.value) {
            return Column(
              children: [
                SizedBox(
                  height: SizeConfig.scaleHeight(360),
                ),
                Center(
                  child: indicator_nourah_loading()
                ),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.special.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider.builder(
                              itemCount: widget.special.length,
                              options: CarouselOptions(
                                viewportFraction: .75,
                                height: SizeConfig.scaleHeight(220),
                                scrollDirection: Axis.horizontal,
                                autoPlay: true,
                                aspectRatio: 2 / 20,
                                reverse: true,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.scale,
                                autoPlayCurve: Curves.easeInOutBack,
                              ),
                              itemBuilder:
                                  (context, index, realIndex) =>
                                      widget.special.isNotEmpty &&
                                              widget.special.length != 0
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => widget
                                                                .family ==
                                                            false
                                                        ? ProductProfileScreen(
                                                            product_id:
                                                                "${widget.special[index].id}",
                                                          )
                                                        : FamilyProfileScreen(
                                                            id: widget
                                                                .special[index]
                                                                .id,
                                                          ),
                                                  ),
                                                );
                                              },
                                              child: Show_family_widget(
                                                  widget.family == true
                                                      ? SingleChildScrollView(
                                                          child: Center(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox(
                                                                  width: SizeConfig
                                                                      .scaleWidth(
                                                                          300),
                                                                  height: SizeConfig
                                                                      .scaleHeight(
                                                                          23),
                                                                  child: Center(
                                                                    child: ListView.builder(
                                                                        reverse: true,
                                                                        shrinkWrap: true,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemCount: widget.special[index].categories!.length,
                                                                        itemBuilder: (context, indexx) {
                                                                          return Container(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            width:
                                                                                SizeConfig.scaleWidth(106),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                StyleText(
                                                                              Localizations.localeOf(context).languageCode == "ar" ? "${widget.special[index].categories![indexx].arname}" : "${widget.special[index].categories![indexx].enname}",
                                                                              textColor: kSpecialColor,
                                                                              maxLines: 5,
                                                                              textAlign: TextAlign.center,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          );
                                                                        }),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Column(),
                                                  family: widget.family == true
                                                      ? true
                                                      : false,
                                                  familyName: widget.family == true
                                                      ? "${widget.special[index].name}"
                                                      : "",
                                                  productName: widget.family ==
                                                          false
                                                      ? Localizations.localeOf(context)
                                                                  .languageCode ==
                                                              "ar"
                                                          ? "${widget.special[index].arname}"
                                                          : "${widget.special[index].enname}"
                                                      : "",
                                                  familyLocation: widget.special ==
                                                          false
                                                      ? "${widget.special[index].km}"
                                                      : widget.family
                                                          ? "${widget.special[index].mile}"
                                                          : "${widget.special[index].km}",
                                                  price: widget.family == false
                                                      ? "${widget.special[index].offerPrice} ${AppLocalizations.of(context)!.reyal}"
                                                      : "",
                                                  priceBefore: widget.family == false
                                                      ? "${widget.special[index].price}"
                                                      : "",
                                                  discountBool:
                                                      widget.family == false &&
                                                          widget.special[index].offerDiscount !=
                                                              0,
                                                  discount: widget.family == false
                                                      ? "${widget.special[index].offerDiscount} %"
                                                      : "",
                                                  time: widget.family == false
                                                      ? "${widget.special[index].durationTo}-${widget.special[index].durationFrom} "
                                                          "${widget.special[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : "${widget.special[index].durationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} "
                                                      : "",
                                                  rate: widget.family == false
                                                      ? " ${widget.special[index].familyrate}"
                                                      : " ${widget.special[index].rate}",
                                                  timer: widget.family == false
                                                      ? widget.sales == true
                                                          ? "${widget.special[index].offerDuration} "
                                                              "${widget.special[index].offerDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${widget.special[index].offerDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} "
                                                          : ""
                                                      : "",
                                                  state: widget.family == false
                                                      ? widget.sales == false
                                                          ? widget.special[index].familystatus
                                                          : 10
                                                      : widget.special[index].available,
                                                  image: widget.family == false ? "${widget.special[index].images}" : "${widget.special[index].image}"),
                                            )
                                          : Column()),
                          divider_app(),
                        ],
                      )
                    : Column(),
                SizedBox(
                  height: SizeConfig.scaleWidth(35),
                  child: Row(
                    children: [
                      _categoriesGetX.categories.value.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount:
                                      _categoriesGetX.categories.length + 1,
                                  itemBuilder: (context, indexFilter) {
                                    return indexFilter == 0
                                        ? Row(
                                            children: [
                                              ChoiceChip(
                                                label: StyleText(
                                                  AppLocalizations.of(context)!
                                                      .all,
                                                  textColor: kSecondaryColor,
                                                ),
                                                elevation: 3,
                                                selectedColor: kSpecialColor
                                                    .withOpacity(.8),
                                                backgroundColor:
                                                    kBackgroundColor,
                                                onSelected: (bool isSelected) {
                                                  setState(() {
                                                    widget.choiceIndex =
                                                        isSelected
                                                            ? indexFilter
                                                            : widget
                                                                .choiceIndex;
                                                    print(indexFilter);
                                                    HomeGetx.to
                                                        .filterProductsByCategory(
                                                        categoryId:
                                                        indexFilter,name: _categoriesGetX.categories[indexFilter].arname);
                                                  });
                                                },
                                                selected: widget.choiceIndex ==
                                                    indexFilter,
                                              ),
                                              SizedBox(
                                                width: wSpaceSmall,
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ChoiceChip(
                                                  label: StyleText(
                                                    Localizations.localeOf(
                                                                    context)
                                                                .languageCode ==
                                                            "ar"
                                                        ? _categoriesGetX
                                                            .categories[
                                                                indexFilter - 1]
                                                            .arname
                                                        : _categoriesGetX
                                                            .categories[
                                                                indexFilter - 1]
                                                            .enname,
                                                    textColor: kSecondaryColor,
                                                  ),
                                                  elevation: 3,
                                                  selectedColor: kSpecialColor
                                                      .withOpacity(.8),
                                                  backgroundColor:
                                                      kBackgroundColor,
                                                  onSelected:
                                                      (bool isSelected) {
                                                    setState(() {
                                                      widget.choiceIndex =
                                                          isSelected
                                                              ? indexFilter
                                                              : widget
                                                                  .choiceIndex;
                                                      print(indexFilter);
                                                      print(widget.choiceIndex);

                                                      HomeGetx.to
                                                          .filterProductsByCategory(
                                                              categoryId:
                                                                  indexFilter,);
                                                    });
                                                  },
                                                  selected:
                                                      widget.choiceIndex ==
                                                          indexFilter),
                                              SizedBox(
                                                width: wSpaceSmall,
                                              )

                                            ],
                                          );
                                  }),
                            )
                          : Column(),
                    ],
                  ),
                ),
                SizedBox(
                  height: hSpaceSmall,
                ),
                if (Provider.of<stringNotiferSearch>(context).search != "")
                  Column(
                    children: [
                      SizedBox(
                        height: hSpace,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              StyleText(
                                "${AppLocalizations.of(context)!.theResultsFromSearchAre} : ",
                                textAlign: TextAlign.right,
                              ),
                              StyleText(
                                "${Provider.of<stringNotiferSearch>(context).search}",
                                textAlign: TextAlign.right,
                                textColor: kSpecialColor,
                              ),
                            ],
                          )),
                      SizedBox(
                        height: hSpace,
                      )
                    ],
                  ),
                widget.items.isNotEmpty && widget.items.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => widget.family == false
                                        ? ProductProfileScreen(
                                            product_id:
                                                "${widget.items[index].id}",
                                          )
                                        : FamilyProfileScreen(
                                            id: widget.items[index].id,
                                          ),
                                  ),
                                );
                              },
                              child: CardWidget(
                                  widget.family == true
                                      ? SingleChildScrollView(
                                          child: Center(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: SizeConfig.scaleWidth(
                                                      300),
                                                  height:
                                                      SizeConfig.scaleHeight(
                                                          23),
                                                  child: Center(
                                                    child: ListView.builder(
                                                        reverse: true,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: widget
                                                            .items[index]
                                                            .categories!
                                                            .length,
                                                        itemBuilder:
                                                            (context, indexx) {
                                                          return Container(
                                                            width: SizeConfig
                                                                .scaleWidth(
                                                                    105),
                                                            alignment: Alignment
                                                                .center,
                                                            child: StyleText(
                                                              Localizations.localeOf(
                                                                              context)
                                                                          .languageCode ==
                                                                      "ar"
                                                                  ? "${widget.items[index].categories![indexx].arname}"
                                                                  : "${widget.items[index].categories![indexx].enname}",
                                                              textColor:
                                                                  kSpecialColor,
                                                              maxLines: 5,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Column(),
                                  family: widget.family == true ? true : false,
                                  familyName: widget.family == true
                                      ? "${widget.items[index].name}"
                                      : "",
                                  productName: widget.family == false
                                      ? Localizations.localeOf(context)
                                                  .languageCode ==
                                              "ar"
                                          ? "${widget.items[index].arname}"
                                          : "${widget.items[index].enname}"
                                      : "",
                                  familyLocation: widget.family == false
                                      ? "${widget.items[index].km}"
                                      : "${widget.items[index].mile}",
                                  price: widget.family == false
                                      ? "${widget.items[index].offerPrice} ${AppLocalizations.of(context)!.reyal}"
                                      : "",
                                  priceBefore: widget.family == false
                                      ? "${widget.items[index].price}"
                                      : "",
                                  discountBoolCard: widget.family == false &&
                                      widget.items[index].offerDiscount != 0,
                                  discount: widget.family == false
                                      ? "${widget.items[index].offerDiscount} %"
                                      : "",
                                  time: widget.family == false
                                      ? "${widget.items[index].durationTo}-${widget.items[index].durationFrom} "
                                          "${widget.items[index].durationUnit == "h" ? AppLocalizations.of(context)!.hour : "${widget.items[index].durationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} "
                                      : "",
                                  rate: widget.family == false
                                      ? " ${widget.items[index].familyrate}"
                                      : " ${widget.items[index].rate}",
                                  timer: widget.family == false
                                      ? widget.sales == true
                                          ? "${widget.items[index].offerDuration} "
                                              "${widget.items[index].offerDurationUnit == "h" ? AppLocalizations.of(context)!.hour : "${widget.items[index].offerDurationUnit}" == "m" ? AppLocalizations.of(context)!.minute : AppLocalizations.of(context)!.day} "
                                          : ""
                                      : "",
                                  state: widget.family == false
                                      ? widget.sales == false
                                          ? widget.items[index].familystatus
                                          : 10
                                      : widget.items[index].available,
                                  image: widget.family == false
                                      ? "${widget.items[index].images}"
                                      : "${widget.items[index].image}")
                              // : widget.family?noContent(context,AppLocalizations.of(context)!.thereIsnoFamiliesInThislocation):widget.sales? noContent(context,AppLocalizations.of(context)!.thereIsnoSales):noContent(context,AppLocalizations.of(context)!.thereIsnoProductsInThislocation),

                              );
                        },
                      )
                    : widget.sales
                        ? noContent(context,
                            AppLocalizations.of(context)!.thereIsnoSales,
                            height: 140)
                        : widget.family
                            ? noContent(
                                context,
                                AppLocalizations.of(context)!
                                    .thereIsnoFamiliesInThislocation,
                                height: 140)
                            : noContent(
                                context,
                                AppLocalizations.of(context)!
                                    .thereIsnoProductsInThislocation,
                                height: 140)
              ],
            );
          }
        }),
      ),
    );
  }
}
