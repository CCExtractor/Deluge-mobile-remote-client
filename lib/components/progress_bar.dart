import 'dart:async';
import 'dart:io';
import 'package:deluge_client/control_center/theme.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/notification/notification_controller.dart';
import 'package:deluge_client/state_ware_house/state_ware_house.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

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
  final Function(bool) update_seeding_state;
  //-------------asking refresh function so we can refresh if  it get download
  final VoidCallback refresh_list;
  const download_progress(
      {Key key,
      @required this.torrent_id,
      @required this.cookie,
      @required this.tor_name,
      @required this.url,
      @required this.is_reverse_proxied,
      @required this.seed_username,
      @required this.seed_pass,
      @required this.qr_auth,
      @required this.paused,
      @required this.initial_progress,
      @required this.update_completion_state,
      @required this.completed,
      @required this.refresh_list,
      @required this.update_seeding_state})
      : super(key: key);

  @override
  download_progressState createState() => download_progressState(
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
      completed: completed,
      refresh: refresh_list,
      update_seeding_state: update_seeding_state);
}

class download_progressState extends State<download_progress> {
  String tor_id;
  String tor_name;
  List<Cookie> cookie;
  final double initial_progress;
  final Function(bool) update_completion_state;
  final Function(bool) update_seeding_state;
  //--
  bool completed;

  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  bool paused;
  final VoidCallback refresh;
  bool seeding = false;
  download_progressState(
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
      this.completed,
      this.refresh,
      this.update_seeding_state});
  double progress_percent = 0;
  //-----------------
  bool stop_listening_progress = false;
  bool needs_to_stop_listening = false;
  void get_status() async {
    try {
      Map<String, Properties> api_output = await apis.get_torrent_list(cookie,
          url, is_reverse_proxied, seed_username, seed_pass, qr_auth, context);

      if (api_output != null) {
        Properties content = await api_output[tor_id];
        double middletemp = content.progress;

        double temp = (middletemp / 100.0);
        print(temp);
        seeding = content.isSeed;

        if (this.mounted) {
          setState(() {
            progress_percent = temp;
            completed = content.isFinished;
            
          });
        }

        update_completion_state(completed);
        update_seeding_state(seeding);

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

        if (temp == 1.0 || needs_to_stop_listening) {
          stop_listening_progress = true;
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
    if (this.mounted) {
      setState(() {
        paused;
      });
    }
    handle_first_progress();
    trace_download_progress_bar();

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

  void trace_download_progress_bar() {
    if (!completed) {
      if (!paused) {
        Timer.periodic(Duration(seconds: 1), (timer) {
          if (stop_listening_progress) {
            timer.cancel();
          }

          if (this.mounted) {
            setState(() {
              get_status();
            });
          }
        });
      }
    }
  }

  void stop_listening_progress_bar() {
    needs_to_stop_listening = true;
  }

  void start_listening_progress_bar() {
    needs_to_stop_listening = false;
    stop_listening_progress = false;
  }

  void make_pause() {
    paused = true;
  }

  void make_resume() {
    paused = false;
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
          (progress_percent * 100).toString().length >= 5
              ? (progress_percent * 100).toString().substring(0, 5) + " %"
              : (progress_percent * 100).roundToDouble().toString() + " %",
          style: TextStyle(
              color: Colors.white,
              fontFamily: theme.font_family,
              fontSize: 11.0),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: (progress_percent * 100).roundToDouble() == 100.0
            ? theme.base_color
            : Colors.green,
      ),
    ));
  }
}

//----------------------------------------------------
