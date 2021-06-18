import 'dart:io';

import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:flutter/services.dart';

class ssh extends StatefulWidget {
  @override
  _sshState createState() => _sshState();
}

class _sshState extends State<ssh> {
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
                  "Please enter route carefully, it will affect streamer",style: TextStyle(fontFamily: theme.font_family),
                )),
          ],
        ),
      ],
    )));
  }
}
