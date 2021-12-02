import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:producer_family_app/components/containers/container_app.dart';
import 'package:producer_family_app/components/show_dialoge.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/family_controller/categories_family_controller.dart';
import 'package:producer_family_app/storage/providersAndGetx/family_getx.dart';
import 'package:producer_family_app/style/size_config.dart';
import 'package:producer_family_app/style/style_button.dart';
import 'package:producer_family_app/style/style_colors.dart';
import 'package:producer_family_app/style/style_field.dart';
import 'package:producer_family_app/style/style_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  getCategoriesFamilyGetx cont = Get.find();
  @override
  void dispose() {
    super.dispose();
    addArabicCategory.dispose();
    addEnglishCategory.dispose();

    arabicCategory.dispose();
    englishCategory.dispose();
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
      child: SingleChildScrollView(
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

                      await addCategories(id: 1 );

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
            divider_app(height: SizeConfig.scaleWidth(50)),
            StyleText(
              AppLocalizations.of(context)!.myCategories,
              fontSize: fLargev,
            ),
            SizedBox(
              height: hSpace,
            ),
            GetX<getCategoriesFamilyGetx>(
                builder: (getCategoriesFamilyGetx controller) {
              return controller.isLoading.value
                  ? Column(
                    children: [
                      SizedBox(height: 200,),
                      Center(child: CircularProgressIndicator.adaptive()),
                    ],
                  )
                  : controller.categoriesFamily.length != 0
                      ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.categoriesFamily.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: hSpaceLargev,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        ContainerApp(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: hSpaceSmall,
                                              bottom: hSpaceSmall,
                                            ),
                                            child: StyleText(controller
                                                    .categoriesFamily[index]
                                                    .arname??'' ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: hSpace,
                                        ),
                                        ContainerApp(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                top: hSpaceSmall,
                                                bottom: hSpaceSmall,
                                              ),
                                              child: StyleText(controller
                                                      .categoriesFamily[index]
                                                      .enname??'' ),
                                        ),
                            ),],
                                    ),
                                  ),
                                  SizedBox(
                                    width: wSpaceSmall,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: StyleButton(
                                        AppLocalizations.of(context)!.edit,
                                        onPressed: () {
                                      ShowDialoge(context, onPressed: () async {
                                        Navigator.pop(context);
                                        await updateCategories(
                                            id: controller
                                                    .categoriesFamily[index]
                                                    .id ??
                                                0);
                                        FocusScope.of(context).unfocus();
                                        englishCategory.clear();
                                        arabicCategory.clear();
                                      },
                                          height: 280,
                                          message1:
                                              AppLocalizations.of(context)!
                                                  .edit,
                                          message3: Column(
                                            children: [
                                              StyleField(
                                                controller: arabicCategory,
                                                hintText: controller
                                                        .categoriesFamily[index]
                                                        .arname??'' ,
                                              ),
                                              SizedBox(
                                                height: hSpace,
                                              ),
                                              StyleField(
                                                hintText: controller
                                                        .categoriesFamily[index]
                                                        .enname??'' ,

                                                controller: englishCategory,
                                              ),
                                            ],
                                          ),
                                          iconMeassge: Icon(
                                            Icons.edit,
                                            color: kSecondaryColor,
                                            size: SizeConfig.scaleHeight(40),
                                          ),
                                          colorButton2: kSecondaryColor,
                                          colorButton1: kConfirm,
                                          button1: AppLocalizations.of(context)!
                                              .edit,
                                          button2: AppLocalizations.of(context)!
                                              .back,
                                          message2: '');
                                    }),
                                  ),
                                  SizedBox(
                                    width: wSpace,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: StyleButton(
                                      AppLocalizations.of(context)!.delete,
                                      onPressed: () async {
                                        await deleteCategories(
                                          id: controller
                                                  .categoriesFamily[index].id ??
                                              0,
                                        );
                                      },
                                      backgroundColor: kRefuse,
                                      sideColor: kRefuse,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : noContent(context,
                          AppLocalizations.of(context)!.thereIsnoCategories,
                          height: 200);
            }),
          ],
        ),
      ),
    );
  }

  Future addCategories({ int? id}) async {
    if (addArabicCategory.text.isNotEmpty ||
        addEnglishCategory.text.isNotEmpty) {
      await cont.addCategories(
        id: id!,
        context: context,
        arname: addArabicCategory.text,
        enname: addEnglishCategory.text,
      );
    } else {
      Helper(
          context: context,
          message: AppLocalizations.of(context)!.pleaseEnterCorrectData,
          error: true);
    }
  }

  Future updateCategories({required int id}) async {
    await cont.updateCategories(
        arname: arabicCategory.text,
        enname: englishCategory.text,
        category_id: id,
        context: context);
  }

  Future deleteCategories({
    required int id,
  }) async {
    await cont.deleteCategories(
      context: context,
      category_id: id,
    );
  }
}
