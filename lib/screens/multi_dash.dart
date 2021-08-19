import 'package:deluge_client/components/download_upload_pane.dart';
import 'package:deluge_client/components/error_on_dash.dart';
import 'package:deluge_client/components/loader.dart';
import 'package:deluge_client/components/no_data.dart';
import 'package:deluge_client/components/progress_bar.dart';
import 'package:deluge_client/components/tile.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/core/all_acc.dart';
import 'package:flutter/scheduler.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:deluge_client/string/controller.dart';
import 'package:deluge_client/string/sorter.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

class multi_account extends StatefulWidget {
  final Function(List<multtorrent>) manage_multi;
  multi_account({Key key, @required this.manage_multi}) : super(key: key);
  @override
  multi_accountState createState() =>
      multi_accountState(manage_multi: manage_multi);
}

class multi_accountState extends State<multi_account> {
  final Function(List<multtorrent>) manage_multi;
  bool all_torrent = true;
  bool noncompleted = false;
  bool completed_torrent = false;
  bool torren_seeding = false;
  bool paused_torrent = false;
  List<multtorrent> selected_torrents = new List();
  multi_accountState({Key key, @required this.manage_multi});
  @override
  void initState() {
    config();

    super.initState();
  }

  Map<String, dynamic> cookie_all_account = Map<String, dynamic>();
  Future<Map<multtorrent, Properties>> torrents_all_account;
  void config() async {
    cookie_all_account = await all_account_core.config_cache(context);
    Future.delayed(Duration(seconds: 4), () async {
      setState(() {
        torrents_all_account =
            all_account_core.config_torrent_list(cookie_all_account, context);
      });
    });
  }

  bool long_press_activity = false;
  bool select_all_activity_trigger = false;

  void insert_selected_torrent(multtorrent key) {
    setState(() {
      selected_torrents.add(key);
    });
    manage_multi(selected_torrents);

    // print(selected_torrents);
  }

  void pop_out_on_click(multtorrent key) {
    setState(() {
      selected_torrents.remove(key);
    });
    manage_multi(selected_torrents);
  }

  //---operations
  void resume_selected() {
    for (multtorrent key in selected_torrents) {
      /// resume_activity(key);
      //------------------------

      apis.resume_activity(
          key.hash,
          cookie_all_account[key.need.deluge_url],
          key.need.deluge_url,
          key.need.is_reverse_proxied,
          key.need.username,
          key.need.password,
          key.need.via_qr,
          context);
    }
    config();
    if (this.mounted) {
      setState(() {
        selected_torrents.clear();
        manage_multi(selected_torrents);
      });
    }
  }

  //------------------pause
  void pause_selected() {
    for (multtorrent key in selected_torrents) {
      // pause_activity(key);
      apis.pause_activity(
          key.hash,
          cookie_all_account[key.need.deluge_url],
          key.need.deluge_url,
          key.need.is_reverse_proxied,
          key.need.username,
          key.need.password,
          key.need.via_qr,
          context);
    }
    config();
    if (this.mounted) {
      setState(() {
        selected_torrents.clear();
        manage_multi(selected_torrents);
      });
    }
  }

