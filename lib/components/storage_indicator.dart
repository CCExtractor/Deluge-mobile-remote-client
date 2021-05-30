import 'dart:async';
import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:deluge_client/control_center/theme.dart';

class storage_indicator extends StatefulWidget {
 
  @override
  _storage_indicatorState createState() =>
      _storage_indicatorState();
}

class _storage_indicatorState extends State<storage_indicator> {
 
  
  @override
  Widget build(BuildContext context) {
    return Row(children: [
    Flexible(
      fit: FlexFit.tight,
      child: 
       Container(
     
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
       // width:MediaQuery.of(context).orientation==Orientation.landscape?MediaQuery.of(context).size.width - 465.0:MediaQuery.of(context).size.width - 120.0,
        animation: false,
        lineHeight: 15.0,
        animationDuration: 2000,
        percent: 0.1,
        center: Text(
          "80 % available",
          style: theme.sidebar_expansion_children_tile,
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: theme.base_color,
      ),
    ))],);
  }
}

//----------------------------------------------------
