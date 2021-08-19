import 'dart:collection';
import 'dart:convert';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/components/error_on_dash.dart';
import 'package:deluge_client/core/all_acc.dart';
import 'package:deluge_client/core/all_acc.dart';
import 'package:deluge_client/components/bottom_sheet/choose_account.dart';
import 'package:deluge_client/components/bottom_sheet/sorter.dart';
import 'package:deluge_client/components/download_upload_pane.dart';
import 'package:deluge_client/components/loader.dart';
import 'package:deluge_client/components/no_data.dart';
import 'package:deluge_client/components/progress_bar.dart';
import 'package:deluge_client/components/tile.dart';
import 'package:deluge_client/control_center/theme_changer.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/screens/multi_dash.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:deluge_client/components/bottom_sheet/add_torrent.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/components/sidebar.dart';
import 'dart:io';
import 'package:deluge_client/string/controller.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/string/sorter.dart';
import 'package:deluge_client/notification/notification_controller.dart';
import 'package:deluge_client/control_center/theme_controller.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  Future<Map<String, Properties>> torrent;
  List<Cookie> cookie = null;
  //----
  bool all_torrent = true;
  bool noncompleted = false;
  bool completed_torrent = false;
  bool torren_seeding = false;
  bool paused_torrent = false;
  List<String> selected_torrents = new List();
  double speed = 0.0;
  GlobalKey<multi_accountState> multidash = GlobalKey();

  //------------------------------------------------------------
  DbbucketManager account_manager = DbbucketManager();
  Bucket selx_acc;
  bool all_account_selected = false;
  List<multtorrent> multi_selected_torrents = new List();
  void dashboard_state() async {
    int t = await states.state_selected_account();

    if (t > 0) {
      selx_acc = await account_manager.get_acc_by_id(t);

      authentication_to_deluge(
          selx_acc.deluge_url,
          selx_acc.deluge_pwrd,
          selx_acc.has_deluge_pwrd,
          selx_acc.is_reverse_proxied,
          selx_acc.username,
          selx_acc.password,
          selx_acc.via_qr);

      Future.delayed(Duration(seconds: 2), () {
        torrent_list(selx_acc.deluge_url, cookie, selx_acc.is_reverse_proxied,
            selx_acc.username, selx_acc.password, selx_acc.via_qr);
      });
      if (this.mounted) {
        setState(() {
          all_account_selected = false;
          head = selx_acc.deluge_url;
        });
      }
    } else {
      if (this.mounted) {
        setState(() {
          all_account_selected = true;
        });
      }
    }
  }

  //--------------
  //--------------------------------------------------------------------

  void authentication_to_deluge(
      String url,
      String password,
      String has_deluge_pass,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    cookie = await apis.authentication_to_deluge(url, password, has_deluge_pass,
        is_reverse_proxied, seed_username, seed_pass, qr_auth, context);
  }

  @override
  void initState() {
    dashboard_state();
    notification.init();

    super.initState();
  }

  void torrent_list(String url, List<Cookie> cookie, String is_reverse_proxied,
      String seed_username, String seed_pass, String qr_auth) {
    // --it was for delaying function
    Future.delayed(const Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          torrent = apis.get_torrent_list(cookie, url, is_reverse_proxied,
              seed_username, seed_pass, qr_auth, context);

          // setting state for ui changes realtime
        });
      }
    });
    //------------------------------------->>
    // it will keep checking and checking the status
    // Timer.periodic(Duration(seconds: 2), (timer) {
    //   setState(() {
    //     torrent = get_torrent_list();
    //   });
    // });

    /*
    refresh torr.. function first get the list of torrent at initial phase and it
    will keep getting latest torrent status inorder to get to know about the realtime changes
    such as downloading status
    */
  }

  void non_delayed_torrent_fetch(
      String url,
      String pass,
      List<Cookie> cookie,
      String has_deluge_pass,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) {
    // cause we have already a valid cookie so we will not wait for cookie
    var curr_time_utc = DateTime.now().toUtc();
    if (cookie[0].expires.isBefore(curr_time_utc) ||
        cookie[0].expires.isAtSameMomentAs(curr_time_utc)) {
      authentication_to_deluge(url, pass, has_deluge_pass, is_reverse_proxied,
          seed_username, seed_pass, qr_auth);
      torrent_list(
          url, cookie, is_reverse_proxied, seed_username, seed_pass, qr_auth);
    } else {
      Future.delayed(Duration(seconds: 1), () {
        if (this.mounted) {
          setState(() {
            torrent = apis.get_torrent_list(cookie, url, is_reverse_proxied,
                seed_username, seed_pass, qr_auth, context);

            // setting state for ui changes realtime
          });
        }
      });
    }
  }

  @override
  void dispose() {
    //controller?.dispose();
    super.dispose();
  }

  bool long_press_activity = false;
  bool select_all_activity_trigger = false;
  void insert_selected_torrent(String key) {
    selected_torrents.add(key);

    // print(selected_torrents);
  }

  void pop_out_on_click(String key) {
    selected_torrents.remove(key);
  }

  //----------------------------------------------
  //methods to access in sidebar to filter data
  void filter_torrent_all() {
    if (this.mounted) {
      setState(() {
        all_torrent = true;
        noncompleted = false;
        completed_torrent = false;
        torren_seeding = false;
        paused_torrent = false;
      });
    }
    non_delayed_torrent_fetch(
        selx_acc.deluge_url,
        selx_acc.deluge_pwrd,
        cookie,
        selx_acc.has_deluge_pwrd,
        selx_acc.is_reverse_proxied,
        selx_acc.username,
        selx_acc.password,
        selx_acc.via_qr); // for single account listen changes
    if (all_account_selected) {
      multidash.currentState.multi_filter_torrent_all();
    }
  }

  void filter_torrent_completed() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = false;
        completed_torrent = true;
        torren_seeding = false;
        paused_torrent = false;
      });
    }
    non_delayed_torrent_fetch(
        selx_acc.deluge_url,
        selx_acc.deluge_pwrd,
        cookie,
        selx_acc.has_deluge_pwrd,
        selx_acc.is_reverse_proxied,
        selx_acc.username,
        selx_acc.password,
        selx_acc.via_qr); // for single account listen changes
    if (all_account_selected) {
      multidash.currentState.multi_filter_torrent_completed();
    }
  }

  void filter_torrent_noncompleted() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = true;
        completed_torrent = false;
        torren_seeding = false;
        paused_torrent = false;
      });
    }
    non_delayed_torrent_fetch(
        selx_acc.deluge_url,
        selx_acc.deluge_pwrd,
        cookie,
        selx_acc.has_deluge_pwrd,
        selx_acc.is_reverse_proxied,
        selx_acc.username,
        selx_acc.password,
        selx_acc.via_qr); // for single account listen changes

    if (all_account_selected) {
      multidash.currentState.multi_filter_torrent_noncompleted();
    }
  }

  void filter_torrent_paused() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = false;
        completed_torrent = false;
        torren_seeding = false;
        paused_torrent = true;
      });
    }
    non_delayed_torrent_fetch(
        selx_acc.deluge_url,
        selx_acc.deluge_pwrd,
        cookie,
        selx_acc.has_deluge_pwrd,
        selx_acc.is_reverse_proxied,
        selx_acc.username,
        selx_acc.password,
        selx_acc.via_qr); // for single account listen changes

    if (all_account_selected) {
      multidash.currentState.multi_filter_torrent_paused();
    }
  }

  void filter_torrent_seeding() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = false;
        completed_torrent = false;
        torren_seeding = true;
        paused_torrent = false;
      });
    }
    non_delayed_torrent_fetch(
        selx_acc.deluge_url,
        selx_acc.deluge_pwrd,
        cookie,
        selx_acc.has_deluge_pwrd,
        selx_acc.is_reverse_proxied,
        selx_acc.username,
        selx_acc.password,
        selx_acc.via_qr); // for single account listen changes
    if (all_account_selected) {
      multidash.currentState.multi_filter_torrent_seeding();
    }
  }

  //---------------------------------------------
  //control options
  //resume
  void resume_selected() {
    if (!all_account_selected) {
      for (String key in selected_torrents) {
        /// resume_activity(key);
        //------------------------

        apis.resume_activity(
            key,
            cookie,
            selx_acc.deluge_url,
            selx_acc.is_reverse_proxied,
            selx_acc.username,
            selx_acc.password,
            selx_acc.via_qr,
            context);
      }
      non_delayed_torrent_fetch(
          selx_acc.deluge_url,
          selx_acc.deluge_pwrd,
          cookie,
          selx_acc.has_deluge_pwrd,
          selx_acc.is_reverse_proxied,
          selx_acc.username,
          selx_acc.password,
          selx_acc.via_qr);
      if (this.mounted) {
        setState(() {
          selected_torrents.clear();
        });
      }
    } else {
      multidash.currentState.resume_selected();
    }
  }

  //------------------pause
  void pause_selected() {
    if (!all_account_selected) {
      for (String key in selected_torrents) {
        // pause_activity(key);
        apis.pause_activity(
            key,
            cookie,
            selx_acc.deluge_url,
            selx_acc.is_reverse_proxied,
            selx_acc.username,
            selx_acc.password,
            selx_acc.via_qr,
            context);
      }
      non_delayed_torrent_fetch(
          selx_acc.deluge_url,
          selx_acc.deluge_pwrd,
          cookie,
          selx_acc.has_deluge_pwrd,
          selx_acc.is_reverse_proxied,
          selx_acc.username,
          selx_acc.password,
          selx_acc.via_qr);
      if (this.mounted) {
        setState(() {
          selected_torrents.clear();
        });
      }
    } else {
      multidash.currentState.pause_selected();
    }
  }

  //----------delete activity
  void delete_torrent(BuildContext context) {
    /** intuition:-
     * first i will prompt user to "are you sure to delete selected torrents"
     * second i will prompt user to "do you also wanted to delete downloaded data"
     * <--
     * implement logics to solve problem
     * -->
     * 
     * **/
    if (!all_account_selected) {
      showAlertDialog_prompt1(context);
    } else {
      multidash.currentState.delete_torrent_multi(context);
    }
  }

  showAlertDialog_prompt1(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(
            color: Colors.blue,
            fontSize: theme.alert_box_font_size,
            fontWeight: FontWeight.bold,
            fontFamily: theme.font_family),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(
            color: Colors.white,
            fontSize: theme.alert_box_font_size,
            fontWeight: FontWeight.bold,
            fontFamily: theme.font_family),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        showAlertDialog_prompt2(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: theme.base_color,
      title: Text("Pay Attention",
          style: TextStyle(color: Colors.white, fontFamily: theme.font_family)),
      content: Text(
        "Are you sure to delete selected torrents",
        style: TextStyle(
            fontSize: theme.alert_box_font_size,
            color: Colors.white,
            fontFamily: theme.font_family),
      ),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //------------
  showAlertDialog_prompt2(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Yes",
        style: TextStyle(
            color: Colors.white,
            fontSize: theme.alert_box_font_size,
            fontWeight: FontWeight.bold,
            fontFamily: theme.font_family),
      ),
      onPressed: () {
        for (String key in selected_torrents) {
          // delete_logic(key, true);
          apis.delete_activity(
              cookie,
              key,
              true,
              selx_acc.deluge_url,
              selx_acc.is_reverse_proxied,
              selx_acc.username,
              selx_acc.password,
              selx_acc.via_qr,
              context);
        }
        non_delayed_torrent_fetch(
            selx_acc.deluge_url,
            selx_acc.deluge_pwrd,
            cookie,
            selx_acc.has_deluge_pwrd,
            selx_acc.is_reverse_proxied,
            selx_acc.username,
            selx_acc.password,
            selx_acc.via_qr);
        if (this.mounted) {
          setState(() {
            selected_torrents.clear();
          });
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "No",
        style: TextStyle(
            color: Colors.blue,
            fontSize: theme.alert_box_font_size,
            fontWeight: FontWeight.bold,
            fontFamily: theme.font_family),
      ),
      onPressed: () {
        for (String key in selected_torrents) {
          apis.delete_activity(
              cookie,
              key,
              false,
              selx_acc.deluge_url,
              selx_acc.is_reverse_proxied,
              selx_acc.username,
              selx_acc.password,
              selx_acc.via_qr,
              context);
        }
        non_delayed_torrent_fetch(
            selx_acc.deluge_url,
            selx_acc.deluge_pwrd,
            cookie,
            selx_acc.has_deluge_pwrd,
            selx_acc.is_reverse_proxied,
            selx_acc.username,
            selx_acc.password,
            selx_acc.via_qr);
        if (this.mounted) {
          setState(() {
            selected_torrents.clear();
          });
        }
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: theme.base_color,
      title: Text("Pay Attention",
          style: TextStyle(color: Colors.white, fontFamily: theme.font_family)),
      content: Text(
        "Are you also wanted to delete downloaded data",
        style: TextStyle(
            fontSize: theme.alert_box_font_size,
            color: Colors.white,
            fontFamily: theme.font_family),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  //------------ for multiple account
  void handle_dock_for_multi(List<multtorrent> accounts) {
    setState(() {
      multi_selected_torrents = accounts;
    });
  }

  //---------
  void rebuild_list() {
    Future<Map<String, Properties>> temp = torrent;
    if (this.mounted) {
      setState(() {
        torrent = temp;
      });
    }
  }

  Map<String, Properties> sort(Map<String, Properties> map) {
    if (sort_helper.non_reverse_order) {
      return map;
    } else if (sort_helper.reverse_order) {
      return sort_helper.sort(map);
    } else if (sort_helper.by_size_order) {
      return sort_helper.sort_by_size(map);
    } else if (sort_helper.by_date_time) {
      return sort_helper.sort_by_date_time(map);
    }
  }

  String head = "";
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(!all_account_selected ? head : "All Accounts",
                style: theme.app_bar_style),
            backgroundColor: theme.base_color,
            actions: [
              IconButton(
                icon: theme_controller.is_it_dark()
                    ? Icon(Icons.brightness_5)
                    : Icon(Icons.brightness_4),
                onPressed: () {
                  ThemeBuilder.of(context).changeTheme();
                  if (theme_controller.is_it_dark()) {
                    states.set_theme_mode(2);
                  } else {
                    states.set_theme_mode(1);
                  }
                },
              ),
            ],
          ),
          drawer: sidebar(
            filter_torrent_all: () {
              filter_torrent_all();
            },
            filter_torrent_completed: () {
              filter_torrent_completed();
            },
            filter_torrent_noncompleted: () {
              filter_torrent_noncompleted();
            },
            filter_torrent_paused: () {
              filter_torrent_paused();
            },
            filter_torrent_seeding: () {
              filter_torrent_seeding();
            },
            dashboard_state: () {
              dashboard_state();
              //  main screen will listen changes from sidebar
            },
            all_torrent: all_torrent,
            completed_torrent: completed_torrent,
            noncompleted: noncompleted,
            paused_torrent: paused_torrent,
            torren_seeding: torren_seeding,
            cookie: cookie,
            selected_account: selx_acc,
          ),
          body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        onChanged: (val) {
                          setState(() {
                            controller.search_field_controller.text;
                          });
                        },
                        style: TextStyle(
                            fontFamily: theme.font_family, color: Colors.black),
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: theme.base_color, width: 2.0),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[500], width: 2.0),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(
                              color: Colors.grey[800],
                              fontFamily: theme.font_family),
                          hintText: "Search torrent by name",
                          prefixIcon: Icon(
                            Icons.search,
                            color: theme.base_color,
                          ),
                          fillColor: Colors.white70,
                        ),
                        controller: controller.search_field_controller,
                      )),
                      Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            child: Container(
                              height: 60.0,
                              width: 80.0,
                              child: Icon(
                                Icons.sort_outlined,
                                color: Colors.white,
                                size: 40.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  color: theme.base_color),
                            ),
                            onTap: () async {
                              // sort(await torrent);
                              showCupertinoModalBottomSheet(
                                  expand: false,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => sorter(
                                        rebuilt_list: () {
                                          if (!all_account_selected) {
                                            non_delayed_torrent_fetch(
                                                selx_acc.deluge_url,
                                                selx_acc.deluge_pwrd,
                                                cookie,
                                                selx_acc.has_deluge_pwrd,
                                                selx_acc.is_reverse_proxied,
                                                selx_acc.username,
                                                selx_acc.password,
                                                selx_acc.via_qr);
                                          } else {
                                            multidash.currentState.config();
                                          }
                                        },
                                      ));
                            },
                          )),
                    ],
                  )),
              //--
              !all_account_selected
                  ? FutureBuilder<Map<String, Properties>>(
                      future: torrent,
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, Properties>> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          //------------
                          return Center(child: loader());
                        } else if (snapshot.data==null) {
                          
                          

                          return error(
                            retry: () {
                              non_delayed_torrent_fetch(
                                  selx_acc.deluge_url,
                                  selx_acc.deluge_pwrd,
                                  cookie,
                                  selx_acc.has_deluge_pwrd,
                                  selx_acc.is_reverse_proxied,
                                  selx_acc.username,
                                  selx_acc.password,
                                  selx_acc.via_qr);
                            },
                            account_name: selx_acc.deluge_url,
                          );
                        } else {
                          return Expanded(
                              child: RefreshIndicator(
                                  onRefresh: () async {
                                    non_delayed_torrent_fetch(
                                        selx_acc.deluge_url,
                                        selx_acc.deluge_pwrd,
                                        cookie,
                                        selx_acc.has_deluge_pwrd,
                                        selx_acc.is_reverse_proxied,
                                        selx_acc.username,
                                        selx_acc.password,
                                        selx_acc.via_qr);
                                  },
                                  child: snapshot.data.length > 0
                                      ? ListView.builder(
                                          // where snapshot data means here is torrent=snapshot.data

                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            Map<String, Properties>
                                                res_torrent = new Map();

                                            res_torrent = sort(snapshot.data);

                                            // it is the key that is basically idententity of list
                                            String key = res_torrent.keys
                                                .elementAt(index);

                                            //inside the result array
                                            Properties inside_res =
                                                res_torrent[key];

                                            bool paused = inside_res.paused;
                                            bool completed =
                                                inside_res.isFinished;
                                            bool seeding = inside_res.isSeed;

                                            bool query;
                                            if (completed_torrent) {
                                              query = completed;
                                            } else if (all_torrent) {
                                              query = (!completed || completed);
                                            } else if (noncompleted) {
                                              query = !completed;
                                            } else if (torren_seeding) {
                                              // if torrent is not paused and seeding then it list tiles in futurebuilder
                                              // becuase in json seeding will true if torrent is paused once it get completed
                                              query = seeding && !paused;
                                            } else if (paused_torrent) {
                                              query = paused;
                                            }
                                            if (select_all_activity_trigger) {
                                              insert_selected_torrent(key);
                                            }

                                            // we will be returning row and col

                                            return (query)
                                                ? inside_res.name
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(controller
                                                            .search_field_controller
                                                            .text
                                                            .toLowerCase())
                                                    ? InkWell(
                                                        onTap: () {
                                                          if (long_press_activity &&
                                                              selected_torrents
                                                                  .isNotEmpty) {
                                                            if (!selected_torrents
                                                                .contains(
                                                                    key)) {
                                                              if (this
                                                                  .mounted) {
                                                                setState(() {
                                                                  insert_selected_torrent(
                                                                      key);
                                                                });
                                                              }
                                                            } else {
                                                              if (this
                                                                  .mounted) {
                                                                setState(() {
                                                                  pop_out_on_click(
                                                                      key);
                                                                });
                                                              }
                                                            } //else brace

                                                            if (select_all_activity_trigger) {
                                                              setState(() {
                                                                select_all_activity_trigger =
                                                                    false;
                                                                non_delayed_torrent_fetch(
                                                                    selx_acc
                                                                        .deluge_url,
                                                                    selx_acc
                                                                        .deluge_pwrd,
                                                                    cookie,
                                                                    selx_acc
                                                                        .has_deluge_pwrd,
                                                                    selx_acc
                                                                        .is_reverse_proxied,
                                                                    selx_acc
                                                                        .username,
                                                                    selx_acc
                                                                        .password,
                                                                    selx_acc
                                                                        .via_qr);
                                                                pop_out_on_click(
                                                                    key);
                                                              });
                                                            }
                                                          }
                                                          //--------implement the ontap
                                                          //------------for text editor
                                                          FocusScopeNode
                                                              currentFocus =
                                                              FocusScope.of(
                                                                  context);

                                                          if (!currentFocus
                                                              .hasPrimaryFocus) {
                                                            currentFocus
                                                                .unfocus();
                                                          }
                                                          //------------------------>
                                                        },
                                                        onLongPress: () {
                                                          if (this.mounted) {
                                                            setState(() {
                                                              long_press_activity =
                                                                  true;
                                                            });
                                                          }
                                                          if (!selected_torrents
                                                              .contains(key)) {
                                                            if (this.mounted) {
                                                              setState(() {
                                                                insert_selected_torrent(
                                                                    key);
                                                              });
                                                            }
                                                          }
                                                        },
                                                        child:
                                                            //-----------

                                                            //---------------
                                                            tile(
                                                          paused: paused,
                                                          completed: completed,
                                                          cookie: cookie,
                                                          for_multi: false,
                                                          hash: key,
                                                          inside_res:
                                                              inside_res,
                                                          selected_torrents:
                                                              selected_torrents,
                                                          seeding: seeding,
                                                          selx_acc: selx_acc,
                                                          non_delayed_fetch:
                                                              () {
                                                            non_delayed_torrent_fetch(
                                                                selx_acc
                                                                    .deluge_url,
                                                                selx_acc
                                                                    .deluge_pwrd,
                                                                cookie,
                                                                selx_acc
                                                                    .has_deluge_pwrd,
                                                                selx_acc
                                                                    .is_reverse_proxied,
                                                                selx_acc
                                                                    .username,
                                                                selx_acc
                                                                    .password,
                                                                selx_acc
                                                                    .via_qr);
                                                          },
                                                        ),
                                                      )
                                                    : new Container()
                                                : new Container();
                                          })
                                      : no_data()));
                          //p---
                        }
                        //---

                        //----
                      })
                  : multi_account(
                      manage_multi: (List<multtorrent> val) {
                        handle_dock_for_multi(val);
                      },
                      key: multidash,
                    )

              //---
            ],
          ),
          //-----------------------------------
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            // isExtended: true,
            child: Icon(Icons.add),
            backgroundColor: theme.base_color,
            onPressed: () {
              if (!all_account_selected) {
                //-----------------------------------
                showCupertinoModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => add_new(
                          cookie: cookie,
                          url: selx_acc.deluge_url,
                          is_reverse_proxied: selx_acc.is_reverse_proxied,
                          seed_username: selx_acc.username,
                          seed_pass: selx_acc.password,
                          qr_auth: selx_acc.via_qr,
                          refresh: () => non_delayed_torrent_fetch(
                              selx_acc.deluge_url,
                              selx_acc.deluge_pwrd,
                              cookie,
                              selx_acc.has_deluge_pwrd,
                              selx_acc.is_reverse_proxied,
                              selx_acc.username,
                              selx_acc.password,
                              selx_acc.via_qr),
                        ));
              } else {
                showCupertinoModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => multi_account_menu(
                          cookie_all_account:
                              multidash.currentState.cookie_all_account,
                          refresh: () {
                            multidash.currentState.config();
                          },
                          widget_id: 1,
                        ));
              }

              //----------------------------------
            },
          ),
          //---
          bottomNavigationBar: selected_torrents.length > 0 ||
                  multi_selected_torrents.length > 0
              ? new BottomAppBar(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          fit: FlexFit.tight,
                          child: IconButton(
                              tooltip: "start all",
                              icon: Icon(Icons.play_arrow_rounded),
                              color: theme.base_color,
                              iconSize: 30.0,
                              onPressed: () {
                                resume_selected();

                                //todo error message
                              })),
                      Flexible(
                          fit: FlexFit.tight,
                          child: IconButton(
                              icon: Icon(Icons.pause_outlined),
                              tooltip: "Pause all",
                              color: theme.base_color,
                              iconSize: 30.0,
                              onPressed: () {
                                pause_selected();

                                //todo i have to add one message in snackbar
                              })),
                      Flexible(
                          fit: FlexFit.tight,
                          child: IconButton(
                              icon: Icon(Icons.delete_forever_sharp),
                              tooltip: "Delete Selected",
                              color: theme.base_color,
                              iconSize: 30.0,
                              onPressed: () {
                                print("k");

                                delete_torrent(context);
                                //todo error message
                              })),

                      Flexible(
                          fit: FlexFit.tight,
                          child: selected_torrents.isNotEmpty
                              ? IconButton(
                                  icon: !select_all_activity_trigger
                                      ? Icon(Icons.select_all)
                                      : Icon(Icons.remove_done),
                                  tooltip: !select_all_activity_trigger
                                      ? "select all"
                                      : "remove selection",
                                  color: theme.base_color,
                                  iconSize: 30.0,
                                  onPressed: () {
                                    if (selected_torrents.isNotEmpty &&
                                        !select_all_activity_trigger) {
                                      // it will work when any torrent is selected

                                      select_all_activity_trigger = true;

                                      rebuild_list();
                                    } else if (select_all_activity_trigger) {
                                      if (this.mounted) {
                                        setState(() {
                                          selected_torrents.clear();
                                          select_all_activity_trigger = false;
                                        });
                                      }
                                    }
                                  },
                                )
                              : new Container(
                                  height: 0.0,
                                  width: 0.0,
                                )),

                      //--
                    ],
                  ),
                )
              : Container(
                  height: 0.0,
                  width: 0.0,
                ),
          //-----------------------------------
        ));
  }
}
