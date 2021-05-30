import 'dart:io';

import 'package:deluge_client/auth_qr.dart';
import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

class auth_view extends StatefulWidget {
  final bool tow_attachment;
  auth_view({Key key, this.tow_attachment}) : super(key: key);
  @override
  _auth_viewState createState() =>
      _auth_viewState(tow_attachment: tow_attachment);
}

class _auth_viewState extends State<auth_view> {
  final bool tow_attachment;
  _auth_viewState({this.tow_attachment});
  //----------------------------------------------------------
  final DbbucketManager dbmanager = new DbbucketManager();
  bool isreverse_proxied = false;
  String input;
  bool has_deluge_pass = false;
  var url = TextEditingController();
  var pass = TextEditingController();
  var username = TextEditingController();
  var seed_pass = TextEditingController();
  Future<void> fetch_clipboard() async {
    ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);
    input = data.text;

    setState(() {
      url.text = input;
    });
  }

  bool vis_deluge_pass = false;
  bool vis_seed_pass = false;
  void add_in_db(String url, String deluge_has_pass, String del_pass,
      String reverse_proxied, String username, String password) {
    Bucket item = new Bucket(
      deluge_url: url,
      has_deluge_pwrd: deluge_has_pass,
      deluge_pwrd: del_pass,
      is_reverse_proxied: reverse_proxied,
      username: username,
      password: password,
      via_qr: "",
    );
    dbmanager
        .insertbucket(item)
        .then((id) => {print('item Added to Db ${id}')});
  }

  //-----------------
 
  void set_auth_state() async {
    states.set_auth();
  }



  @override
  void initState() {
    states.first_time_setup_selection();
    super.initState();
  }

//---------
//-
  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
      backgroundColor: Colors.black,
    );
  }

  void check_validity(String url, String password, String has_deluge_pass,
      String is_reverse_proxied, String seed_username, seed_pass) async {
    bool validity = await apis.auth_validity(url, password, has_deluge_pass,
        is_reverse_proxied, seed_username, seed_pass, "");
    if (validity) {
      add_in_db(url, has_deluge_pass, password, is_reverse_proxied,
          seed_username, seed_pass);
      set_auth_state();
      !tow_attachment
          ? toastMessage("Successfully Authorized")
          : toastMessage("Successfully added");
      !tow_attachment
          ? Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()))
          : Navigator.pop(context);
    } else {
      toastMessage("Credentials are wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Authorization",
            style: theme.app_bar_style,
          ),
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(241, 94, 90, 1.0),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: Color.fromRGBO(241, 94, 90, 1.0),
                  padding: EdgeInsets.only(top: 3.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: Image.asset(
                              "assets/logo.png",
                              height: 180.0,
                            ))
                      ],
                    ),

                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
                        child: Text(
                          "\tDeluge mobile client\t",
                          style: theme.logo_text_style,
                        )),
                    //--
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Flexible(
                                fit: FlexFit.tight,
                                child: TextField(
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
                                    hintText: "Location of Deluge",
                                    suffixIcon: InkWell(
                                      child: Icon(Icons.paste),
                                      onTap: () {
                                        fetch_clipboard();
                                      },
                                    ),
                                    fillColor: Colors.white70,
                                  ),
                                  controller: url,
                                  autofocus: false,
                                ))
                          ],
                        )),
                    //----
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.white,
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 3.0),
                            child: Text("check your browser address-bar",
                                style: theme.warning_style)),
                      ],
                    ),
                    //--
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Switch(
                            value: has_deluge_pass,
                            onChanged: (val) {
                              setState(() {
                                has_deluge_pass = !has_deluge_pass;
                              });
                            }),
                        Text("is Deluge has password?",
                            style: theme.warning_style),
                      ],
                    ),
                    //--
                    has_deluge_pass
                        ? Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    child: TextField(
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
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Deluge's Password",
                                        suffixIcon: InkWell(
                                          child: Icon(vis_deluge_pass
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onTap: () {
                                            if (this.mounted) {
                                              setState(() {
                                                vis_deluge_pass =
                                                    !vis_deluge_pass;
                                              });
                                            }
                                          },
                                        ),
                                        fillColor: Colors.white70,
                                      ),
                                      obscureText:
                                          vis_deluge_pass ? false : true,
                                      controller: pass,
                                      autofocus: false,
                                    ))
                              ],
                            ))
                        : new Container(
                            height: 0.0,
                            width: 0.0,
                          ),
                    //-
                    SizedBox(height: 5.0),

                    //-----
                  ])),
              //---
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            onChanged: (String val) {
                              setState(() {
                                if (username.text.length > 0) {
                                  isreverse_proxied = true;
                                } else {
                                  isreverse_proxied = false;
                                }
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
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Username",
                              fillColor: Colors.white70,
                            ),
                            controller: username,
                            autofocus: false,
                          ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            onChanged: (String val) {
                              setState(() {
                                if (username.text.length > 0 &&
                                    seed_pass.text.length > 0) {
                                  isreverse_proxied = true;
                                } else {
                                  isreverse_proxied = false;
                                }
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
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "Password",
                              fillColor: Colors.white70,
                              suffixIcon: InkWell(
                                child: Icon(vis_seed_pass
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onTap: () {
                                  setState(() {
                                    vis_seed_pass = !vis_seed_pass;
                                  });
                                },
                              ),
                            ),
                            controller: seed_pass,
                            obscureText: vis_seed_pass ? false : true,
                            autofocus: false,
                          ))
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Switch(
                      value: isreverse_proxied,
                      onChanged: (val) {
                        print("ok" + val.toString());
                        setState(() {
                          isreverse_proxied = !isreverse_proxied;
                        });
                      }),
                  Text(
                    "is reverse proxied?",
                    style: theme.warning_style2,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 35.0),
                      child: RaisedButton(
                        color: theme.base_color,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => auth_qr(
                                        tow_attachment: tow_attachment,
                                      )));
                        },
                        child: Text(
                          "Have QR",
                          style: theme.warning_style,
                        ),
                      ))
                ],
              ),
              //---
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side:
                            BorderSide(color: Color.fromRGBO(241, 94, 90, 1.0)),
                      ),
                      primary: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 16),
                      child: Text(
                        !tow_attachment ? 'Let\'s get started' : 'Add account',
                        style: TextStyle(
                            color: theme.base_color,
                            fontSize: 18,
                            fontFamily: theme.font_family),
                      ),
                    ),
                    onPressed: () {
                      if (url.text.length > 0) {
                        check_validity(
                            url.text,
                            pass.text,
                            has_deluge_pass.toString(),
                            isreverse_proxied.toString(),
                            username.text,
                            seed_pass.text);
                      } else {
                        toastMessage("Please enter location");
                      }
                    },
                  ),
                ),
              )
              //---
            ],
          ),
        ));
  }
}
