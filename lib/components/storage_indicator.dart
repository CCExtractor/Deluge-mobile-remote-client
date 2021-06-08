import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:filesize/filesize.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

import '../string/controller.dart';
import '../string/controller.dart';
import '../string/controller.dart';

class storage_indicator extends StatefulWidget {
  final List<Cookie> cookie;
  storage_indicator({Key key, @required this.cookie}) : super(key: key);
  @override
  _storage_indicatorState createState() =>
      _storage_indicatorState(cookie: cookie);
}

class _storage_indicatorState extends State<storage_indicator> {
  final List<Cookie> cookie;
  _storage_indicatorState({Key key, @required this.cookie});

  DbbucketManager account_manager = DbbucketManager();
  int selected_account = 0;
  Bucket selx_acc;
  
  void fetch_selectx_account() async {
    int mid = await states.state_selected_account();

    selected_account = mid;
    if (selected_account > 0) {
      selx_acc = await account_manager.get_acc_by_id(selected_account);
    }
  }

  void get_config() async {
    Future.delayed(Duration(seconds: 1), () async {
      Map<String, dynamic> conf = await apis.fetch_config(
          cookie,
          selx_acc.deluge_url,
          selx_acc.is_reverse_proxied,
          selx_acc.username,
          selx_acc.password,
          selx_acc.via_qr);
      if (this.mounted) {
        setState(() {
          controller.path_controller= conf['result']['download_location'];
        });
      }
    });
  }

 
  void get_path_size() async {
    Future.delayed(Duration(seconds: 1), () async {
      int free_space = await apis.fetch_free_space(
          cookie,
          controller.path_controller,
          selx_acc.deluge_url,
          selx_acc.is_reverse_proxied,
          selx_acc.username,
          selx_acc.password,
          selx_acc.via_qr);
      if (this.mounted) {
        setState(() {
          controller.storage_controller = filesize(free_space).toString();
        });
      }
    });
  }

  void initState() {
    fetch_selectx_account();
    get_config();
    get_path_size();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            fit: FlexFit.tight,
            child: Container(
                child: ListTile(
              dense: true,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text(
                controller.path_controller,
                style: theme.sidebar_expansion_children_tile,
              ),
              subtitle: Text(
                controller.storage_controller + " " + "Available ",
                style: theme.sidebar_tile_style,
              ),
              leading: Icon(Icons.sd_storage_sharp),
            )))
      ],
    );
  }
}

//----------------------------------------------------
