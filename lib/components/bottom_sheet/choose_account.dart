import 'dart:io';

import 'package:deluge_client/components/bottom_sheet/add_torrent.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/settings/deluge/deluge_setting.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class multi_account_menu extends StatefulWidget {
  final int widget_id;
  final Map<String, dynamic> cookie_all_account;
  final VoidCallback refresh;
  multi_account_menu(
      {Key key, this.cookie_all_account, this.refresh, this.widget_id})
      : super(key: key);
  @override
  _multi_account_menuState createState() => _multi_account_menuState(
      cookie_all_account: cookie_all_account,
      refresh: refresh,
      widget_id: widget_id);
}

class _multi_account_menuState extends State<multi_account_menu> {
  final int widget_id;
  final Map<String, dynamic> cookie_all_account;
  final VoidCallback refresh;

  _multi_account_menuState(
      {this.cookie_all_account, this.refresh, this.widget_id});
  final DbbucketManager dbmanager = new DbbucketManager();
  void switch_to_next(
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) {
    Navigator.of(context).pop();
    showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => add_new(
            cookie: cookie,
            url: url,
            is_reverse_proxied: is_reverse_proxied,
            seed_username: seed_username,
            seed_pass: seed_pass,
            qr_auth: qr_auth,
            refresh: () => refresh()));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            top: false,
            child: Container(
                height: 400.0,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Text("Please Choose Account",
                            style: TextStyle(
                               
                                fontSize: theme.bottom_sheet_heading_font_size,
                                fontFamily: theme.font_family))),
                    Divider(
                      color: theme.base_color,
                      thickness: 4.0,
                      indent: 55.0,
                      endIndent: 55.0,
                    ),
                    Expanded(
                        child: FutureBuilder(
                            future: dbmanager.getbucketitem(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                    child: Center(
                                        child:
                                            Image.asset('assets/loader.gif')));
                              } else {
                                List<Bucket> accounts = snapshot.data;

                                return ListView.builder(
                                    itemCount:
                                        accounts == null ? 0 : accounts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -4),
                                        leading: Icon(
                                          Icons.connect_without_contact_sharp,
                                          color: theme.base_color,
                                        ),
                                        title: Text(accounts[index].deluge_url,
                                            style: TextStyle(
                                              fontFamily: theme.font_family,
                                              fontSize: theme.minimal_font_size,
                                            )),
                                        onTap: () {
                                          if (widget_id == 1) {
                                            if (cookie_all_account != null) {
                                              switch_to_next(
                                                  cookie_all_account[
                                                      accounts[index]
                                                          .deluge_url],
                                                  accounts[index].deluge_url,
                                                  accounts[index]
                                                      .is_reverse_proxied,
                                                  accounts[index].username,
                                                  accounts[index].password,
                                                  accounts[index].via_qr);
                                            }
                                          } else if (widget_id == -1) {
                                            Navigator.of(context).pop();//closing the bottom sheet
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        deluge_settings(
                                                            cookie:
                                                                cookie_all_account[
                                                                    accounts[
                                                                            index]
                                                                        .deluge_url],
                                                            selected_account:
                                                                accounts[
                                                                    index])));
                                          }
                                        },
                                      );
                                    });
                              }
                            })),
                  ],
                ))));
  }
}
