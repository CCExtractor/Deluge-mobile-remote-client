import 'dart:io';

import 'package:deluge_client/components/bottom_sheet/choose_account.dart';
import 'package:deluge_client/components/bottom_sheet/ssh_config.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/screens/about.dart';
import 'package:deluge_client/screens/auth.dart';
import 'package:deluge_client/components/accounts.dart';
import 'package:deluge_client/components/storage_indicator.dart';
import 'package:deluge_client/settings/client/client_setting.dart';
import 'package:deluge_client/settings/deluge/deluge_setting.dart';
import 'package:deluge_client/settings/deluge/type/sftp_streaming_settings.dart';
import 'package:deluge_client/sftp_streaming/sftp_explorer.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/scheduler.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/components/accounts.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/core/all_acc.dart';
import 'package:deluge_client/notification/notification_controller.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class sidebar extends StatefulWidget {
  final VoidCallback filter_torrent_all;
  final VoidCallback filter_torrent_completed;
  final VoidCallback filter_torrent_noncompleted;
  final VoidCallback filter_torrent_paused;
  final VoidCallback filter_torrent_seeding;
  final VoidCallback dashboard_state;
  final bool all_torrent;
  final bool noncompleted;
  final bool completed_torrent;
  final bool torren_seeding;
  final bool paused_torrent;
  final List<Cookie> cookie;
  final Bucket selected_account;

  sidebar({
    Key key,
    @required this.filter_torrent_all,
    @required this.filter_torrent_completed,
    @required this.filter_torrent_noncompleted,
    @required this.filter_torrent_paused,
    @required this.filter_torrent_seeding,
    @required this.all_torrent,
    @required this.noncompleted,
    @required this.completed_torrent,
    @required this.paused_torrent,
    @required this.torren_seeding,
    @required this.dashboard_state,
    @required this.selected_account,
    @required this.cookie,
  }) : super(key: key);
  @override
  sidebarState createState() => sidebarState(
        filter_torrent_all: filter_torrent_all,
        filter_torrent_completed: filter_torrent_completed,
        filter_torrent_noncompleted: filter_torrent_noncompleted,
        filter_torrent_paused: filter_torrent_paused,
        filter_torrent_seeding: filter_torrent_seeding,
        all_selected: all_torrent,
        completed_selected: completed_torrent,
        non_comp_selected: noncompleted,
        paused_selected: paused_torrent,
        seeding_selected: torren_seeding,
        dashboard_state: dashboard_state,
        cookie: cookie,
        selecx: selected_account,
      );
}

class sidebarState extends State<sidebar> {
  final VoidCallback filter_torrent_all;
  final VoidCallback filter_torrent_completed;
  final VoidCallback filter_torrent_noncompleted;
  final VoidCallback filter_torrent_paused;
  final VoidCallback filter_torrent_seeding;
  final VoidCallback dashboard_state;
  final List<Cookie> cookie;
  final Bucket selecx;

  bool all_selected;
  bool completed_selected;
  bool non_comp_selected;
  bool paused_selected;
  bool seeding_selected;

