import 'dart:convert';
import 'dart:io';

import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenu.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/manager/CurrentUserManager.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/DiscoveryPageModel.dart';
import 'package:apple_music/models/ListeningNowPageModel.dart';
import 'package:apple_music/models/UserModel.dart';
import 'package:apple_music/pages/DiscoveryPage.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'dart:io'
as io;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart'
as http;
final getIt = GetIt.instance;

void setUpGetIt() {
  // set up audio state manager
  http.Client client = http.Client();
  getIt.registerLazySingleton < AudioManager > (() => AudioManager());
  getIt.registerLazySingleton < AudioPageRouteManager > (() => AudioPageRouteManager());
  getIt.registerLazySingleton < CurrentUserManager > (() => CurrentUserManager());
  // getIt.registerLazySingleton<Map<String, GlobalKey>>(() => Map());
  getIt.registerLazySingleton < ContextMenuManager > (() => ContextMenuManager());
  getIt.registerLazySingleton < ListeningNowPageModel > (() => ListeningNowPageModel());
  getIt.registerLazySingleton < DiscoveryPageModel > (() => DiscoveryPageModel());

  print(Platform.environment.containsKey('FLUTTER_TEST'));
  if (!isTestingMode) {
    getIt.registerLazySingleton<LoginUtil>(() => LoginUtil());
    getIt.registerLazySingleton<http.Client>(() => client);
  } 
  
}
class LoginUtil {
  static final LoginUtil _singleton = LoginUtil._internal();
  factory LoginUtil() {
    return _singleton;
  }
  LoginUtil._internal();
   Future < bool > checkLoginStatus() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('${path}/${CREDENTIAL_PATH}');
    if (!file.existsSync()) {
      return false;
    } else {
      String appToken = await file.readAsString();
      UserModel user = await getUserInfo(appToken);
      if (GetIt.I.isRegistered<UserModelNotifier>() & GetIt.I.isRegistered<CredentialModelNotifier>()) {
        GetIt.I.unregister<UserModelNotifier>();
        GetIt.I.unregister<CredentialModelNotifier>();
      }
      GetIt.I.registerLazySingleton<UserModelNotifier>(() => UserModelNotifier(user));
        GetIt.I.registerLazySingleton<CredentialModelNotifier>(() => CredentialModelNotifier(CredentialModel(appToken)));
      return true;
    }
  } catch (e) {
    return false;
  }
}

Future < bool > saveCredential(String app_token) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File file = File('${path}/${CREDENTIAL_PATH}');
    await file.writeAsString(app_token);
    return true;
  } catch (e) {
    return false;
  }



}

 Future < UserModel > getUserInfo(String appToken) async {
  Uri httpURI = Uri(scheme: "http", host: SV_HOSTNAME, port: SV_PORT, path: MY_PROFILE_PATH, queryParameters: {
    'app_token': appToken
  });
  http.Response res = await http.get(httpURI);
  JsonDecoder decoder = JsonDecoder();
  UserModel user = UserModel.fromJson(decoder.convert(res.body));
  CurrentUserManager currentUserManager = getIt < CurrentUserManager > ();
  currentUserManager.setCurrentUser(user);
  return user;
}
}