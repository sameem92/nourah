import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late TextEditingController addArabicCategory;
  late TextEditingController addEnglishCategory;

  late TextEditingController arabicCategory;
  late TextEditingController englishCategory;

  @override
  void initState() {
    super.initState();
    addArabicCategory = TextEditingController();
    addEnglishCategory = TextEditingController();
    addArabicCategory.addListener(() => setState(() {}));
    addEnglishCategory.addListener(() => setState(() {}));

    arabicCategory = TextEditingController();
    englishCategory = TextEditingController();
    arabicCategory.addListener(() => setState(() {}));
    englishCategory.addListener(() => setState(() {}));
  }

  GetCategoriesFamilyGetx cont = Get.find();
  @override
  void dispose() {
    addArabicCategory.dispose();
    addEnglishCategory.dispose();

    arabicCategory.dispose();
    englishCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: wPadding,
        end: wPadding,
        top: hPadding,
        bottom: hPadding,
      ),
      child: Column(
        children: [
          SizedBox(
            height: hSpaceSmall,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: StyleField(
                        title: "تصنيف",
                        controller: addArabicCategory,
                      ),
                    ),
                    SizedBox(
                      height: hSpace,
                    ),
                    SizedBox(
                      height: SizeConfig.scaleHeight(50),
                      child: StyleField(
                        title: "Category",
                        controller: addEnglishCategory,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: wSpace,
              ),
              Expanded(
                flex: 1,
                child: StyleButton(
                  AppLocalizations.of(context)!.addProductsOffers,
                  onPressed: () async {
                    await addCategories(id: 1);

                    FocusScope.of(context).unfocus();
                    addArabicCategory.clear();
                    addEnglishCategory.clear();
                  },
                  sideColor: kConfirm,
                  backgroundColor: kConfirm,
                ),
              ),
            ],
          ),
          dividerApp(height: SizeConfig.scaleWidth(35)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StyleText(
                    AppLocalizations.of(context)!.myCategories,
                    fontSize: fLargev,
                  ),
                  SizedBox(
                    height: hSpaceSmall,
                  ),
                  GetX<GetCategoriesFamilyGetx>(
                      builder: (GetCategoriesFamilyGetx controller) {
                    Future<void> getData() async {
                      await controller.refreshData();
                    }

                    return RefreshIndicator(
                        onRefresh: getData,
                        child: controller.isLoading.value
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 200,
                                  ),
                                  const Center(
                                      child:
                                          CircularProgressIndicator.adaptive()),
                                ],
                              )
                            : controller.categoriesFamily.isNotEmpty
                                ? ListView.builder(
                                    // reverse: true,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        controller.categoriesFamily.length,
                                    itemBuilder: (context, index) {
                                      int reverseIndex =
                                          controller.categoriesFamily.length -
                                              1 -
                                              index;

                                      return Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          bottom: hSpaceLarge,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialoge(
                                                          context,
                                                          onPressed: () async {
                                                        Navigator.pop(context);
                                                        await updateCategories(
                                                            reverseIndex:
                                                                reverseIndex,
                                                            id: controller
                                                                    .categoriesFamily[
                                                                        reverseIndex]
                                                                    .id ??
                                                                0);
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        englishCategory.clear();
                                                        arabicCategory.clear();
                                                      },
                                                          height: 280,
                                                          message1:
                                                              AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .edit,
                                                          message3: Column(
                                                            children: [
                                                              StyleField(
                                                                controller:
                                                                    arabicCategory,
                                                                hintText: controller
                                                                    .categoriesFamily[
                                                                        reverseIndex]
                                                                    .arname,
                                                              ),
                                                              SizedBox(
                                                                height: hSpace,
                                                              ),
                                                              StyleField(
                                                                hintText: controller
                                                                    .categoriesFamily[
                                                                        reverseIndex]
                                                                    .enname,
                                                                controller:
                                                                    englishCategory,
                                                              ),
                                                            ],
                                                          ),
                                                          iconMeassge: Icon(
                                                            Icons.edit,
                                                            color:
                                                                kSpecialColor,
                                                            size: SizeConfig
                                                                .scaleHeight(
                                                                    40),
                                                          ),
                                                          colorButton2:
                                                              kSecondaryColor,
                                                          colorButton1:
                                                              kConfirm,
                                                          button1:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .edit,
                                                          button2:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .back,
                                                          message2: '');
                                                    },
                                                    child: ContainerApp(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: hSpaceSmall,
                                                          bottom: hSpaceSmall,
                                                        ),
                                                        child: StyleText(controller
                                                            .categoriesFamily[
                                                                reverseIndex]
                                                            .arname),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: hSpace,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialoge(context,
                                                          onPressed: () async {
                                                        Navigator.pop(context);
                                                        await updateCategories(
                                                            reverseIndex:
                                                                reverseIndex,
                                                            id: controller
                                                                    .categoriesFamily[
                                                                        reverseIndex]
                                                                    .id ??
                                                                0);
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                        englishCategory.clear();
                                                        arabicCategory.clear();
                                                      },
                                                          height: 280,
                                                          message1:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .edit,
                                                          message3: Column(
                                                            children: [
                                                              StyleField(
                                                                controller:
                                                                    arabicCategory,
                                                                hintText: controller
                                                                    .categoriesFamily[
                                                                        reverseIndex]
                                                                    .arname,
                                                              ),
                                                              SizedBox(
                                                                height: hSpace,
                                                              ),
                                                              StyleField(
                                                                hintText: controller
                                                                    .categoriesFamily[
                                                                        reverseIndex]
                                                                    .enname,
                                                                controller:
                                                                    englishCategory,
                                                              ),
                                                            ],
                                                          ),
                                                          iconMeassge: Icon(
                                                            Icons.edit,
                                                            color:
                                                                kSpecialColor,
                                                            size: SizeConfig
                                                                .scaleHeight(
                                                                    40),
                                                          ),
                                                          colorButton2:
                                                              kSpecialColor,
                                                          colorButton1:
                                                              kConfirm,
                                                          button1:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .edit,
                                                          button2:
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .back,
                                                          message2: '');
                                                    },
                                                    child: ContainerApp(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: hSpaceSmall,
                                                          bottom: hSpaceSmall,
                                                        ),
                                                        child: StyleText(controller
                                                            .categoriesFamily[
                                                                reverseIndex]
                                                            .enname),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: StyleButton(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .edit, onPressed: () {
                                                  showDialoge(context,
                                                      onPressed: () async {
                                                    Navigator.pop(context);
                                                    await updateCategories(
                                                        reverseIndex:
                                                            reverseIndex,
                                                        id: controller
                                                                .categoriesFamily[
                                                                    reverseIndex]
                                                                .id ??
                                                            0);
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    englishCategory.clear();
                                                    arabicCategory.clear();
                                                  },
                                                      height: 280,
                                                      message1: AppLocalizations
                                                              .of(context)!
                                                          .edit,
                                                      message3: Column(
                                                        children: [
                                                          StyleField(
                                                            controller:
                                                                arabicCategory,
                                                            hintText: controller
                                                                .categoriesFamily[
                                                                    reverseIndex]
                                                                .arname,
                                                          ),
                                                          SizedBox(
                                                            height: hSpace,
                                                          ),
                                                          StyleField(
                                                            hintText: controller
                                                                .categoriesFamily[
                                                                    reverseIndex]
                                                                .enname,
                                                            controller:
                                                                englishCategory,
                                                          ),
                                                        ],
                                                      ),
                                                      iconMeassge: Icon(
                                                        Icons.edit,
                                                        color: kSpecialColor,
                                                        size: SizeConfig
                                                            .scaleHeight(40),
                                                      ),
                                                      colorButton2:
                                                          kSpecialColor,
                                                      colorButton1: kConfirm,
                                                      button1:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .edit,
                                                      button2:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .back,
                                                      message2: '');
                                                }),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: StyleButton(
                                                  AppLocalizations.of(context)!
                                                      .delete,
                                                  onPressed: () async {
                                                    await deleteCategories(
                                                      id: controller
                                                              .categoriesFamily[
                                                                  reverseIndex]
                                                              .id ??
                                                          0,
                                                    );
                                                  },
                                                  backgroundColor: kGrey,
                                                  sideColor: kGrey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    })
                                : noContent(
                                    context,
                                    AppLocalizations.of(context)!
                                        .thereIsnoCategories,
                                    height: 200));
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future addCategories({int? id}) async {
    if (addArabicCategory.text.isNotEmpty ||
        addEnglishCategory.text.isNotEmpty) {
      await cont.addCategories(
        id: id!,
        context: context,
        arname: addArabicCategory.text,
        enname: addEnglishCategory.text,
      );
    } else {
      helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
    }
  }

  Future updateCategories({required int id, required int reverseIndex}) async {
    print(id);
    await cont.updateCategories(
        arname: arabicCategory.text.isNotEmpty
            ? arabicCategory.text
            : cont.categoriesFamily[reverseIndex].arname,
        enname: englishCategory.text.isNotEmpty
            ? englishCategory.text
            : cont.categoriesFamily[reverseIndex].enname,
        categoryId: id,
        context: context);
  }

  Future deleteCategories({
    required int id,
  }) async {
    await cont.deleteCategories(
      context: context,
      categoryId: id,
    );
  }
}
