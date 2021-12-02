import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:producer_family_app/storage/api/app_controller.dart';
import 'package:producer_family_app/storage/models/app_modal/faq_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/message_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/notification_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/social_media_modal.dart';
import 'package:producer_family_app/storage/models/app_modal/statistics.dart';



class getAboutUsGetx extends GetxController {
  String Language;

  getAboutUsGetx({this.Language = 'ar'});
  RxMap<String, dynamic> aboutUs = <String, dynamic>{}.obs;
  static getAboutUsGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getAboutUs();
    super.onInit();
  }

  Future<void> getAboutUs({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getAboutUsController(context: context, Language: Language);
      if (show != null) {
        aboutUs.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class getprivacyGetx extends GetxController {
  String Language;

  getprivacyGetx({this.Language = 'ar'});

  RxMap<String, dynamic> privacies = <String, dynamic>{}.obs;
  static getSocialGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getPrivacy();
    super.onInit();
  }

  Future<void> getPrivacy({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getPrivacyController(context: context, Language: Language);
      if (show != null) {
        privacies.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class getSocialGetx extends GetxController {
  RxList<SocialMediaModal> socials = <SocialMediaModal>[].obs;
  static getSocialGetx get to => Get.find();
  var isLoading = true.obs;

  @override
  void onInit() {
    getSocials();
    super.onInit();
  }

  Future<void> getSocials({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController().getSocialMediaController(
        context: context,
      );
      if (show != null) {
        socials.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class getFaqGetx extends GetxController {
  String Language;

  getFaqGetx({this.Language = "ar"});

  var isLoading = true.obs;
  RxList<FaqModal> faqs = <FaqModal>[].obs;
  static getFaqGetx get to => Get.find();
  @override
  void onInit() {
    getFaqs();
    super.onInit();
  }
  // Localizations.localeOf(context).languageCode=="ar"?"ar":"en"

  Future<void> getFaqs({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getFaqController(context: context, Language: Language);
      if (show != null) {
        faqs.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class getMessageGetx extends GetxController {
  var isLoading = true.obs;
  String language;

  getMessageGetx({this.language = ""});

  RxList<MessagesModal> messages = <MessagesModal>[].obs;
  static getMessageGetx get to => Get.find();
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  Future<void> getMessages({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getMessageController(context: context, language: language);
      if (show != null) {
        messages.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
  Future<void> sendMessage({
    required BuildContext context,
    required String message,
  }) async {
    bool add = await  AppController().postMessageController(

      language:
      Localizations.localeOf(context).languageCode == "ar" ? "ar" : "en",
      message: message,
    );

    if (add) {
      getMessages();
    }
  }
}

class getstatisticsGetx extends GetxController {
  var isLoading = true.obs;

  RxMap<String, dynamic> statistices = <String, dynamic>{}.obs;
  static getstatisticsGetx get to => Get.find();
  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }

  Future<void> getStatistics({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController().getStatisticsController(
        context: context,
      );
      if (show != null) {
        statistices.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class getCoulmnstatisticsGetx extends GetxController {
  RxList<StatisticssModal> statistices = <StatisticssModal>[].obs;
  var isLoading = true.obs;
  static getstatisticsGetx get to => Get.find();
  @override
  void onInit() {
    getStatistics();
    super.onInit();
  }

  Future<void> getStatistics({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController().getColumnStatisticsController(
        context: context,
      );
      if (show != null) {
        statistices.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}

class getNotificationsGetx extends GetxController {
  var isLoading = true.obs;
  RxList<NotificationsModal> notifications = <NotificationsModal>[].obs;
  static getMessageGetx get to => Get.find();
  @override
  void onInit() {
    getMessages();
    super.onInit();
  }

  Future<void> getMessages({BuildContext? context}) async {
    isLoading(true);
    try {
      var show = await AppController()
          .getNotificationController(context: context,);
      if (show != null) {
        notifications.value = show;
      }
    } finally {
      isLoading(false);
    }
  }
}
