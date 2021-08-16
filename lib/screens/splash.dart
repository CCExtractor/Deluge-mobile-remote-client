import 'dart:async';

import 'package:deluge_client/screens/auth.dart';
import 'package:deluge_client/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  bool is_auth = false;
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (is_auth == false) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => auth_view(
                    tow_attachment: false,
                  )));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => dashboard()));
    }
  }

  void fetch_is_auth() async {
    bool ctxt_state = await states.state_is_auth_fetch();
    if (ctxt_state == null) {
      is_auth = false;
    } else if (ctxt_state == false) {
      is_auth = false;
    } else {
      is_auth = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetch_is_auth();
    startTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.base_color,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/animation.gif",
            height: 350.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      child: Text("\tDeluge mobile client\t",
                          style: theme.logo_text_style))),
            ],
          )
        ],
      )),
    );
  }
}
