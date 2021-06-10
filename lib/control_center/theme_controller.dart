import 'package:flutter/material.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

class theme_controller {
  static Brightness brightness;
  static  bool is_it_dark() {
    return theme_controller.brightness == Brightness.dark;
  }

  static List<Brightness> brt_set = [
    Brightness.light,
    Brightness.dark,
  ];
  //--------------------------------------------------------------------------
  static Future<Brightness> get_set_theme() async{
    int index=await states.get_theme_mode();

    switch (index) {
      case 1:
        return brt_set[0];
      case 2:
        return brt_set[1];
      default:
        return brt_set[0];
    }
  }
}
