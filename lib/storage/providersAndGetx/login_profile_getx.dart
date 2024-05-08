import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:producer_family_app/storage/api/login_profile_controller.dart';

class getProfileGetx extends GetxController {
  RxMap<dynamic, dynamic> profile = <dynamic, dynamic>{}.obs;
  static getProfileGetx get to => Get.find();
  var isLoading = true.obs;
  @override
  void onInit() {
    getProfile();

    super.onInit();
  }

  Future<void> getProfile({BuildContext? context, bool? isUpdated}) async {
    isLoading(true);

    try {
      var show = await LoginAndProfileController()
          .getProfileController(context: context, isUpdated: isUpdated);
      if (show != null) {
        profile.value = show;
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await getProfile(isUpdated: true);
  }

  Future<void> changeValidity({
    required BuildContext context,
    required String available,
  }) async {
    bool edit = await LoginAndProfileController().changeValidityController(
      context,
      language:
          Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      available: available,
    );

    if (edit) {
      getProfile(isUpdated: true);
    }
  }

  Future<void> updateProfile(
      {BuildContext? context,
      String? path2,
      String? path1,
      bool helpBool = true,
      String notes = '',
      String ennotes = '',
      String minimum_order = '',
      String name = '',
      dynamic lat,
      dynamic lng,
      String address = '',
      bool updated = true,
      String email = '',
      String phone = '',
      Function(bool status)? uploadEvent}) async {
    await LoginAndProfileController().updateProfileController(context,
        path2: path2,
        path1: path1,
        notes: notes,
        ennotes: ennotes,
        minimumOrder: minimum_order,
        name: name,
        lat: lat,
        lng: lng,
        helpBool: helpBool,
        address: address,
        email: email,
        phone: phone,
        language: context != null
            ? Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en"
            : "ar", uploadEvent: (bool status) {
      {
        // print("profile updated");
      }
    });
    if (updated) {
      getProfile(isUpdated: true);
    }
  }

  Future<void> updateLatLan(
      {BuildContext? context,
      bool helpBool = true,
      dynamic lat,
      dynamic lng,
      String? address,
      bool updated = true,
      Function(bool status)? uploadEvent}) async {
    await LoginAndProfileController().updateLatLanController(context,
        address: address,
        lat: lat,
        lng: lng,
        helpBool: helpBool,
        language: context != null
            ? Localizations.localeOf(context).languageCode == "ar"
                ? "ar"
                : "en"
            : "ar", uploadEvent: (bool status) {
      {
        // print("profile updated");
      }
    });
    // print(updateIt );
    // if(updateIt){
    if (updated) {
      getProfile(isUpdated: true);
    }
    //   print(updateIt );
    // }
  }

  Future<void> updateNameProfile({
    required BuildContext context,
    String name = '',
  }) async {
    await LoginAndProfileController().updateNameController(
      context,
      name: name,
    );
  }
}
