import 'package:flutter/material.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/settings/deluge/type/sftp_streaming_settings.dart';
import 'package:deluge_client/sftp_streaming/sftp_explorer.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class sftp_settings_fields extends StatefulWidget {
  final Bucket selected_account;
  sftp_settings_fields({Key key, @required this.selected_account})
      : super(key: key);
  @override
  _sftp_settings_fieldsState createState() =>
      _sftp_settings_fieldsState(selected_account: selected_account);
}

class _sftp_settings_fieldsState extends State<sftp_settings_fields> {
  final Bucket selected_account;
  _sftp_settings_fieldsState({@required this.selected_account});

  Future<void> handle_streaming_action() async {
    String sftp_host = await states.get_sftp_host();
    String sftp_port = await states.get_sftp_port();
    String sftp_username = await states.get_sftp_username();
    String sftp_password = await states.get_sftp_password();
    String sftp_route_dir = await states.get_sftp_route();

    if (sftp_host.isEmpty &&
        sftp_port.isEmpty &&
        sftp_username.isEmpty &&
        sftp_password.isEmpty &&
        sftp_route_dir.isEmpty) {
      //-----------------
      core_settings.sftp_host.text = selected_account.deluge_url.replaceFirst("https://", "");
      core_settings.sftpport.text = "54022";

      core_settings.sftp_route_url.text =
        selected_account.deluge_url + "/downloads/";
    }
  }

  @override
  void initState() {
    handle_streaming_action();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
            child: Column(
      children: [
        ListTile(
            title: Text(
              "Host",
              style: theme.sidebar_tile_style,
            ),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: theme.alert_box_font_size,
                      fontFamily: theme.font_family),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: " Host ",
                    fillColor: Colors.white70,
                    suffixIcon: InkWell(
                      child: Icon(Icons.paste),
                      onTap: () async {
                        ClipboardData data =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        core_settings.sftp_host.text = data.text;
                      },
                    ),
                  ),
                  controller: core_settings.sftp_host,
                  autofocus: false,
                ))),
        //==
        ListTile(
            title: Text(
              "Port",
              style: theme.sidebar_tile_style,
            ),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: theme.alert_box_font_size,
                      fontFamily: theme.font_family),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: " Port ",
                    fillColor: Colors.white70,
                    suffixIcon: InkWell(
                      child: Icon(Icons.paste),
                      onTap: () async {
                        ClipboardData data =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        core_settings.sftpport.text = data.text;
                      },
                    ),
                  ),
                  controller: core_settings.sftpport,
                  autofocus: false,
                ))),
        ListTile(
            title: Text(
              "SFTP Username",
              style: theme.sidebar_tile_style,
            ),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: theme.alert_box_font_size,
                      fontFamily: theme.font_family),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "sftp Username",
                    fillColor: Colors.white70,
                    suffixIcon: InkWell(
                      child: Icon(Icons.paste),
                      onTap: () async {
                        ClipboardData data =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        core_settings.sftp_username.text = data.text;
                      },
                    ),
                  ),
                  controller: core_settings.sftp_username,
                  autofocus: false,
                ))),
        ListTile(
            title: Text(
              "SFTP Password",
              style: theme.sidebar_tile_style,
            ),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: theme.alert_box_font_size,
                      fontFamily: theme.font_family),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "sftp Password",
                    fillColor: Colors.white70,
                    
                    suffixIcon: InkWell(
                      child: Icon(Icons.paste),
                      onTap: () async {
                        ClipboardData data =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        core_settings.sftp_pass.text = data.text;
                      },
                    ),
                  ),
                   obscureText:true,
                  controller: core_settings.sftp_pass,
                  autofocus: false,
                ))),

        ListTile(
            title: Text(
              "Directory Route URL",
              style: theme.sidebar_tile_style,
            ),
            subtitle: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: theme.alert_box_font_size,
                      fontFamily: theme.font_family),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Directory Route URL",
                    suffixIcon: InkWell(
                      child: Icon(Icons.paste),
                      onTap: () async {
                        ClipboardData data =
                            await Clipboard.getData(Clipboard.kTextPlain);
                        core_settings.sftp_route_url.text = data.text;
                      },
                    ),
                    fillColor: Colors.white70,
                  ),
                  controller: core_settings.sftp_route_url,
                  autofocus: false,
                ))),
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.error_outline,
                )),
            Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: Text(
                  "Please enter route carefully, it will affect streamer",
                  style: TextStyle(fontFamily: theme.font_family),
                )),
          ],
        ),
      ],
    )));
  }
}