  sidebarState({
    Key key,
    this.filter_torrent_all,
    this.filter_torrent_completed,
    this.filter_torrent_noncompleted,
    this.filter_torrent_paused,
    this.filter_torrent_seeding,
    this.all_selected,
    this.completed_selected,
    this.non_comp_selected,
    this.paused_selected,
    this.seeding_selected,
    this.dashboard_state,
    this.cookie,
    this.selecx,
  });

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // it is for forcefully run initstate
      //--------------------------------------
      fetch_selectx_account();
    });

    super.initState();
  }

  void update_account_selection(int id) async {
    states.update_account_state(id);
  }

  int selected_account = 0;
  void fetch_selectx_account() async {
    int mid = await states.state_selected_account();
    if (this.mounted) {
      setState(() {
        selected_account = mid;
      });
    }
  }

  // for managing the state of accounts
  String sftp_host;
  String sftp_port;
  String sftp_username;
  String sftp_password;
  String sftp_route_dir;

  GlobalKey<accountsState> accounts_state = GlobalKey();
  Future<bool> handle_streaming_action() async {
    sftp_host = await states.get_sftp_host();
    sftp_port = await states.get_sftp_port();
    sftp_username = await states.get_sftp_username();
    sftp_password = await states.get_sftp_password();
    sftp_route_dir = await states.get_sftp_route();
    
    if (sftp_host.isNotEmpty &&
        sftp_port.isNotEmpty &&
        sftp_username.isNotEmpty &&
        sftp_password.isNotEmpty &&
        sftp_route_dir.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
            child: Column(
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: theme.base_color,
            child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 140.0,
                    ),
                    Container(
                      child: Text(" Deluge Mobile Client ",
                          style: theme.logo_text_style),
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          color: Colors.white),
                    )
                  ],
                ))),
        //-----------
        selected_account > 0
            ? ExpansionTile(
                initiallyExpanded: true,
                title:
                    Text("Available Storage", style: theme.sidebar_tile_style),
                leading: Icon(
                  Icons.storage_rounded,
                  color: theme.base_color,
                ),
                children: [
                  storage_indicator(
                    cookie: cookie,
                    context: context,
                  )
                ],
              )
            : new Container(
                height: 0.0,
                width: 0.0,
              ),

        ExpansionTile(
          childrenPadding: EdgeInsets.all(0),
          title: Text(
            "Accounts",
            style: theme.sidebar_tile_style,
          ),
          leading: Icon(
            Icons.people_alt_outlined,
            color: theme.base_color,
          ),
          children: [
            accounts(
              key: accounts_state,
              
              // @todo
              dashboard_state: () => dashboard_state(),
              update_account_selection: () => fetch_selectx_account(),
            )
          ],
        ),
        //----

        ListTile(
          leading: Icon(selected_account == -1
              ? Icons.radio_button_checked
              : Icons.radio_button_unchecked),
          title: Text("All account",
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: theme.font_family,
                  color: theme_controller.is_it_dark()
                      ? Colors.white
                      : Colors.black)),
          onTap: () {
            if (this.mounted) {
              setState(() {
                selected_account = -1;
              });
            }

            Navigator.of(context).pop(); // closing side bar
            update_account_selection(-1);
            dashboard_state();
            accounts_state.currentState.fetch_selected_account();
            //----------------we need to delete all entries of ids for notification
            notification.store_ids.clear();
          },
        ),
        //---
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text("Add new account",
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: theme.font_family,
                  color: theme_controller.is_it_dark()
                      ? Colors.white
                      : Colors.black)),
          onTap: () {
            Navigator.of(context).pop(); //for closing sidebar
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => auth_view(
                          tow_attachment: true,
                        )));
          },
        ),

        //------filters
        ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            "Filters",
            style: theme.sidebar_tile_style,
          ),
          leading: Icon(
            Icons.filter_alt_outlined,
            color: theme.base_color,
          ),
          children: [
            ListTile(
              leading: Icon(Icons.download_sharp,
                  color: all_selected
                      ? (!theme_controller.is_it_dark()
                          ? Colors.white
                          : Colors.black)
                      : (!theme_controller.is_it_dark()
                          ? Colors.black
                          : Colors.white)),
              tileColor: all_selected ? theme.base_color : Colors.transparent,
              title: Text("All",
                  style: TextStyle(
                      fontSize: theme.children_expension_tile_font_size,
                      fontFamily: theme.font_family,
                      color: all_selected
                          ? (!theme_controller.is_it_dark()
                              ? Colors.white
                              : Colors.black)
                          : (!theme_controller.is_it_dark()
                              ? Colors.black
                              : Colors.white))),
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    all_selected = true;
                    completed_selected = false;
                    non_comp_selected = false;
                    paused_selected = false;
                    seeding_selected = false;
                  });
                }
                filter_torrent_all();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.download_done_sharp,
                  color: completed_selected
                      ? (!theme_controller.is_it_dark()
                          ? Colors.white
                          : Colors.black)
                      : (!theme_controller.is_it_dark()
                          ? Colors.black
                          : Colors.white)),
              tileColor:
                  completed_selected ? theme.base_color : Colors.transparent,
              title: Text(
                "Completed",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: completed_selected
                        ? (!theme_controller.is_it_dark()
                            ? Colors.white
                            : Colors.black)
                        : (!theme_controller.is_it_dark()
                            ? Colors.black
                            : Colors.white)),
              ),
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    all_selected = false;
                    completed_selected = true;
                    non_comp_selected = false;
                    paused_selected = false;
                    seeding_selected = false;
                  });
                }
                filter_torrent_completed();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.error_outline,
                  color: non_comp_selected
                      ? (!theme_controller.is_it_dark()
                          ? Colors.white
                          : Colors.black)
                      : (!theme_controller.is_it_dark()
                          ? Colors.black
                          : Colors.white)),
              title: Text(
                "Non-Completed",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: non_comp_selected
                        ? (!theme_controller.is_it_dark()
                            ? Colors.white
                            : Colors.black)
                        : (!theme_controller.is_it_dark()
                            ? Colors.black
                            : Colors.white)),
              ),
              tileColor:
                  non_comp_selected ? theme.base_color : Colors.transparent,
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    all_selected = false;
                    completed_selected = false;
                    non_comp_selected = true;
                    paused_selected = false;
                    seeding_selected = false;
                  });
                }
                filter_torrent_noncompleted();
                // for shutting sidebar/drawer

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.pause_circle_outline,
                  color: paused_selected
                      ? (!theme_controller.is_it_dark()
                          ? Colors.white
                          : Colors.black)
                      : (!theme_controller.is_it_dark()
                          ? Colors.black
                          : Colors.white)),
              tileColor:
                  paused_selected ? theme.base_color : Colors.transparent,
              title: Text(
                "Paused",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: paused_selected
                        ? (!theme_controller.is_it_dark()
                            ? Colors.white
                            : Colors.black)
                        : (!theme_controller.is_it_dark()
                            ? Colors.black
                            : Colors.white)),
              ),
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    all_selected = false;
                    completed_selected = false;
                    non_comp_selected = false;
                    paused_selected = true;
                    seeding_selected = false;
                  });
                }

                filter_torrent_paused();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_download_outlined,
                  color: seeding_selected
                      ? (!theme_controller.is_it_dark()
                          ? Colors.white
                          : Colors.black)
                      : (!theme_controller.is_it_dark()
                          ? Colors.black
                          : Colors.white)),
              tileColor:
                  seeding_selected ? theme.base_color : Colors.transparent,
              title: Text("Seeding",
                  style: TextStyle(
                      fontSize: theme.children_expension_tile_font_size,
                      fontFamily: theme.font_family,
                      color: seeding_selected
                          ? (!theme_controller.is_it_dark()
                              ? Colors.white
                              : Colors.black)
                          : (!theme_controller.is_it_dark()
                              ? Colors.black
                              : Colors.white))),
              onTap: () {
                if (this.mounted) {
                  setState(() {
                    all_selected = false;
                    completed_selected = false;
                    non_comp_selected = false;
                    paused_selected = false;
                    seeding_selected = true;
                  });
                }

                filter_torrent_seeding();
                Navigator.pop(context);
              },
            ),
            //todo filter will add in this
          ],
        ),
        //---------------
        ExpansionTile(
          title: Text(
            "Settings",
            style: theme.sidebar_tile_style,
          ),
          leading: Icon(
            Icons.settings,
            color: theme.base_color,
          ),
          children: [
            ListTile(
              leading: Icon(Icons.app_settings_alt_rounded),
              title: Text(
                "Client settings",
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: theme.font_family,
                    color: theme_controller.is_it_dark()
                        ? Colors.white
                        : Colors.black),
              ),
              onTap: () {
                Navigator.of(context).pop(); //close sidebar
                showCupertinoModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => clt_st());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text(
                "Deluge settings",
                style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: theme.font_family,
                    color: theme_controller.is_it_dark()
                        ? Colors.white
                        : Colors.black),
              ),
              onTap: () {
                if (selected_account > 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => deluge_settings(
                                cookie: cookie,
                                selected_account: selecx,
                              )));
                } else {
                  Navigator.of(context).pop(); //close sidebar
                  showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => multi_account_menu(
                            cookie_all_account:
                                all_account_core.all_account_cookie,
                            widget_id: -1,
                          ));
                }
              },
            ),
          ],
        ),
        selected_account > 0
            ? ExpansionTile(
                title: Text("Streaming & Exploration",
                    style: theme.sidebar_tile_style),
                leading: Icon(
                  Icons.settings_system_daydream_outlined,
                  color: theme.base_color,
                ),
                children: [
                  ListTile(
                    title: Text(
                      "Stream and Explore",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: theme.font_family,
                          color: theme_controller.is_it_dark()
                              ? Colors.white
                              : Colors.black),
                    ),
                    leading: Icon(Icons.close_fullscreen_rounded),
                    onTap: () async {
                      if (await handle_streaming_action()) {
                        // user already configured sftp account
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => files(
                                      direx: "/",
                                      path: sftp_route_dir,
                                      host: sftp_host,
                                      password: sftp_password,
                                      port: sftp_port,
                                      username: sftp_username,
                                      choosen_account: selecx,
                                    )));
                      } else {
                        // we need to prompt that user first configure sftp acc
                        Navigator.of(context).pop();
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => ssh_config(
                          
                                  direx: "/",
                                  selected_account: selecx,
                                ));
                      }
                      // now we can plug our plugin from here very easily
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Sftp settings",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: theme.font_family,
                          color: theme_controller.is_it_dark()
                              ? Colors.white
                              : Colors.black),
                    ),
                    leading: Icon(Icons.settings_applications_sharp),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ssh(selected_account: selecx)));
                    },
                  ),
                ],
              )
            : new Container(
                height: 0.0,
                width: 0.0,
              ),
                // for abount
              ListTile(
                    title: Text(
                      "About",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: theme.font_family,
                          color: theme_controller.is_it_dark()
                              ? Colors.white
                              : Colors.black),
                    ),
                    leading: Icon(Icons.info_outline),
                    onTap: () {
                      
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => about()));
                    },
                  ),
      ],
    )));
  }
}
