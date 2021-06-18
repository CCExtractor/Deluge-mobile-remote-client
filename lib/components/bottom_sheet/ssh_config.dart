import 'package:deluge_client/settings/deluge/type/sftp_streaming_settings.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:deluge_client/control_center/theme_controller.dart';


class ssh_config extends StatefulWidget {
  @override
  _ssh_configState createState() => _ssh_configState();
}

class _ssh_configState extends State<ssh_config> {
  void update_sftp_settings() async {
    states.set_sftp_host(core_settings.sftp_host.text.toString());
    states.set_sftp_pass(core_settings.sftp_pass.text.toString());
    states.set_sftp_port(core_settings.sftpport.text.toString());
    states.set_sftp_route(core_settings.sftp_route_url.text.toString());
    states.set_sftp_username(core_settings.sftp_username.text.toString());
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
    return Material(
       shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
        ),
        child: SafeArea(
            top: false,
            child: Container(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                 Padding(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text("Add SFTP Config",
                          style: TextStyle(
                              color: (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
                              fontSize: theme.bottom_sheet_heading_font_size,
                              fontFamily: theme.font_family))),
                Divider(
                    color: Color.fromRGBO(255, 79, 90, 1),
                    thickness: 4.0,
                    indent: 70.0,
                    endIndent: 70.0,
                  ),

                ssh(),

                 Row(
          children: [
            
            Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.warning,
                )),
                Flexible(child: 
            Padding(
                padding: EdgeInsets.only(left: 3.0),
                child:Text(
                  "These Settings can be change later, from Deluge settings option",style: TextStyle(fontFamily: theme.font_family),
                )),)
          ],
        ),
                RaisedButton(
                    color: theme.base_color,
                    onPressed: () {
                      update_sftp_settings();
                      toastMessage("Added Config");
                      print("redirect to explorer");
                    },
                    child: Text("Save Configuration",
                        style: TextStyle(
                            fontFamily: theme.font_family,
                            fontSize: theme.minimal_font_size)))
              ],
            )))));
  }
}
