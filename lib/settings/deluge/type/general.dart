import 'dart:io';

import 'package:deluge_client/database/dbmanager.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:deluge_client/api/apis.dart';

class general extends StatefulWidget {
  @override
  _generalState createState() => _generalState();
}

class _generalState extends State<general> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                  title: Text(
                    "Download Directory",
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
                          hintText: " Download Directory",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.download_Directory,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Torrent files directory",
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
                          hintText: " Torrent files directory ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.torrent_file_Directory,
                        autofocus: false,
                      ))),

              ListTile(
                  title: Text(
                    "Move after completion path",
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
                          hintText: " Move after completion path",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.move_after_completion_path,
                        autofocus: false,
                      ))),
              //---------------------------------------------------
              ListTile(
                  title: Text(
                    "Max connections global",
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
                          hintText: " Max connections global",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_connection_global,
                        autofocus: false,
                      ))),
              //-------------------------------------------------------------
              ListTile(
                  title: Text(
                    "Max Upload speed",
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
                          hintText: " Max Upload speed",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_upload_speed,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Max Download Speed",
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
                          hintText: " Max Download Speed",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_download_speed,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Max Upload Slots Global",
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
                          hintText: " Max Upload Slots Global",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_upload_slots,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Max half open connection",
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
                          hintText: " Max half open connection",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_half_open_connection,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Max connection per second",
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
                          hintText: " Max connection per second",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_connection_per_second,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Max connection per torrent",
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
                          hintText: " Max connection per torrent",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_connection_per_torrent,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text("Max upload slots per torrent",
                      style: theme.sidebar_tile_style),
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
                          hintText: " Max upload slots per torrent",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.max_uploads_slots_per_torrent,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Max download speed per torrent",
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
                          hintText: " Max Download slots per torrent",
                          fillColor: Colors.white70,
                        ),
                        controller:
                            core_settings.max_download_speed_per_torrent,
                        autofocus: false,
                      ))),
            ],
          ),
        ));
  }
}
