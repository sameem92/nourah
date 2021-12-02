import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:producer_family_app/components/show_helper.dart';
import 'package:producer_family_app/storage/api/api_links.dart';
import 'package:producer_family_app/storage/models/login_modal.dart';
import '../shared_preferences_controller.dart';

class loginAndProfileController {
  Future<bool> loginController(
    BuildContext context, {
    required String email,
    required String password,
    String language = "",
    String firebase_token = '',
  }) async {
    var url = Uri.parse(ApiLinks.login);
    var response = await http.post(url, body: {
      'email': email,
      'password': password,
      "firebase_token": firebase_token
    }, headers: {
      "Accept-Language": language,
      "accept": "application/json"
    });

    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      await SharedPreferencesController().save(loginModal);
      await getProfileController();
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
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
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      print(jsonDecode(response.body)['message']);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
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
      print(jsonDecode(response.body)['data']);
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
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
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      print(jsonDecode(response.body)['data']);
      print(' password is $password');

      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> changeValidityController(BuildContext context,
      {required String available, String language = ''}) async {
    var url = Uri.parse(ApiLinks.change_availablity);

    var response = await http.post(url, body: {
      "available": available,
    }, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'accept': 'application/json',
      'Accept-Language': language,
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode < 400) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
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
      print(jsonDecode(response.body)['data']);
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      print(' password is $password');

      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    }
    return false;
  }

//*********************************************************************************************

  Future<bool> updateProfileController(BuildContext context,
      {String? path1 = "",
      String? path2 = "",
      String name = "",
      String email = "",
      String phone = "",
      String notes = "",
      String minimum_order = "",
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
    multiPartRequest.fields['phone'] = phone;
    multiPartRequest.fields['notes'] = notes;
    multiPartRequest.fields['ennotes'] = ennotes;
    multiPartRequest.fields['minimum_order'] = minimum_order;

    var response = await multiPartRequest.send();
response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);
      if (response.statusCode < 400) {
        Helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(true);
      } else if (response.statusCode == 500) {
        Helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        Helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      }
    });

    return false;
  }

//*********************************************************************************************

  Future getProfileController({BuildContext? context}) async {
    var url = Uri.parse(ApiLinks.profile);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: SharedPreferencesController().token,
      'X-Requested-With': 'XMLHttpRequest',
      'accept': 'application/json',
      'content-type': 'application/json'
    });

    if (response.statusCode < 400) {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);

      Map<String, dynamic> jsonMap =
          Map<String, dynamic>.from(json.decode(response.body)['data']);
      await SharedPreferencesController().saveId(jsonMap['id']);
      return jsonMap;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    }
    return null;
  }

//*********************************************************************************************

  Future<bool> activeCodeUserController(
      {BuildContext? context,
      String firebase_token = '',
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
      'firebase_token': firebase_token,
    });
    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      await SharedPreferencesController().save(loginModal);
      return true;
    } else if (response.statusCode == 500) {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
    } else {
      if (context != null)
        Helper(
            context: context,
            message: jsonDecode(response.body)['message'],
            error: true);
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
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
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
    String firebase_token = '',
  }) async {
    var url = Uri.parse(ApiLinks.register);

    var response = await http.post(url, body: {
      'email': email,
      'login_type': 'google',
      'firebase_token': firebase_token,
    }, headers: {
      'accept': 'application/json',
      'Accept-Language': language
    });

    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body);
      LoginModal loginModal = LoginModal.fromJson(jsonResponse['data']);
      await SharedPreferencesController().save(loginModal);
      await SharedPreferencesController().saveLoggedInUser();
      await SharedPreferencesController().saveLoggedInUserGoogle();
      Navigator.pushNamedAndRemoveUntil(
          context, "/mainScreen", (Route<dynamic> route) => false);

      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);

      print(jsonResponse);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
    } else {
      Helper(
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
    String firebase_token = '',
    String phone = "",
  }) async {
    var url = Uri.parse(ApiLinks.register);

    var response = await http.post(url, body: {
      'phone': phone,
      'login_type': 'phone',
      'firebase_token': firebase_token,
    }, headers: {
      'accept': 'application/json',
      'Accept-Language': language
    });

    if (response.statusCode < 400) {
      var jsonResponse = jsonDecode(response.body)['data'];
      // Helper(context: context, message: jsonDecode(response.body)['data'], error: true,);

      print(jsonResponse);
      return true;
    } else if (response.statusCode == 500) {
      Helper(
          context: context,
          message: jsonDecode(response.body)['message'],
          error: true);
      // Helper(context: context, message: jsonDecode(response.body)['data'], error: true,);
    } else {
      Helper(
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
      String city = '',
      String identity_number = '',
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

    var multiPartFile = await http.MultipartFile.fromPath("image", path);
    multiPartRequest.files.add(multiPartFile);
    multiPartRequest.fields['login_type'] = "delivery";
    multiPartRequest.fields['name'] = name;
    multiPartRequest.fields['email'] = email;
    multiPartRequest.fields['phone'] = phone;
    multiPartRequest.fields['city'] = city;
    multiPartRequest.fields['identity_number'] = identity_number;
    multiPartRequest.fields['lat'] = lat;
    multiPartRequest.fields['lng'] = lng;
    multiPartRequest.fields['address'] = address;

    var response = await multiPartRequest.send();
    response.stream.transform(utf8.decoder).listen((event) {
      var responseBody = jsonDecode(event);

      if (response.statusCode < 400) {
        Helper(context: context, message: responseBody['message'], error: true);

        uploadEvent(true);
      } else if (response.statusCode == 500) {
        Helper(context: context, message: responseBody['message'], error: true);
        uploadEvent(false);
      } else {
        Helper(context: context, message: responseBody['message'], error: true);
      }
    });

    return false;
  }
}
