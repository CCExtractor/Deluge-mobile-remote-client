import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';

class loader extends StatefulWidget {
  @override
  _loaderState createState() => _loaderState();
}

class _loaderState extends State<loader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        width: 100,
        child: Center(
            child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(theme.base_color),
        )));
  }
}
