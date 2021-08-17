import 'dart:io';

import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/settings/deluge/type/advance.dart';
import 'package:deluge_client/settings/deluge/type/basic.dart';
import 'package:deluge_client/settings/deluge/type/general.dart';
import 'package:deluge_client/settings/deluge/type/sftp_streaming_settings.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class deluge_settings extends StatefulWidget {
  List<Cookie> cookie;
  final Bucket selected_account;
  deluge_settings(
      {Key key, @required this.cookie, @required this.selected_account})
      : super(key: key);

  @override
  _deluge_settingsState createState() =>
      _deluge_settingsState(cookie: cookie, selected_account: selected_account);
}

class _deluge_settingsState extends State<deluge_settings> {
  List<Cookie> cookie;
  final Bucket selected_account;
  _deluge_settingsState(
      {Key key, @required this.cookie, @required this.selected_account});

  @override
  void initState() {
    core_settings_fetcher();
    // TODO: implement initState
    super.initState();
  }

  void core_settings_fetcher() async {
    core_settings.fetch(
        cookie != null
            ? cookie
            : await cookie_substitue(
                selected_account.deluge_url,
                selected_account.deluge_pwrd,
                selected_account.has_deluge_pwrd,
                selected_account.is_reverse_proxied,
                selected_account.username,
                selected_account.password,
                selected_account.via_qr),
        selected_account.deluge_url,
        selected_account.is_reverse_proxied,
        selected_account.username,
        selected_account.password,
        selected_account.via_qr,
        context);
  }

  Future<List<Cookie>> cookie_substitue(
      String url,
      String password,
      String has_deluge_pass,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    cookie = await apis.authentication_to_deluge(url, password, has_deluge_pass,
        is_reverse_proxied, seed_username, seed_pass, qr_auth, context);

    print("it is executed");
    print(cookie);

    return cookie;
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.base_color,
            title: Text("Deluge's Settings", style: theme.app_bar_style),
            elevation: 0.0,
            actions: [
              InkWell(
                child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(right: 3.0, top: 1.0),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                            fontSize: theme.minimal_font_size,
                            fontFamily: theme.font_family,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                onTap: () async {
                  apis.update_config_settings(
                      cookie,
                      selected_account.deluge_url,
                      selected_account.is_reverse_proxied,
                      selected_account.username,
                      selected_account.password,
                      selected_account.via_qr,
                      context);

                  toastMessage("Setting updated");
                },
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  "General",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: theme.font_family),
                ),
                children: <Widget>[
                  general(),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Basic",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: theme.font_family),
                ),
                children: <Widget>[
                  basic(),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Advance",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: theme.font_family),
                ),
                children: <Widget>[
                  advance(),
                ],
              ),
            ],
          )),
        ));
  }
}
