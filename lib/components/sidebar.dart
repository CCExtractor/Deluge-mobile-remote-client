import 'package:deluge_client/auth.dart';
import 'package:deluge_client/components/accounts.dart';
import 'package:deluge_client/components/storage_indicator.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/components/accounts.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

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

  sidebar(
      {Key key,
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
      @required this.dashboard_state})
      : super(key: key);
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
      dashboard_state: dashboard_state);
}

class sidebarState extends State<sidebar> {
  final VoidCallback filter_torrent_all;
  final VoidCallback filter_torrent_completed;
  final VoidCallback filter_torrent_noncompleted;
  final VoidCallback filter_torrent_paused;
  final VoidCallback filter_torrent_seeding;
  final VoidCallback dashboard_state;

  bool all_selected;
  bool completed_selected;
  bool non_comp_selected;
  bool paused_selected;
  bool seeding_selected;
  sidebarState(
      {Key key,
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
      this.dashboard_state});

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
    int mid=await states.state_selected_account();
    if (this.mounted) {
      setState(() {
        selected_account = mid;
      });
    }
  }

  // for managing the state of accounts
  GlobalKey<accountsState> accounts_state = GlobalKey();

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

        ExpansionTile(
          initiallyExpanded: true,
          title: Text("Available Storage", style: theme.sidebar_tile_style),
          leading: Icon(
            Icons.storage_rounded,
            color: theme.base_color,
          ),
          children: [storage_indicator()],
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
          title: Text(
            "All account",
            style: theme.sidebar_expansion_children_tile,
          ),
          onTap: () {
            if (this.mounted) {
              setState(() {
                selected_account = -1;
              });
            }

            update_account_selection(-1);
            dashboard_state();
            accounts_state.currentState.fetch_selected_account();
          },
        ),
        //---
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text("Add new account",
              style: theme.sidebar_expansion_children_tile),
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
              leading: Icon(
                Icons.download_sharp,
                color: all_selected ? Colors.white : Colors.black,
              ),
              tileColor: all_selected ? theme.base_color : Colors.transparent,
              title: Text("All",
                  style: TextStyle(
                      fontSize: theme.children_expension_tile_font_size,
                      fontFamily: theme.font_family,
                      color: all_selected ? Colors.white : Colors.black)),
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
              leading: Icon(
                Icons.download_done_sharp,
                color: completed_selected ? Colors.white : Colors.black,
              ),
              tileColor:
                  completed_selected ? theme.base_color : Colors.transparent,
              title: Text(
                "Completed",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: completed_selected ? Colors.white : Colors.black),
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
              leading: Icon(
                Icons.error_outline,
                color: non_comp_selected ? Colors.white : Colors.black,
              ),
              title: Text(
                "Non-Completed",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: non_comp_selected ? Colors.white : Colors.black),
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
              leading: Icon(
                Icons.pause_circle_outline,
                color: paused_selected ? Colors.white : Colors.black,
              ),
              tileColor:
                  paused_selected ? theme.base_color : Colors.transparent,
              title: Text(
                "Paused",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: paused_selected ? Colors.white : Colors.black),
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
              leading: Icon(
                Icons.cloud_download_outlined,
                color: seeding_selected ? Colors.white : Colors.black,
              ),
              tileColor:
                  seeding_selected ? theme.base_color : Colors.transparent,
              title: Text(
                "Seeding",
                style: TextStyle(
                    fontSize: theme.children_expension_tile_font_size,
                    fontFamily: theme.font_family,
                    color: seeding_selected ? Colors.white : Colors.black),
              ),
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
                style: theme.sidebar_expansion_children_tile,
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings_outlined),
              title: Text(
                "Deluge settings",
                style: theme.sidebar_expansion_children_tile,
              ),
            ),
          ],
        ),
      ],
    )));
  }
}
