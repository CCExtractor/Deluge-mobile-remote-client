import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:filesize/filesize.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/control_center/theme_controller.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

class network_speed extends StatefulWidget {
  final String torrent_id;
  final List<Cookie> cookie;
  final String tor_name;
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  final bool paused;
  final bool completed;
  const network_speed(
      {Key key,
      @required this.torrent_id,
      this.cookie,
      this.tor_name,
      this.url,
      this.is_reverse_proxied,
      this.seed_pass,
      this.seed_username,
      this.qr_auth,
      this.paused,
      this.completed})
      : super(key: key);

  @override
  network_speedState createState() => network_speedState(
      tor_id: torrent_id,
      tor_name: tor_name,
      cookie: cookie,
      url: url,
      is_reverse_proxied: is_reverse_proxied,
      seed_username: seed_username,
      seed_pass: seed_pass,
      qr_auth: qr_auth,
      paused: paused,
      completed: completed);
}

class network_speedState extends State<network_speed> {
  String tor_id;
  String tor_name;
  List<Cookie> cookie;
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
   bool paused;
  bool completed;
  network_speedState(
      {this.tor_id,
      this.cookie,
      this.tor_name,
      this.url,
      this.is_reverse_proxied,
      this.seed_username,
      this.seed_pass,
      this.qr_auth,
      this.paused,
      this.completed});
  int download_speed_in_byte = 0;
  int upload_speed_in_byte = 0;
  String download_speed = "0.0 KB";
  String upload_speed = "0.0 KB";
  bool stop_listening_speeds = false;
  bool have_to_stop = false;

  Future<void> fetch_speed() async {
    try {
      Map<String, Properties> api_output = await apis.get_torrent_list(cookie,
          url, is_reverse_proxied, seed_username, seed_pass, qr_auth, context);
      if (api_output != null) {
        Properties properties = api_output[tor_id];
        if (this.mounted) {
          setState(() {
            completed = properties.isFinished;
          });
        }

        download_speed_in_byte = properties.downloadPayloadRate;

        upload_speed_in_byte = properties.uploadPayloadRate;
        print("Download size: " + filesize(download_speed_in_byte));
        if (this.mounted) {
          setState(() {
            download_speed = filesize(download_speed_in_byte);
            upload_speed = filesize(upload_speed_in_byte);
          });
        }

        if (completed || have_to_stop) {
          stop_listening_speeds = true;
        }
      }
    }
    // print(progress_percent);
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (this.mounted) {
      setState(() {
        paused;
      });
    }
    trace_down_up_speed();

    super.initState();
  }

  void trace_down_up_speed() {
    if (!completed) {
      if (!paused) {
        Timer.periodic(Duration(seconds: 1), (timer) {
          if (stop_listening_speeds) {
            timer.cancel();
          }
          if (this.mounted) {
            setState(() {
              fetch_speed();
            });
          }
        });
      }
    }
  }

  void stop_listening_network_speed() {
    have_to_stop = true;
  }

  void start_listening_network_speed() {
    have_to_stop = false;
    stop_listening_speeds = false;
  }

   void make_pause() {
    paused = true;
  }

  void make_resume() {
    paused = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_downward_sharp),
        Text(
          download_speed + "/S",
          style: TextStyle(
              color: (!theme_controller.is_it_dark()
                  ? Colors.black
                  : Colors.white),
              fontSize: 11.0,
              fontFamily: theme.font_family),
        ),
        Icon(Icons.arrow_upward),
        Text(upload_speed + "/S",
            style: TextStyle(
                color: (!theme_controller.is_it_dark()
                    ? Colors.black
                    : Colors.white),
                fontSize: 11.0,
                fontFamily: theme.font_family)),
      ],
    );
  }
}
