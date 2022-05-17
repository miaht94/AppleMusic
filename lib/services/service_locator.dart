import 'dart:io';

import 'package:apple_music/components/AudioController/AudioManager.dart';
import 'package:apple_music/components/AudioController/AudioPageRouteManager.dart';
import 'package:apple_music/components/ContextMenu/ContextMenuManager.dart';
import 'package:apple_music/constant.dart';
import 'package:apple_music/models/CredentialModel.dart';
import 'package:apple_music/models/DiscoveryPageModel.dart';
import 'package:apple_music/models/ListeningNowPageModel.dart';
import 'package:apple_music/models_refactor/UserModel.dart';
import 'package:apple_music/services/http_util.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart'
as http;
import 'package:path_provider/path_provider.dart';
final getIt = GetIt.instance;

void setUpGetIt() {
  // set up audio state manager
  final http.Client client = http.Client();
  getIt.registerLazySingleton < AudioManager > (() => AudioManager());
  // ignore: cascade_invocations
  getIt.registerLazySingleton < AudioPageRouteManager > (() => AudioPageRouteManager());
  // getIt.registerLazySingleton<Map<String, GlobalKey>>(() => Map());
  // ignore: cascade_invocations
  getIt.registerLazySingleton < ContextMenuManager > (() => ContextMenuManager());
  // ignore: cascade_invocations
  getIt.registerLazySingleton < ListeningNowPageModel > (() => ListeningNowPageModel());
  // ignore: cascade_invocations
  getIt.registerLazySingleton < DiscoveryPageModel > (() => DiscoveryPageModel());

  if (kDebugMode) {
    print(Platform.environment.containsKey('FLUTTER_TEST'));
  }
  if (!isTestingMode) {
    getIt.registerLazySingleton<LoginUtil>(() => LoginUtil());
    // ignore: cascade_invocations
    getIt.registerLazySingleton<http.Client>(() => client);
  } 
  
}
class LoginUtil {
  static final LoginUtil _singleton = LoginUtil._internal();
  // ignore: sort_constructors_first
  factory LoginUtil() {
    return _singleton;
  }
  // ignore: sort_constructors_first
  LoginUtil._internal();
  Future < bool > checkLoginStatus() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final File file = File('$path/$CREDENTIAL_PATH');
      if (!file.existsSync()) {
        return false;
      } else {
        final String appToken = await file.readAsString();
        final UserModel? user = await HttpUtil().getUserModel(app_token: appToken);
        if (user == null) {
          return false;
        }
        if (GetIt.I.isRegistered<UserModelNotifier>() || GetIt.I.isRegistered<CredentialModelNotifier>()) {
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

Future <bool> deleteCredential() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final File file = File('$path/$CREDENTIAL_PATH');
    await file.delete();
    if (GetIt.I.isRegistered<UserModelNotifier>() || GetIt.I.isRegistered<CredentialModelNotifier>()) {
      GetIt.I.unregister<UserModelNotifier>();
      GetIt.I.unregister<CredentialModelNotifier>();
    }
    return true;
  } catch (e) {
    return false;
  }
  
}

  Future < bool > saveCredential(String app_token) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final File file = File('$path/$CREDENTIAL_PATH');
      await file.writeAsString(app_token);
      return true;
    } catch (e) {
      return false;
    }
  }
}