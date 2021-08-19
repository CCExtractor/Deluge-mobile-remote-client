import 'package:deluge_client/settings/deluge/core_settings.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';

class advance extends StatefulWidget {
  @override
  _advanceState createState() => _advanceState();
}

class _advanceState extends State<advance> {
  void initiate_setup() {
    try {
      if (this.mounted) {
        setState(() {
          core_settings.force_proxy = core_settings.settings.proxy["force_proxy"];
          core_settings.anonymous_mode =
              core_settings.settings.proxy["anonymous_mode"];
          core_settings.proxy_hostnames =
              core_settings.settings.proxy["proxy_hostnames"];

          core_settings.proxy_peer_connections =
              core_settings.settings.proxy["proxy_peer_connections"];
          core_settings.proxy_tracker_connections = core_settings
                      .settings.proxy["proxy_tracker_connections"];
        });
      }
    } catch (e) {
      print("error occoured from deluge end");
      print(e);
    }
  }

  @override
  void initState() {
    initiate_setup();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                  title: Text(
                    "Daemon port",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " Daemon ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.daemon_port,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "listen ports",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " Enter comma separated ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.listen_ports,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Listen interface",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " listen interface ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.listen_interface,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "listen random port",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " listen random port ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.listen_random_port,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "outgoing ports",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " outgoing ports ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.outgoing_ports,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "port",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " port ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.port,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "hostname",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " Hostname ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.hostname,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "username",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " username ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.user_name,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "password",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " password ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.password,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "Cache size",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " Cache size ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.cache_size,
                        autofocus: false,
                      ))),
              ListTile(
                  title: Text(
                    "cache expiry",
                    style: theme.sidebar_tile_style,
                  ),
                  subtitle: Padding(
                      padding: EdgeInsets.only(top: 10.0),
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
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: " cache expiry ",
                          fillColor: Colors.white70,
                        ),
                        controller: core_settings.cache_expiry,
                        autofocus: false,
                      ))),
              ListTile(
                title: Text("Force Proxy"),
                trailing: Switch(
                  value: core_settings.force_proxy,
                  onChanged: (val) {
                    setState(() {
                      core_settings.force_proxy = val;
                    });
                    print(val);
                  },
                ),
              ),
              ListTile(
                title: Text("anonymous mode"),
                trailing: Switch(
                  value: core_settings.anonymous_mode,
                  onChanged: (val) {
                    setState(() {
                      core_settings.anonymous_mode = val;
                    });
                    print(val);
                  },
                ),
              ),
              ListTile(
                title: Text("proxy hostnames"),
                trailing: Switch(
                  value: core_settings.proxy_hostnames,
                  onChanged: (val) {
                    setState(() {
                      core_settings.proxy_hostnames = val;
                    });
                    print(val);
                  },
                ),
              ),
              ListTile(
                title: Text("proxy peer connections"),
                trailing: Switch(
                  value: core_settings.proxy_peer_connections,
                  onChanged: (val) {
                    setState(() {
                      core_settings.proxy_peer_connections = val;
                    });
                    print(val);
                  },
                ),
              ),
              ListTile(
                title: Text("proxy tracker connections"),
                trailing: Switch(
                  value: core_settings.proxy_tracker_connections,
                  onChanged: (val) {
                    setState(() {
                      core_settings.proxy_tracker_connections = val;
                    });
                    print(val);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
