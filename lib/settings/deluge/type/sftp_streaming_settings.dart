import 'dart:io';

import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:deluge_client/settings/deluge/type/sftp_setting_field.dart';

class ssh extends StatefulWidget {
  final Bucket selected_account;
  ssh({Key key, @required this.selected_account}) : super(key: key);
  @override
  _sshState createState() => _sshState(selected_account: selected_account);
}

class _sshState extends State<ssh> {
  final Bucket selected_account;
  _sshState({Key key, @required this.selected_account});
  void initiate_setup() async {
    core_settings.sftp_host.text = await states.get_sftp_host();
    core_settings.sftp_pass.text = await states.get_sftp_password();
    core_settings.sftpport.text = await states.get_sftp_port();
    core_settings.sftp_username.text = await states.get_sftp_username();
    core_settings.sftp_route_url.text = await states.get_sftp_route();
  }

  @override
  void initState() {
    super.initState();
    initiate_setup();
  }

  // update sftp and streaming config
  void update_sftp_settings() async {
    states.set_sftp_host(core_settings.sftp_host.text.toString());
    states.set_sftp_pass(core_settings.sftp_pass.text.toString());
    states.set_sftp_port(core_settings.sftpport.text.toString());
    states.set_sftp_route(core_settings.sftp_route_url.text.toString());
    states.set_sftp_username(core_settings.sftp_username.text.toString());
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.base_color,
          title: Text("SFTP settings", style: theme.app_bar_style),
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
                update_sftp_settings();
                toastMessage("Setting updated");
              },
            )
          ],
        ),
        body: sftp_settings_fields(selected_account: selected_account,));
  }
}
