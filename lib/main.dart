import 'dart:io';

import 'package:deluge_client/screens/auth.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/screens/dashboard.dart';
import 'package:deluge_client/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(root());
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
    return MaterialApp(
     
     
      title: theme.thread_title,
      theme: ThemeData(primarySwatch: theme.material_color),
      home: splash(),
    );
  }
}

