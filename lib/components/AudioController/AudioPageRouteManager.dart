import 'package:flutter/cupertino.dart';

class AudioPageRouteManager{

  AudioPageRouteManager();

  late BuildContext _context;

  Future<void> setMainContext(BuildContext mainContext) async {
    _context = mainContext;
  }

  BuildContext getMainContext(){
    return _context;
  }
}