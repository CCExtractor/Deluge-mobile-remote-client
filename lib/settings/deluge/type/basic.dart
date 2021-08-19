import 'package:flutter/material.dart';
import 'package:deluge_client/settings/deluge/core_settings.dart';

class basic extends StatefulWidget {
  @override
  _basicState createState() => _basicState();
}

class _basicState extends State<basic> {
  void initiate_basic_setting() {
    try {
      if (this.mounted) {
        setState(() {
          core_settings.send_info = core_settings.settings.sendInfo;
          core_settings.allow_remote = core_settings.settings.allowRemote;
          core_settings.pre_allocate_storage =
              core_settings.settings.preAllocateStorage;
          core_settings.random_port =
              core_settings.settings.randomPort.toString() == "False"
                  ? false
                  : true;
          core_settings.listen_use_sys_port =
              core_settings.settings.listenUseSysPort;

          core_settings.listen_reuse_port =
              core_settings.settings.listenReusePort;
          core_settings.random_outgoing_ports =
              core_settings.settings.randomOutgoingPorts.toString() == "False"
                  ? false
                  : true;

          core_settings.copy_torrent = core_settings.settings.copyTorrentFile;
          core_settings.delete_copy_torrent_file =
              core_settings.settings.delCopyTorrentFile;
          core_settings.prioritize_first_last_pieces =
              core_settings.settings.prioritizeFirstLastPieces;
          core_settings.sequential_download =
              core_settings.settings.sequentialDownload;
          core_settings.dht = core_settings.settings.dht;
          core_settings.upnp = core_settings.settings.upnp;
          core_settings.natpmp = core_settings.settings.natpmp;
          core_settings.utpex = core_settings.settings.utpex;
          core_settings.lsd = core_settings.settings.lsd;
          core_settings.rate_limit_ip_overhead =
              core_settings.settings.rateLimitIpOverhead;

          core_settings.auto_manage_prefer_seeds =
              core_settings.settings.autoManagePreferSeeds;
          core_settings.shared = core_settings.settings.shared;
          core_settings.super_seeding = core_settings.settings.superSeeding;
        });
      }
    } catch (e) {
      print("error occoured at deluge end");
      print(e);
    }
  }

  @override
  void initState() {
    initiate_basic_setting();

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
            title: Text("Send info"),
            trailing: Switch(
              value: core_settings.send_info,
              onChanged: (val) {
                setState(() {
                  core_settings.send_info = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("Allow remote"),
            trailing: Switch(
              value: core_settings.allow_remote,
              onChanged: (val) {
                setState(() {
                  core_settings.allow_remote = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("pre allocate storage"),
            trailing: Switch(
              value: core_settings.pre_allocate_storage,
              onChanged: (val) {
                setState(() {
                  core_settings.pre_allocate_storage = val;
                });
                print(val);
              },
            ),
          ),

          ListTile(
            title: Text("Random port"),
            trailing: Switch(
              value: core_settings.random_port,
              onChanged: (val) {
                setState(() {
                  core_settings.random_port = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("Listen use sys port"),
            trailing: Switch(
              value: core_settings.listen_use_sys_port,
              onChanged: (val) {
                setState(() {
                  core_settings.listen_use_sys_port = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("listen reuse port"),
            trailing: Switch(
              value: core_settings.listen_reuse_port,
              onChanged: (val) {
                setState(() {
                  core_settings.listen_reuse_port = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("random outgoing ports"),
            trailing: Switch(
              value: core_settings.random_outgoing_ports,
              onChanged: (val) {
                setState(() {
                  core_settings.random_outgoing_ports = val;
                });
                print(val);
              },
            ),
          ),
          // //--------------------------------
          ListTile(
            title: Text("Copy torrent file"),
            trailing: Switch(
              value: core_settings.copy_torrent,
              onChanged: (val) {
                setState(() {
                  core_settings.copy_torrent = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("Delete copy torrent file"),
            trailing: Switch(
              value: core_settings.delete_copy_torrent_file,
              onChanged: (val) {
                setState(() {
                  core_settings.delete_copy_torrent_file = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("prioritize first last pieces"),
            trailing: Switch(
              value: core_settings.prioritize_first_last_pieces,
              onChanged: (val) {
                setState(() {
                  core_settings.prioritize_first_last_pieces = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("sequential download"),
            trailing: Switch(
              value: core_settings.sequential_download,
              onChanged: (val) {
                setState(() {
                  core_settings.sequential_download = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("dht"),
            trailing: Switch(
              value: core_settings.dht,
              onChanged: (val) {
                setState(() {
                  core_settings.dht = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("upnp"),
            trailing: Switch(
              value: core_settings.upnp,
              onChanged: (val) {
                setState(() {
                  core_settings.upnp = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("natpmp"),
            trailing: Switch(
              value: core_settings.natpmp,
              onChanged: (val) {
                setState(() {
                  core_settings.natpmp = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("utpex"),
            trailing: Switch(
              value: core_settings.utpex,
              onChanged: (val) {
                setState(() {
                  core_settings.utpex = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("lsd"),
            trailing: Switch(
              value: core_settings.lsd,
              onChanged: (val) {
                setState(() {
                  core_settings.lsd = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("rate limit ip overhead"),
            trailing: Switch(
              value: core_settings.rate_limit_ip_overhead,
              onChanged: (val) {
                setState(() {
                  core_settings.rate_limit_ip_overhead = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("auto manage prefer seeds"),
            trailing: Switch(
              value: core_settings.auto_manage_prefer_seeds,
              onChanged: (val) {
                setState(() {
                  core_settings.auto_manage_prefer_seeds = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("Shared"),
            trailing: Switch(
              value: core_settings.shared,
              onChanged: (val) {
                setState(() {
                  core_settings.shared = val;
                });
                print(val);
              },
            ),
          ),
          ListTile(
            title: Text("Super seeding"),
            trailing: Switch(
              value: core_settings.super_seeding,
              onChanged: (val) {
                setState(() {
                  core_settings.super_seeding = val;
                });
                print(val);
              },
            ),
          ),
        ],
      )),
    );
  }
}
