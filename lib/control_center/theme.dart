import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class theme {
  static String thread_title = "Deluge Mobile client";
  static Color material_color = Colors.red;
  static Color base_color = Color.fromRGBO(241, 94, 90, 1.0);
  static String font_family = "SFUIDisplay";
  static double heading_font_size = 20.0;
  static double minimal_font_size = 15.0;
  static double alert_box_font_size = 18.0;
  static double bottom_sheet_heading_font_size = 21.0;
  static TextStyle logo_text_style = TextStyle(
      fontFamily: font_family,
      fontSize: heading_font_size,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  static TextStyle sidebar_tile_style =
      TextStyle(fontFamily: font_family, fontSize: 15.0, color: base_color);
  
  static double children_expension_tile_font_size = 12.0;
  static TextStyle app_bar_style = TextStyle(
      fontSize: 20.0, fontFamily: theme.font_family, color: Colors.white);
  static TextStyle warning_style = TextStyle(
      fontFamily: theme.font_family, fontSize: 15.0, color: Colors.white);
  
}
