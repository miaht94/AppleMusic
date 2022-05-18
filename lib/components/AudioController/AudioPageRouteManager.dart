import 'package:flutter/cupertino.dart';

class AudioPageRouteManager{

  AudioPageRouteManager();

  late BuildContext _context;
  BuildContext? underBottomAppBarContext;
  Future<void> setMainContext(BuildContext mainContext) async {
    _context = mainContext;
  }

  BuildContext getMainContext(){
    return _context;
  }

  // ignore: use_setters_to_change_properties
  Future<void> setSecondaryContext(BuildContext context) async {
    underBottomAppBarContext = context;
  }

  BuildContext? getSecondaryContext(){
    return underBottomAppBarContext;
  }
}