  //----------delete activity
  void delete_torrent_multi(BuildContext context) {
    /** intuition:-
     * first i will prompt user to "are you sure to delete selected torrents"
     * second i will prompt user to "do you also wanted to delete downloaded data"
     * <--
     * implement logics to solve problem
     * -->
     * 
     * **/

    showAlertDialog_prompt1(context);
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
        for (multtorrent key in selected_torrents) {
          // delete_logic(key, true);
          apis.delete_activity(
              cookie_all_account[key.need.deluge_url],
              key.hash,
              true,
              key.need.deluge_url,
              key.need.is_reverse_proxied,
              key.need.username,
              key.need.password,
              key.need.via_qr,
              context);
        }
        config();
        if (this.mounted) {
          setState(() {
            selected_torrents.clear();
            manage_multi(selected_torrents);
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
        for (multtorrent key in selected_torrents) {
          apis.delete_activity(
              cookie_all_account[key.need.deluge_url],
              key.hash,
              false,
              key.need.deluge_url,
              key.need.is_reverse_proxied,
              key.need.username,
              key.need.password,
              key.need.via_qr,
              context);
        }
        config();
        if (this.mounted) {
          setState(() {
            selected_torrents.clear();
            manage_multi(selected_torrents);
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

  //----------------------------filtering them
  void multi_filter_torrent_all() {
    if (this.mounted) {
      setState(() {
        all_torrent = true;
        noncompleted = false;
        completed_torrent = false;
        torren_seeding = false;
        paused_torrent = false;
      });
    }
    config();
  }

  void multi_filter_torrent_completed() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = false;
        completed_torrent = true;
        torren_seeding = false;
        paused_torrent = false;
      });
    }
    config();
  }

  void multi_filter_torrent_noncompleted() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = true;
        completed_torrent = false;
        torren_seeding = false;
        paused_torrent = false;
      });
    }
    config();
  }

  void multi_filter_torrent_paused() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = false;
        completed_torrent = false;
        torren_seeding = false;
        paused_torrent = true;
      });
    }
    config();
  }

  void multi_filter_torrent_seeding() {
    if (this.mounted) {
      setState(() {
        all_torrent = false;
        noncompleted = false;
        completed_torrent = false;
        torren_seeding = true;
        paused_torrent = false;
      });
    }
    config();
  }

  Map<multtorrent, Properties> sort(Map<multtorrent, Properties> map) {
    if (sort_helper.non_reverse_order) {
      return map;
    } else if (sort_helper.reverse_order) {
      return sort_helper.sort_for_multi(map);
    } else if (sort_helper.by_size_order) {
      return sort_helper.sort_by_size_for_multi(map);
    } else if (sort_helper.by_date_time) {
      return sort_helper.sort_by_date_time_for_multi(map);
    }
  }
  //----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map<multtorrent,Properties>>(
          future: torrents_all_account,
          builder: (BuildContext context,
              AsyncSnapshot<Map<multtorrent, Properties>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              //------------
              return Center(child: loader());
            } else if (snapshot.data==null) {
              return error(
                retry: () {
                  config();
                },
                account_name: all_account_core.error_account,
              );
            } else {
              return Expanded(
                  child: RefreshIndicator(
                      onRefresh: () async {
                        config();
                      },
                      child: snapshot.data.length > 0
                          ? ListView.builder(
                              // where snapshot data means here is torrent=snapshot.data

                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                // it is the key that is basically idententity of list
                                //--------for sorted one
                                Map<multtorrent, Properties> sorted_map =
                                    sort(snapshot.data);
                                multtorrent key =
                                    sorted_map.keys.elementAt(index);
                                Bucket buc = key.need;
                                String hash = key.hash;
                                //inside the result array
                                Properties inside_res = snapshot.data[key];

                                bool paused = inside_res.paused;

                                bool completed = inside_res.isFinished;
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

                                return query
                                    ? inside_res.name
                                            .toString()
                                            .toLowerCase()
                                            .contains(controller
                                                .search_field_controller.text
                                                .toLowerCase())
                                        ? InkWell(
                                            onTap: () {
                                              if (long_press_activity &&
                                                  selected_torrents
                                                      .isNotEmpty) {
                                                if (!selected_torrents
                                                    .contains(key)) {
                                                  if (this.mounted) {
                                                    setState(() {
                                                      insert_selected_torrent(
                                                          key);
                                                    });
                                                  }
                                                } else {
                                                  if (this.mounted) {
                                                    setState(() {
                                                      pop_out_on_click(key);
                                                    });
                                                  }
                                                } //else brace

                                                if (select_all_activity_trigger) {
                                                  setState(() {
                                                    select_all_activity_trigger =
                                                        false;
                                                    config();
                                                    pop_out_on_click(key);
                                                  });
                                                }
                                              }
                                              //--------implement the ontap
                                              //------------for text editor
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);

                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              //------------------------>
                                            },
                                            onLongPress: () {
                                              if (this.mounted) {
                                                setState(() {
                                                  long_press_activity = true;
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
                                                //---------------
                                                tile(
                                              paused: paused,
                                              completed: completed,
                                              cookie: cookie_all_account[
                                                  buc.deluge_url],
                                              for_multi: true,
                                              hash: key.hash,
                                              inside_res: inside_res,
                                              multi_selected_torrent:
                                                  selected_torrents,
                                              seeding: seeding,
                                              selx_acc: buc,
                                              hash_m: key,
                                              non_delayed_fetch: (){
                                                config();
                                              },
                                            ),
                                          )
                                        : Container(
                                            height: 0.0,
                                            width: 0.0,
                                          )
                                    : Container(
                                        height: 0.0,
                                        width: 0.0,
                                      );
                              })
                          : no_data()));
            }
          }),
    );
  }
}
