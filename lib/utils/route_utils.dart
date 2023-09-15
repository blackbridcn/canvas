import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'global_utils.dart';

class NavigatorUtils {


  static void push(Widget targetPage, {Object? arguments}) {
    //Future<T?> push<T extends Object?>
    Navigator.push(
      GlobalUtils.getGlobalContext(),
      MaterialPageRoute(
          builder: (context) => targetPage,
          settings: RouteSettings(
              name: targetPage.runtimeType.toString(), arguments: arguments)),
    );
  }

  static void pop(){

  }




}
