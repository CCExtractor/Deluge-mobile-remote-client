import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:deluge_client/components/bottom_sheet/add_magnet_uri.dart';
import 'package:deluge_client/components/bottom_sheet/qr_magnet_reader.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class add_new extends StatefulWidget {
  final VoidCallback refresh;
  final List<Cookie> cookie;
  //---------------
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  add_new(
      {Key key,
      @required this.cookie,
      @required this.refresh,
      @required this.url,
      @required this.is_reverse_proxied,
      @required this.seed_username,
      @required this.seed_pass,
      @required this.qr_auth})
      : super(key: key);

  @override
  _add_newState createState() => _add_newState(
      cookie: cookie,
      refresh: refresh,
      url: url,
      is_reverse_proxied: is_reverse_proxied,
      seed_username: seed_username,
      seed_pass: seed_pass,
      qr_auth: qr_auth);
}

class _add_newState extends State<add_new> {
  final VoidCallback refresh;
  final List<Cookie> cookie;
  //----------------------------
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;

  _add_newState(
      {this.cookie,
      this.refresh,
      this.url,
      this.is_reverse_proxied,
      this.seed_username,
      this.seed_pass,
      this.qr_auth});

  void add_new_torrent_file() async {
    try {
      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: ['torrent'],
        allowedUtiTypes: ['com.deluge.example.torrent'],
        allowedMimeTypes: ['application/x-bittorrent'],
        // allowedMimeTypes: ['application/x-bittorrent'],
        invalidFileNameSymbols: ['/'],
      );

      List<int> torrent_byte =
          new File(await FlutterDocumentPicker.openDocument(params: params))
              .readAsBytesSync();
      if (torrent_byte.isNotEmpty) {
        String base_64_encoded_file = base64Encode(torrent_byte);
        apis.add_torrent_file(base_64_encoded_file, cookie, url,
            is_reverse_proxied, seed_username, seed_pass, qr_auth,context);
        Future.delayed(Duration(seconds: 1), () {
          refresh();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            top: false,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text("Add new torrent as",
                          style: TextStyle(
                              color: (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                              fontSize: theme.bottom_sheet_heading_font_size,
                              fontFamily: theme.font_family))),
                  Divider(
                    color: theme.base_color,
                    thickness: 4.0,
                    indent: 55.0,
                    endIndent: 55.0,
                  ),
                  ListTile(
                    title: Text(
                      'Add torrent file',
                      style: TextStyle(
                          color: (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                          fontSize: theme.alert_box_font_size,
                          fontFamily: theme.font_family),
                    ),
                    leading:
                        Icon(Icons.folder_rounded, color: theme.base_color),
                    onTap: () {
                      Navigator.of(context).pop();
                      add_new_torrent_file();
                    },
                  ),
                  ListTile(
                      title: Text(
                        'Add magnet link',
                        style: TextStyle(
                            color: (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                            fontSize: theme.alert_box_font_size,
                            fontFamily: theme.font_family),
                      ),
                      leading: Icon(Icons.link_sharp, color: theme.base_color),
                      onTap: () {
                        Navigator.of(context).pop();
                        showModalBottomSheet(
                            isScrollControlled: true,
                            
                            context: context,
                            backgroundColor: Colors.transparent,
                          
                            builder: (context) => add_magnet(
                                  cookie: cookie,
                                  url: url,
                                  is_reverse_proxied: is_reverse_proxied,
                                  seed_username: seed_username,
                                  seed_pass: seed_pass,
                                  qr_auth: qr_auth,
                                  refresh: () => refresh(),
                                ));
                      }),
                  ListTile(
                      title: Text(
                        'Scan magnet QR',
                        style: TextStyle(
                            color: (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                            fontSize: theme.alert_box_font_size,
                            fontFamily: theme.font_family),
                      ),
                      leading: Icon(Icons.qr_code_scanner_outlined,
                          color: theme.base_color),
                      onTap: () {
                        Navigator.of(context).pop();
                        showModalBottomSheet(
                            isScrollControlled: false,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => magnet_qr_reader(
                                  cookie: cookie,
                                  url: url,
                                  is_reverse_proxied: is_reverse_proxied,
                                  seed_username: seed_username,
                                  seed_pass: seed_pass,
                                  qr_auth: qr_auth,
                                  refresh: () => refresh(),
                                ));
                      }),
                ],
              ),
            )));
  }
}
