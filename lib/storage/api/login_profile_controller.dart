import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/login_modal.dart';

import '../shared_preferences_controller.dart';

class LoginAndProfileController {
  Future<bool> loginController(
    BuildContext context, {
    required String email,
    required String loginType,
    required String password,
    String language = "",
    String firebaseToken = '',
  }) async {
    var url = Uri.parse(ApiLinks.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
      "firebase_token": firebaseToken,
      "login_type": loginType
    }, headers: {
      "Accept-Language": language,
      "accept": "application/json"
    });

    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      await SharedPreferencesController().save(loginModal);
      await getProfileController();
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> logoutController(BuildContext context,
      {String language = ""}) async {
    var url = Uri.parse(ApiLinks.logout);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return Localizations.localeOf(context).languageCode == "ar"
          ? jsonDecode(response.body)['message'] == 'تم تسجيل الخروج بنجاح'
          : jsonDecode(response.body)['message'] == 'Successfully logged out'
              ? true
              : false; // Helper(

      // return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************
  Future<bool> deleteAcountController(BuildContext context,
      {String language = ""}) async {
    var url = Uri.parse(ApiLinks.deleteAccount);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'content-type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-Language': language
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      // print(jsonDecode(response.body)['message']);
      return true;
    } else if (response.statusCode == 500)
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> forgetpasswordController(BuildContext context,
      {required String email, String language = ""}) async {
    var url = Uri.parse(ApiLinks.forgetpassword);
    var response = await http.post(url, body: {
      'email': email,
    }, headers: {
      "Accept-Language": language,
      "accept": "application/json"
    });
    if (response.statusCode < 400) {
      // print(jsonDecode(response.body)['data']);
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> activeCodeController(
    BuildContext context, {
    required String email,
    String language = "",
    required String code,
    required String password,
  }) async {
    var url = Uri.parse(ApiLinks.activcode);
    var response = await http.post(url, body: {
      'email': email,
      'code': code,
      'password': password,
    }, headers: {
      'Accept-Language': language,
      'accept': 'application/json'
    });
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      await SharedPreferencesController().save(loginModal);
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      // print(jsonDecode(response.body)['data']);
      // print(' password is $password');

      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> changeValidityController(BuildContext context,
      {required String available, String language = ''}) async {
    var url = Uri.parse(ApiLinks.changeAvailablity);

    var response = await http.post(url, body: {
      "available": available,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> changePasswordController(
    BuildContext context, {
    required String password,
    String language = "",
    required String oldPassword,
  }) async {
    var url = Uri.parse(ApiLinks.changepassword);
    var response = await http.post(url, body: {
      'old_password': oldPassword,
      'password': password,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode < 400) {
      // print(jsonDecode(response.body)['data']);
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      // print(' password is $password');

      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> updateProfileController(BuildContext? context,
      {String? path1 = "",
      String? path2 = "",
      String name = '',
      String email = '',
      String phone = '',
      String notes = '',
      bool helpBool = true,
      dynamic lat,
      dynamic lng,
      String address = '',
      String minimumOrder = "",
      String language = "",
      String ennotes = "",
      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.updateprofile,
    );

    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["accept"] = 'application/json';
    multiPartRequest.headers["Accept-Language"] = language;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;
    var multiPartFile = path1 != null
        ? await http.MultipartFile.fromPath("cover_image", path1)
        : null;
    var multiPartFile2 = path2 != null
        ? await http.MultipartFile.fromPath("image", path2)
        : null;
    multiPartFile != null ? multiPartRequest.files.add(multiPartFile) : null;
    multiPartFile2 != null ? multiPartRequest.files.add(multiPartFile2) : null;
    multiPartRequest.fields['name'] = name;
    multiPartRequest.fields['email'] = email;
    multiPartRequest.fields['lat'] = lat.toString();
    multiPartRequest.fields['lng'] = lng.toString();
    multiPartRequest.fields['address'] = address;
    multiPartRequest.fields['phone'] = phone.toString();
    multiPartRequest.fields['notes'] = notes;
    multiPartRequest.fields['ennotes'] = ennotes;
    multiPartRequest.fields['minimum_order'] = minimumOrder.toString();

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);

      if (response.statusCode < 400) {
        if (context != null && helpBool == true) {
          helper(
              context: context, message: responseBody['message'], error: true);
        }
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        if (context != null) {
          helper(
              context: context, message: responseBody['message'], error: true);
        }
        uploadEvent(false);
      } else {
        if (context != null) {
          helper(
              context: context, message: responseBody['message'], error: true);
        }
        uploadEvent(false);
      }
    });

    return false;
  }
//*********************************************************************************************

  Future<bool> updateLatLanController(BuildContext? context,
      {bool helpBool = true,
      dynamic lat,
      dynamic lng,
      String? address,
      String language = "",
      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.updateprofile,
    );

    var multiPartRequest = http.MultipartRequest('post', url);
    multiPartRequest.headers["X-Requested-With"] = 'XMLHttpRequest';
    multiPartRequest.headers["accept"] = 'application/json';
    multiPartRequest.headers["Accept-Language"] = language;
    multiPartRequest.headers[HttpHeaders.authorizationHeader] =
        SharedPreferencesController().token;

    multiPartRequest.fields['lat'] = lat.toString();
    multiPartRequest.fields['lng'] = lng.toString();
    multiPartRequest.fields['address'] = address.toString();

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);

      if (response.statusCode < 400) {
        if (context != null && helpBool == true) {
          helper(
              context: context, message: responseBody['message'], error: true);
        }
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        if (context != null) {
          helper(
              context: context, message: responseBody['message'], error: true);
        }
        uploadEvent(false);
      } else {
        if (context != null) {
          helper(
              context: context, message: responseBody['message'], error: true);
        }
        uploadEvent(false);
      }
    });

    return false;
  }
//*********************************************************************************************

  Future<bool> updateNameController(
    BuildContext context, {
    String name = '',
  }) async {
    var url = Uri.parse(
      ApiLinks.updateprofile,
    );
    var response = await http.post(url, body: {
      'name': name,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Accept-country': "2"
    });

    if (response.statusCode < 400) {
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }

    return false;
  }

//*********************************************************************************************

  Future getProfileController({BuildContext? context, bool? isUpdated}) async {
    String fileName = "getProfileController.json";
    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/$fileName");
    if (isUpdated == true && file.existsSync()) {
      file.deleteSync(recursive: true);
    }
    if (file.existsSync()) {
      // print("getProfileController Loading from cache");
      var response = file.readAsStringSync();
      Map<dynamic, dynamic> jsonMap =
          Map<dynamic, dynamic>.from(json.decode(response)['data']);
      await SharedPreferencesController().saveId(jsonMap['id']);
      return jsonMap;
    } else {
      // print("getProfileController Loading from net");
      var url = Uri.parse(ApiLinks.profile);

      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: SharedPreferencesController().token,
        'X-Requested-With': 'XMLHttpRequest',
        'accept': 'application/json',
        'content-type': 'application/json'
      });

      if (response.statusCode < 400) {
        if (context != null) {
          helper(
              context: context,
              message: jsonDecode(response.body)['message'],
              error: true);
        }

        Map<dynamic, dynamic> jsonMap =
            Map<dynamic, dynamic>.from(json.decode(response.body)['data']);
        await SharedPreferencesController().saveId(jsonMap['id']);
        file.writeAsStringSync(response.body,
            flush: true, mode: FileMode.write);

        return jsonMap;
      } else if (response.statusCode == 500) {
        if (context != null) {
          helper(
              context: context,
              message: jsonDecode(response.body)['message'],
              error: true);
        }
      } else {
        if (context != null) {
          helper(
              context: context,
              message: jsonDecode(response.body)['message'],
              error: true);
        }
      }
      return {};
    }
  }
  //*********************************************************************************************

  Future<bool> activeCodeUserController(
      {required BuildContext context,
      String firebaseToken = '',
      required String phone,
      required String code,
      String language = ""}) async {
    var url = Uri.parse(ApiLinks.activeusercode);

    var response = await http.post(url, headers: {
      'Accept-Language': language,
      'accept': 'application/json',
    }, body: {
      'phone': phone,
      'code': code,
      'firebase_token': firebaseToken,
    });
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      await SharedPreferencesController().save(loginModal);
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
      return Localizations.localeOf(context).languageCode == "ar"
          ? jsonDecode(response.body)['message'] == 'تم التحقق بنجاح'
          : jsonDecode(response.body)['message'] == ' Correct Activation Code'
              ? true
              : false;
    } else if (response.statusCode == 500) {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
    } else {
      if (context != null) {
        helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
      }
    }
    return false;
  }

//*********************************************************************************************
  Future<bool> registerFamilyController({
    required BuildContext context,
    required String name,
    required String language,
    required String email,
    required String phone,
    required List categories,
    required double lat,
    required double lng,
    required String address,
  }) async {
    var url = Uri.parse(ApiLinks.register);

    var response = await http.post(url, body: {
      "login_type": 'family',
      'name': name,
      'email': email,
      'phone': phone,
      "categories": categories.toString(),
      'lat': lat.toString(),
      'lng': lng.toString(),
      "address": address,
    }, headers: {
      'accept': 'application/json',
      'Accept-Language': language
    });
    if (response.statusCode < 400) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

  //*********************************************************************************************
  Future<bool> userRegisterGoogleController(
    BuildContext context, {
    String? email,
    String language = "",
    bool saveLoggedInUserGoogleBool = false,
    bool saveLoggedInUserAppleBool = false,
    String type = "",
    String firebaseToken = '',
  }) async {
    var url = Uri.parse(ApiLinks.register);

    var response = await http.post(url, body: {
      'email': email,
      'login_type': type,
      'firebase_token': firebaseToken,
    }, headers: {
      'accept': 'application/json',
      'Accept-Language': language
    });

    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      if (Localizations.localeOf(context).languageCode == "ar"
          ? jsonDecode(response.body)['message'] == 'تم التسجيل بنجاح'
          : jsonDecode(response.body)['message'] == 'Registered Successfully') {
        await SharedPreferencesController().save(loginModal);
        await SharedPreferencesController().saveLoggedInUser();
        await SharedPreferencesController().saveLoggedInUserGoogle();
      }

      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);

      // print(jsonResponse);
      return Localizations.localeOf(context).languageCode == "ar"
          ? jsonDecode(response.body)['message'] == 'تم التسجيل بنجاح'
          : jsonDecode(response.body)['message'] == 'Registered Successfully'
              ? true
              : false;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }

    return false;
  }

//****************************************************************************

