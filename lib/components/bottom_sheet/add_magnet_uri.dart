import 'dart:convert';
import 'dart:io';

import 'package:deluge_client/components/storage_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/string/magnet_detect.dart';
import 'package:fluttertoast/fluttertoast.dart';

class add_magnet extends StatefulWidget {
  final List<Cookie> cookie;
  final VoidCallback refresh;
  //-----------------------------------
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  add_magnet(
      {Key key,
      @required this.refresh,
      @required this.cookie,
      @required this.url,
      @required this.is_reverse_proxied,
      @required this.seed_username,
      @required this.seed_pass,
      @required this.qr_auth})
      : super(key: key);
  @override
  _add_magnetState createState() => _add_magnetState(
      refresh: refresh,
      cookie: cookie,
      url: url,
      is_reverse_proxied: is_reverse_proxied,
      seed_username: seed_username,
      seed_pass: seed_pass,
      qr_auth: qr_auth);
}

class _add_magnetState extends State<add_magnet> {
  final VoidCallback refresh;
  final List<Cookie> cookie;
  //--------------------------------------
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;

  _add_magnetState(
      {this.cookie,
      this.refresh,
      this.url,
      this.is_reverse_proxied,
      this.seed_username,
      this.seed_pass,
      this.qr_auth});
  var myController = TextEditingController();
  String input = "";
  Future<void> fetch_clipboard() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    input = data.text;
    if (this.mounted) {
      setState(() {
        myController.text = input;
      });
    }
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

  void add_torrent_by_magnet_uri(String link) async {
    if (magnet_detect.parse(link)) {
      apis.add_magnet(link, cookie, url, is_reverse_proxied, seed_username,
          seed_pass, qr_auth,context);

      // after adding file then it should refresh it self;
       Navigator.of(context).pop();//bottom sheet should get closed
      Future.delayed(Duration(seconds: 1), () {
        refresh();
      });
     
    } else {
      toastMessage("Please enter correct link");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: 
         Material(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
        ),
        child:

   
        
             Container(
               padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
               child: 
              Column(
                
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  Divider(
                    color: Color.fromRGBO(255, 79, 90, 1),
                    thickness: 4.0,
                    indent: 70.0,
                    endIndent: 70.0,
                  ),
                  
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: 
                          TextField(
                                onChanged: (String val) {
                                  setState(() {
                                    myController.text;
                                  });
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: theme.alert_box_font_size,
                                    fontFamily: theme.font_family),
                                decoration: new InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Enter Magnet URL",
                                  suffixIcon: InkWell(
                                    child: Icon(Icons.paste),
                                    onTap: () {
                                      fetch_clipboard();
                                    },
                                  ),
                                  fillColor: Colors.white70,
                                ),
                                controller: myController,
                                autofocus: true,
                              )),
                        
                      
                  RaisedButton(
                    onPressed: () {
                      if (myController.text.length > 0) {
                        add_torrent_by_magnet_uri(myController.text);
                      }
                    },
                    color: myController.text.length > 0
                        ? theme.base_color
                        : Colors.grey,
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: theme.alert_box_font_size,
                          fontFamily: theme.font_family),
                    ),
                  )
                ],
              )),
            ));
  }
}
