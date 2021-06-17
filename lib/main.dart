import 'dart:io';
import 'package:deluge_client/control_center/theme_changer.dart';
import 'package:deluge_client/control_center/theme_controller.dart';
import 'package:deluge_client/screens/auth.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/screens/dashboard.dart';
import 'package:deluge_client/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

void main() {
  
  runApp(Phoenix(
      child: root()
    ),);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class root extends StatefulWidget {
  @override
  _rootState createState() => _rootState();
}

class _rootState extends State<root> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder (
      
        builder: (context, _brightness) {
          return MaterialApp(
            title: theme.thread_title,
            theme: ThemeData(
                primarySwatch:
                     theme.material_color,
                   
                 brightness: _brightness),
            home: splash(),
          );
        });
  }
}
