import 'dart:async';
import 'dart:io';
import 'package:deluge_client/control_center/theme.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/notification/notification_controller.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';

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
  final bool completed;
  final Function(bool) update_completion_state;
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
      this.initial_progress,
      @required this.update_completion_state,
      this.completed})
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
      initial_progress: initial_progress,
      update_completion_state: update_completion_state,
      completed: completed);
}

class _download_progressState extends State<download_progress> {
  String tor_id;
  String tor_name;
  List<Cookie> cookie;
  final double initial_progress;
  final Function(bool) update_completion_state;
  //--
  bool completed;

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
      this.initial_progress,
      this.update_completion_state,
      this.completed});
  double progress_percent = 0;
  //-----------------
  void get_status() async {
    try {
      Map<String, dynamic> api_output = await apis.get_torrent_list(
          cookie, url, is_reverse_proxied, seed_username, seed_pass, qr_auth,context);
      Map<String, dynamic> result = await api_output['result'];
      if (result != null) {
        Map<String, dynamic> content = await result[tor_id];
        double middletemp = content['progress'];

        double temp = (middletemp / 100.0);
        print(temp);

        if (this.mounted) {
          setState(() {
            progress_percent = temp;
            completed = content['is_finished'];
          });
        }

        update_completion_state(completed);

        //--------------------------notification
        if (notification_status == true) {
          notification.store_ids.add(tor_id);
          int idt = notification.fetch_noti_id(tor_id);
          notification.notification_on_progress(
              tor_id,
              idt > 0 ? idt : 0,
              "torrents",
              tor_name,
              (progress_percent * 100).roundToDouble().toString() + " %",
              progress_percent.toInt() * 100);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  int progress_fire = 0;
  bool notification_status;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      paused;
    });
    handle_first_progress();
    if (!paused || !completed) {
      Timer.periodic(Duration(milliseconds: 2), (timer) {
        if (completed) {
          timer.cancel();
        }

        if (this.mounted) {
          setState(() {
            get_status();
          });
        }
      });
    }
    //----------------------
    fetch_notification_settings();

    super.initState();
  }

  void fetch_notification_settings() async {
    bool mid = await states.fetch_notification_settings();
    setState(() {
      notification_status = mid;
    });
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
        width: MediaQuery.of(context).size.width - 120.0,
        animation: false,
        lineHeight: 15.0,
        animationDuration: 2000,
        percent: progress_percent,
        center: Text(
        (progress_percent * 100).toString().length>=5?(progress_percent * 100).toString().substring(0,5)+ " %":(progress_percent * 100).roundToDouble().toString()+ " %",
          style: TextStyle(
              color: Colors.white,
              fontFamily: theme.font_family,
              fontSize: 11.0),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor:(progress_percent * 100).roundToDouble()==100.0?theme.base_color:Colors.green,
      ),
    ));
  }
}

//----------------------------------------------------
