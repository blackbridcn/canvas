import 'package:flutter/material.dart';

class GlobalUtils {

  static GlobalKey<NavigatorState> navigatorKey =  GlobalKey();

  static BuildContext getGlobalContext(){
    return navigatorKey.currentContext!;
  }

}