  Future<bool> userRegisterController(
    BuildContext context, {
    String language = "",
    String firebaseToken = '',
    String? phone,
  }) async {
    var url = Uri.parse(ApiLinks.register);

    var response = await http.post(url, body: {
      'phone': phone,
      'login_type': 'phone',
      'firebase_token': firebaseToken,
    }, headers: {
      'accept': 'application/json',
      'Accept-Language': language
    });

    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body)['data'];
      // Helper(context: context, message: jsonDecode(response.body)['data'], error: true,);

      // print(jsonResponse);
      return true;
    } else if (response.statusCode == 500) {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      // Helper(context: context, message: jsonDecode(response.body)['data'], error: true,);
    } else {
      helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }

    return false;
  }

//*********************************************************************
  Future<bool> registerController(BuildContext context,
      {String name = '',
      String language = "",
      String email = '',
      String phone = '',
      String idnumber = '',
      String licenseNumber = '',
      String city = '',
      String lat = '',
      String lng = '',
      String address = '',
      String path = '',
      required Function(bool status) uploadEvent}) async {
    var url = Uri.parse(
      ApiLinks.register,
    );

    var multiPartRequest = http.MultipartRequest('post', url);

    multiPartRequest.headers["accept"] = 'application/json';

    multiPartRequest.headers["Accept-Language"] = language;

    // var multiPartFile = await http.MultipartFile.fromPath("image", path);
    // multiPartRequest.files.add(multiPartFile);
    multiPartRequest.fields['login_type'] = "delivery";
    multiPartRequest.fields['name'] = name;
    multiPartRequest.fields['email'] = email;
    multiPartRequest.fields['phone'] = phone;
    multiPartRequest.fields['license_number'] = licenseNumber;
    // multiPartRequest.fields['city'] = city;
    multiPartRequest.fields['identity_number'] = idnumber;
    multiPartRequest.fields['lat'] = lat;
    multiPartRequest.fields['lng'] = lng;
    multiPartRequest.fields['address'] = address;

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);

      if (response.statusCode < 400) {
        helper(context: context, message: responseBody['message'], error: true);

        uploadEvent(true);
      } else if (response.statusCode == 500) {
        helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        helper(context: context, message: responseBody['message'], error: true);
      }
    });

    return false;
  }
}
