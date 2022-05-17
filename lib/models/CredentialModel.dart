import 'package:flutter/cupertino.dart';

class CredentialModel {
  CredentialModel(this._appToken);
  String _appToken;
  // ignore: unnecessary_getters_setters
  String get appToken {
    return _appToken;
  }
  set appToken(String appToken) {
    _appToken = appToken;
  }
}

class CredentialModelNotifier extends ValueNotifier<CredentialModel> {
  CredentialModelNotifier(CredentialModel value) : super(value);
  void setAppToken(String appToken) {
    value.appToken = appToken;
    notifyListeners();
  }
}