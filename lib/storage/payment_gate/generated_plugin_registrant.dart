//
// Generated file. Do not edit.
//
import 'package:connectivity_plus/connectivity_plus.dart';

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

// import 'package:connectivity_for_web/connectivity_for_web.dart';
import 'package:device_info_plus_web/device_info_plus_web.dart';
import 'package:package_info_plus_web/package_info_plus_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  // ConnectivityPlugin.registerWith(registrar);
  DeviceInfoPlusPlugin.registerWith(registrar);
  PackageInfoPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
