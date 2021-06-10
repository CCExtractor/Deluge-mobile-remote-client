import 'dart:async';

import 'package:deluge_client/components/loader.dart';
import 'package:deluge_client/components/storage_indicator.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class accounts extends StatefulWidget {
  final VoidCallback update_account_selection;
  final VoidCallback dashboard_state;

  accounts({Key key, this.update_account_selection, this.dashboard_state})
      : super(key: key);
  @override
  accountsState createState() => accountsState(
      key: key,
      update_account_selection: update_account_selection,
      dashboard_state: dashboard_state);
}

class accountsState extends State<accounts> {
  final VoidCallback update_account_selection;
  final VoidCallback dashboard_state;

  accountsState({Key key, this.update_account_selection, this.dashboard_state});

  final DbbucketManager dbmanager = new DbbucketManager();

  int selected_account;

  void update_account_state(int id) async {
    states.update_account_state(id);
  }

  void fetch_selected_account() async {
    int mid = await states.state_selected_account();
    if (this.mounted) {
      setState(() {
        selected_account = mid;
      });
    }
  }

  void initState() {
    fetch_selected_account();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140.0,
        child: FutureBuilder(
            future: dbmanager.getbucketitem(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                    child: Center(child: loader()));
              } else {
                List<Bucket> accounts = snapshot.data;

                return ListView.builder(
                    itemCount: accounts == null ? 0 : accounts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(accounts[index].deluge_url,
                            style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family, color: theme_controller.is_it_dark()?Colors.white:Colors.black)),
                        leading: Icon(selected_account == accounts[index].id
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked),
                        onTap: () {
                          if (this.mounted) {
                            setState(() {
                              selected_account = accounts[index].id;

                              update_account_state(selected_account);
                            });
                          }
                          update_account_selection();
                          dashboard_state();
                          Navigator.of(context).pop();//closing side bar
                        },
                      );
                    });
              }
            }));
  }
}
