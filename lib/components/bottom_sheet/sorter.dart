import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:deluge_client/components/bottom_sheet/add_magnet_uri.dart';
import 'package:deluge_client/components/bottom_sheet/qr_magnet_reader.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/string/sorter.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class sorter extends StatefulWidget {
  final VoidCallback rebuilt_list;
  sorter({Key key, this.rebuilt_list}) : super(key: key);
  @override
  _sorterState createState() => _sorterState(
        rebuilt_list: rebuilt_list,
      );
}

class _sorterState extends State<sorter> {
  final VoidCallback rebuilt_list;
  _sorterState({Key key, this.rebuilt_list});
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
                      child: Text("Sort as",
                          style: TextStyle(
                              color: !theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white,
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
                      'Sort by non-reverse order',
                      style: TextStyle(
                          color: sort_helper.non_reverse_order
                              ? theme.base_color
                              : (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                          fontSize: theme.alert_box_font_size,
                          fontFamily: theme.font_family),
                    ),
                    leading: Icon(Icons.arrow_upward,
                        color: sort_helper.non_reverse_order
                            ? theme.base_color
                            :  (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white)),
                    onTap: () {
                      if (this.mounted) {
                        setState(() {
                          sort_helper.reverse_order = false;
                          sort_helper.non_reverse_order = true;
                          sort_helper.by_size_order = false;
                          sort_helper.by_date_time = false;
                        });
                      }
                      rebuilt_list();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                      title: Text(
                        'Sort by reverse order',
                        style: TextStyle(
                            color: sort_helper.reverse_order
                                ? theme.base_color
                                : (!theme_controller.is_it_dark()
                                    ? Colors.black
                                    : Colors.white),
                            fontSize: theme.alert_box_font_size,
                            fontFamily: theme.font_family),
                      ),
                      leading: Icon(
                        Icons.arrow_downward_rounded,
                        color: sort_helper.reverse_order
                            ? theme.base_color
                            :  (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                      ),
                      onTap: () {
                        if (this.mounted) {
                          setState(() {
                            sort_helper.reverse_order = true;
                            sort_helper.non_reverse_order = false;
                            sort_helper.by_size_order = false;
                            sort_helper.by_date_time = false;
                          });
                        }
                        rebuilt_list();

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                      title: Text(
                        'Sort by size',
                        style: TextStyle(
                            color: sort_helper.by_size_order
                                ? theme.base_color
                                : (!theme_controller.is_it_dark()
                                    ? Colors.black
                                    : Colors.white),
                            fontSize: theme.alert_box_font_size,
                            fontFamily: theme.font_family),
                      ),
                      leading: Icon(
                        Icons.sd_storage_outlined,
                        color: sort_helper.by_size_order
                            ? theme.base_color
                            : (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                      ),
                      onTap: () {
                        if (this.mounted) {
                          setState(() {
                            sort_helper.reverse_order = false;
                            sort_helper.non_reverse_order = false;
                            sort_helper.by_size_order = true;
                            sort_helper.by_date_time = false;
                          });
                        }
                        rebuilt_list();

                        Navigator.of(context).pop();
                      }),
                       ListTile(
                      title: Text(
                        'Sort by date and time added',
                        style: TextStyle(
                            color: sort_helper.by_date_time
                                ? theme.base_color
                                : (!theme_controller.is_it_dark()
                                    ? Colors.black
                                    : Colors.white),
                            fontSize: theme.alert_box_font_size,
                            fontFamily: theme.font_family),
                      ),
                      leading: Icon(
                        Icons.watch,
                        color: sort_helper.by_date_time
                            ? theme.base_color
                            : (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                      ),
                      onTap: () {
                        if (this.mounted) {
                          setState(() {
                            sort_helper.reverse_order = false;
                            sort_helper.non_reverse_order = false;
                            sort_helper.by_size_order = false;
                            sort_helper.by_date_time = true;
                          });
                        }
                        rebuilt_list();

                        Navigator.of(context).pop();
                      }),
                ],
              ),
            )));
  }
}
