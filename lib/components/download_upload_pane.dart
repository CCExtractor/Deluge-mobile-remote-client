import 'dart:async';
import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:deluge_client/control_center/theme.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

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
  _network_speedState createState() => _network_speedState(
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

class _network_speedState extends State<network_speed> {
  String tor_id;
  String tor_name;
  List<Cookie> cookie;
  final String url;
  final String is_reverse_proxied;
  final String seed_username;
  final String seed_pass;
  final String qr_auth;
  final bool paused;
  bool completed;
  _network_speedState(
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
  double download_speed_in_kb = 0.0;
  double upload_speed_in_kb = 0.0;
  Future<void> fetch_speed() async {
    try {
      Map<String, dynamic> api_output = await apis.get_torrent_list(
          cookie, url, is_reverse_proxied, seed_username, seed_pass, qr_auth);
      if (api_output != null) {
        Map<String, dynamic> result = api_output['result'];
        Map<String, dynamic> properties = result[tor_id];
        if (this.mounted) {
          setState(() {
            completed = properties["is_finished"];
          });
        }

        download_speed_in_byte = properties['download_payload_rate'].toInt();

        upload_speed_in_byte = properties['upload_payload_rate'].toInt();
        if (this.mounted) {
          setState(() {
            download_speed_in_kb = download_speed_in_byte / 1000;
            upload_speed_in_kb = upload_speed_in_byte / 1000;
          });
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
    setState(() {
      paused;
    });
    if (!paused || !completed) {
      Timer.periodic(Duration(seconds: 2), (timer) {
        if (completed) {
          timer.cancel();
        }
        if (this.mounted) {
          setState(() {
            fetch_speed();
          });
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.arrow_downward_sharp),
        Text(
          download_speed_in_kb.toString() + " KB/S",
          style: TextStyle(
              color: (!theme_controller.is_it_dark()
                                  ? Colors.black
                                  : Colors.white),
              fontSize: 11.0,
              fontFamily: theme.font_family),
        ),
        Icon(Icons.arrow_upward),
        Text(upload_speed_in_kb.toString() + " KB/S",
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
