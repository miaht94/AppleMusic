import 'package:flutter/cupertino.dart';

class AudioPageRouteManager{

  AudioPageRouteManager(){
  }

  late BuildContext _context;

  void setMainContext(BuildContext mainContext){
    _context = mainContext;
  }

  BuildContext getMainContext(){
    return _context;
  }
}