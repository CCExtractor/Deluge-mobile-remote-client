import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/control_center/theme_controller.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

import '../../state_ware_house/state_ware_house.dart';

class clt_st extends StatefulWidget {
  @override
  _clt_stState createState() => _clt_stState();
}

class _clt_stState extends State<clt_st> {
  bool notification = false;
  bool sftp_reset = false;
  @override
  void initState() {
    super.initState();

    fetch_client_settings();
  }

  void fetch_client_settings() async {
    bool mid1 = await states.fetch_notification_settings();
    if (this.mounted) {
      setState(() {
        notification = mid1;
      });
    }

    bool mid2 = await states.get_sftP_reset_bool();
        if (this.mounted) {
      setState(() {
        sftp_reset = mid2;
      });
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
                      child: Text("Client Settings",
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
                    title: Text("On-going notification "),
                    trailing: Switch(
                      value: notification,
                      onChanged: (val) {
                        setState(() {
                          notification = val;
                        });
                        states.set_notification_settings(val);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("sftp settings reset on account change"),
                    trailing: Switch(
                      value: sftp_reset,
                      onChanged: (val) {
                        setState(() {
                          sftp_reset = val;
                        });
                        states.set_sftP_reset_bool(val);
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
