import 'dart:async';

import 'package:deluge_client/components/loader.dart';
import 'package:deluge_client/components/storage_indicator.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  prompt_to_delete(BuildContext context, int id, String account) {
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
        //some code
        dbmanager.deletebucket(id);
        Navigator.of(context, rootNavigator: true)
            .pop(); // for shutting the alertbox
        Navigator.of(context).pop(); //for closing sidebar
        toastMessage(account + " deleted successfully");
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
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: theme.base_color,
      title: Text("Pay Attention",
          style: TextStyle(color: Colors.white, fontFamily: theme.font_family)),
      content: Text(
        "Do you wanted to remove " + account,
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

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140.0,
        child: FutureBuilder(
            future: dbmanager.getbucketitem(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: loader()));
              } else {
                List<Bucket> accounts = snapshot.data;

                return ListView.builder(
                    itemCount: accounts == null ? 0 : accounts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(accounts[index].deluge_url,
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: theme.font_family,
                              color: theme_controller.is_it_dark()
                                  ? Colors.white
                                  : Colors.black,
                            )),
                        leading: Icon(selected_account == accounts[index].id
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked),
                        trailing: (accounts.length > 1 &&
                                selected_account != accounts[index].id)
                            ? IconButton(
                                // if there is more than 1 account then it will visible
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 18.0,
                                ),
                                onPressed: () {
                                  prompt_to_delete(context, accounts[index].id,
                                      accounts[index].deluge_url);
                                },
                              )
                            : new Container(height: 0.0, width: 0.0),
                        onTap: () async {
                          if (this.mounted) {
                            setState(() {
                              selected_account = accounts[index].id;

                              update_account_state(selected_account);
                            });
                          }
                          update_account_selection();
                          dashboard_state();
                          //here i will add logic to reset sftp
                          if (await states.get_sftP_reset_bool()) {
                            states.reset_sftp_config();
                          }
                          Navigator.of(context).pop(); //closing side bar
                        },
                      );
                    });
              }
            }));
  }
}
