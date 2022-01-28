import 'package:flutter/material.dart';

class no_data extends StatefulWidget {
  @override
  _no_dataState createState() => _no_dataState();
}

class _no_dataState extends State<no_data> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/no_data.png',
      ),
    );
  }
}
