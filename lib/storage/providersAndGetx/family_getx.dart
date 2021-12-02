import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/family_controller/categories_family_controller.dart';
import 'package:producer_family_app/storage/api/family_controller/family_controller.dart';
import 'package:producer_family_app/storage/api/family_controller/products_family_controller.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';
import 'package:producer_family_app/storage/models/family_modal/get_categories_modal.dart';
import 'package:producer_family_app/storage/models/family_modal/products_family.dart';

class getFamilyPolicyGetx extends GetxController {
  var isLoading = true.obs;

  RxMap<String, dynamic> policies = <String, dynamic>{}.obs;

  static getFamilyPolicyGetx get to => Get.find();

  @override
  void onInit() {
    getPolicy();
    super.onInit();
  }

  Future<void> getPolicy({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await FamilyController()
          .getFamilyPoliciesController(context: context);
      if (show != null) {
        policies.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
  Future<void> addPolicies(

      {required BuildContext context,required String  arPolicy,required String  enPolicy,}) async {
    bool add=await  FamilyController().addPoliciesFamilyController(context,

      language: Localizations.localeOf(context).languageCode == "ar"
          ? "ar"
          : "en", enPolicy: enPolicy, arPolicy: arPolicy,
    );

    if (add) {
      getPolicy();
    }
  }
}
//***********************************************************

class getCategoriesFamilyGetx extends GetxController {
  var isLoading = true.obs;

  RxList<CategoriesModalFamily> categoriesFamily =
      <CategoriesModalFamily>[].obs;

  static getCategoriesFamilyGetx get to => Get.find();

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  Future<void> getCategory({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await CategoriesFamilyController()
          .getFamilyCategoriesController(context: context);
      if (show != null) {
        categoriesFamily.value = show;
        getCategoriesFamilyGetx().getCategory();

      }
    } finally {
      isLoading(false);
    }
  }
  Future<void> addCategories(

      {required BuildContext context,required String  arname,required String  enname,required int id}) async {
   bool add=await  CategoriesFamilyController().
    addCategoriesFamilyController(context,

        language: Localizations.localeOf(context).languageCode == "ar"
            ? "ar"
            : "en", arname: arname, enname: enname,id:id
        );

    if (add) {
      categoriesFamily.add(CategoriesModalFamily(arname: arname,enname: enname,id: id));

    }
  }


  Future<void> deleteCategories(

      {required BuildContext context,required int category_id }) async {
    bool delete=await  CategoriesFamilyController().
    deleteCategoriesFamilyController(category_id:category_id.toString() ,

      language: Localizations.localeOf(context).languageCode == "ar"
          ? "ar"
          : "en", context: context,
    );

    if (delete) {
      categoriesFamily.removeWhere((element) => element.id == category_id);


    }
  }

  Future<void> updateCategories(

      {required BuildContext context,required String  arname,required String  enname,required int category_id }) async {
    bool update=
    await  CategoriesFamilyController().
    updateCategoriesFamilyController(context,

      language: Localizations.localeOf(context).languageCode == "ar"
          ? "ar"
          : "en", enname: enname, arname: arname, category_id: category_id.toString(),
    );

    if (update) {
      categoriesFamily.removeWhere((element) => element.id == category_id);

      categoriesFamily.add(CategoriesModalFamily(arname: arname,enname: enname,id: category_id));

    }
  }
}
//***********************************************************

class getProductsFamilyGetx extends GetxController {
  var isLoading = true.obs;
String language='';
  RxList<ProductsModalFamily> productsFamily = <ProductsModalFamily>[].obs;
  getProductsFamilyGetx({this.language = ''});
  static getProductsFamilyGetx get to => Get.find();

  @override
  void onInit() {
    getProductFamily();
    super.onInit();
  }

  Future<void> getProductFamily({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await ProductFamilyController()
          .getFamilyProductsController(context: context,language:language );
      if (show != null) {
        productsFamily.value = show;

      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduct(
      {required BuildContext context, required int id}) async {
    bool deleted = await ProductFamilyController()
        .deleteProductFamilyController(
            context: context,
            language: Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en",
            product_id: id.toString());

    if (deleted) {
      productsFamily.removeWhere((element) => element.id == id);
    }
  }

  Future<void> editProduct(BuildContext context,
      {String? path1 = "",
      String? path2 = "",
     required int product_id ,
      String image_id = '',
      required int category ,
      String arname = '',
      String enname = '',
      String price = '',
      String duration_from = '',
      String duration_to = '',
      String duration_unit = '',
      String offer_duration = '',
      String offer_duration_unit = '',
      String language = '',
      String offer_price = '',
      int offerDiscount = 0,

      String ardesc = '',

      String endesc = '',
      required Function(bool status ) uploadEvent }) async
  {
   await ProductFamilyController().editProductController(
        context,
        uploadEvent: uploadEvent,

        language: language,

        product_id: product_id.toString(),
        category: category.toString(),
        enname: enname,
        arname: arname,
        ardesc: ardesc,
        duration_from: duration_from,
        duration_to: duration_to,
        duration_unit: duration_unit,
        endesc: endesc,
        image_id: image_id,
        offer_duration: offer_duration,
        offer_duration_unit: offer_duration_unit,
        offer_price: offer_price,
        path1: path1,
        path2: path2,
        price: price);


      productsFamily.removeWhere((element) => element.id == product_id);

      productsFamily.add(ProductsModalFamily(id: product_id
      ,price: price,
        durationUnit:duration_unit ,
        durationTo: duration_to,
        durationFrom:duration_from ,
        ardesc: ardesc,
        endesc:endesc ,enname:enname ,arname:arname ,category:category
        ,offerDuration:offer_duration ,offerDurationUnit:offer_duration_unit ,offerPrice:offer_price ,
offerDiscount: offerDiscount,
images: <Images>[]
      ));


  }


  Future<void> addProduct(BuildContext context,
      {String? path1 = "",
        String? path2 = "",

        String image_id = '',
        required int category ,
        String arname = '',
        String enname = '',
        String price = '',
        String duration_from = '',
        String duration_to = '',
        String duration_unit = '',
        String offer_duration = '',
        String offer_duration_unit = '',
        String offer_price = '',
        int offerDiscount = 0,
        int product_id = 0,
        String ardesc = '',
        String endesc = '',
        required Function(bool status ) uploadEvent }) async
  {
     await ProductFamilyController().adddProductController(
        context,
        uploadEvent: uploadEvent,

        language: Localizations.localeOf(context).languageCode == "ar"
            ? "ar"
            : "en",

        category: category,
        enname: enname,
        arname: arname,
        ardesc: ardesc,
        duration_from: duration_from,
        duration_to: duration_to,
        duration_unit: duration_unit,
        endesc: endesc,
        image_id: image_id,
        offer_duration: offer_duration,
        offer_duration_unit: offer_duration_unit,
        offer_price: offer_price,
        path1: path1,
        path2: path2,
        price: price);



    productsFamily.add(ProductsModalFamily(id: product_id
        ,price: price,
        durationUnit:duration_unit ,
        durationTo: duration_to,
        durationFrom:duration_from ,
        ardesc: ardesc,
        endesc:endesc ,enname:enname ,arname:arname ,category:category
        ,offerDuration:offer_duration ,offerDurationUnit:offer_duration_unit ,offerPrice:offer_price ,
        offerDiscount: offerDiscount,
        images: <Images>[]
    ));


  }
}

//***********************************************************
class getOneProductFamilyGetx extends GetxController {
  RxMap<String, dynamic> oneProduct = <String, dynamic>{}.obs;

  static getOneProductFamilyGetx get to => Get.find();

  @override
  void onInit() {
    getProductFamily();
    super.onInit();
  }

  Future<void> getProductFamily({BuildContext? context}) async {
    oneProduct.value = await ProductFamilyController()
        .getFamilyOneProductsController(context: context);
  }
}
