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
  @override
  void initState() {
    super.initState();

    fetch_notification_settings();
  }

  void fetch_notification_settings() async {
    bool mid = await states.fetch_notification_settings();
    if (this.mounted) {
      setState(() {
        notification = mid;
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
                ],
              ),
            )));
  }
}
