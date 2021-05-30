import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deluge_client/control_center/theme.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:deluge_client/api/apis.dart';

class download_progress extends StatefulWidget {
  final String torrent_id;
  final List<Cookie> cookie;
  final String tor_name;
  final double initial_progress;
  //--
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  final bool paused;
  const download_progress(
      {Key key,
      @required this.torrent_id,
      this.cookie,
      this.tor_name,
      this.url,
      this.is_reverse_proxied,
      this.seed_username,
      this.seed_pass,
      this.qr_auth,
      this.paused,
      this.initial_progress})
      : super(key: key);

  @override
  _download_progressState createState() => _download_progressState(
      tor_id: torrent_id,
      tor_name: tor_name,
      cookie: cookie,
      url: url,
      is_reverse_proxied: is_reverse_proxied,
      seed_username: seed_username,
      seed_pass: seed_pass,
      qr_auth: qr_auth,
      paused: paused,
      initial_progress: initial_progress);
}

class _download_progressState extends State<download_progress> {
  String tor_id;
  String tor_name;
  List<Cookie> cookie;
  final double initial_progress;
  //--

  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  final bool paused;
  _download_progressState(
      {this.tor_id,
      this.cookie,
      this.tor_name,
      this.url,
      this.is_reverse_proxied,
      this.seed_username,
      this.seed_pass,
      this.qr_auth,
      this.paused,
      this.initial_progress});
  double progress_percent = 0;
  //-----------------
  void get_status() async {
    try {
      var param = new List();
      param.add(tor_id);

      Map<String, dynamic> api_output = await apis.progress_bar(param, cookie,
          url, is_reverse_proxied, seed_username, seed_pass, qr_auth);

      Map<String, dynamic> result = await api_output['result'];

      Map<String, dynamic> content = await result['contents'];
      Map<String, dynamic> torrent_info = await content[tor_name];

      if (torrent_info != null) {
        String middletemp = torrent_info['progress'].toString().length >= 4
            ? torrent_info['progress'].toString().substring(0, 4)
            : torrent_info['progress'].toString().substring(0, 3);
        
    
        double temp = double.parse(middletemp);
        
        if (this.mounted) {
          setState(() {
            progress_percent = temp;
            
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  int progress_fire = 0;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      paused;
    });
    handle_first_progress();
    if (!paused) {
      Timer.periodic(Duration(seconds: 2), (timer) {
        if (this.mounted) {
          setState(() {
            get_status();
          });
        }
      });
    }

    super.initState();
  }

  void handle_first_progress() {
    double temp = initial_progress / 100.0;

    if (this.mounted) {
      setState(() {
        progress_percent = temp;
      });
    }
  }

//Text(tor_id == null ? "" : tor_id);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 50,
        animation: false,
        lineHeight: 15.0,
        animationDuration: 2000,
        percent: progress_percent,
        center: Text(
          (progress_percent * 100).roundToDouble().toString() + " %",
          style: TextStyle(
              color: Colors.white,
              fontFamily: theme.font_family,
              fontSize: 11.0),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: theme.base_color,
      ),
    ));
  }
}

//----------------------------------------------------
