import 'dart:io';


import 'package:flutter/material.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:deluge_client/api/models/settings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class core_settings {
  static Settings settings;

  static var download_Directory = TextEditingController();
  static var torrent_file_Directory = TextEditingController();
  static var move_after_completion_path = TextEditingController();
  static var max_connection_global = TextEditingController();
  static var max_upload_speed = TextEditingController();
  static var max_download_speed = TextEditingController();
  static var max_upload_slots = TextEditingController();
  static var max_half_open_connection = TextEditingController();
  static var max_connection_per_second = TextEditingController();
  static var max_connection_per_torrent = TextEditingController();
  static var max_uploads_slots_per_torrent = TextEditingController();
  static var max_download_speed_per_torrent = TextEditingController();
  //---------------------------------------------------------------------------
  static bool send_info = false;
  static bool allow_remote = false;
  static bool pre_allocate_storage = false;
  static bool random_port = false;
  static bool listen_use_sys_port = false;
  static bool listen_reuse_port = false;
  static bool random_outgoing_ports = false;
  static bool copy_torrent = false;
  static bool delete_copy_torrent_file = false;
  static bool prioritize_first_last_pieces = false;
  static bool sequential_download = false;
  static bool dht = false;
  static bool upnp = false;
  static bool natpmp = false;
  static bool utpex = false;
  static bool lsd = false;
  static bool rate_limit_ip_overhead = false;
  static bool auto_manage_prefer_seeds = false;
  static bool shared = false;
  static bool super_seeding = false;
  //--------------------------------------------------
  //advance
  static var daemon_port = TextEditingController();
  static var listen_ports = TextEditingController();
  static var listen_interface = TextEditingController();
  static var listen_random_port = TextEditingController();
  static var outgoing_ports = TextEditingController();
  static var port = TextEditingController();
  static var hostname = TextEditingController();
  static var user_name = TextEditingController();
  static var password = TextEditingController();
  static var cache_size = TextEditingController();
  static var cache_expiry = TextEditingController();
//---------------------------------------------
  static bool force_proxy = false;
  static bool anonymous_mode = false;
  static bool proxy_hostnames = false;
  static bool proxy_peer_connections = false;
  static bool proxy_tracker_connections = false;
  //----------------------------------------------------------------------------------
  //editing controller for the sftp and streamer config
  static var sftp_host = TextEditingController();
  static var sftpport = TextEditingController();
  static var sftp_username = TextEditingController();
  static var sftp_pass = TextEditingController();
  static var sftp_route_url = TextEditingController();
  //------------------------------------------------------------------------------------------

  static void fetch(
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth,
      BuildContext context) async {
    Map<String, dynamic> json = await apis.fetch_settings(cookie, url,
        is_reverse_proxied, seed_username, seed_pass, qr_auth, context);

    settings = new Settings(json);

    Future.delayed(Duration(seconds: 1), () {
      initiate_workspace();
    });
  }

  static void initiate_workspace() {
    download_Directory.text = settings.downloadLocation;
    torrent_file_Directory.text = settings.torrentfilesLocation;
    move_after_completion_path.text = settings.moveCompletedPath;
    max_connection_global.text = settings.maxConnectionsGlobal.toString();
    max_upload_slots.text = settings.maxUploadSlotsGlobal.toString();
    max_half_open_connection.text = settings.maxHalfOpenConnections.toString();
    max_connection_per_second.text =
        settings.maxConnectionsPerSecond.toString();
    max_connection_per_torrent.text =
        settings.maxConnectionsPerTorrent.toString();
    max_uploads_slots_per_torrent.text =
        settings.maxUploadSlotsPerTorrent.toString();
    max_download_speed_per_torrent.text =
        settings.maxDownloadSpeedPerTorrent.toString();
    max_download_speed.text = settings.maxDownloadSpeed.toString();
    max_upload_speed.text = settings.maxUploadSpeed.toString();
    //-----------------------
    //advance section
    daemon_port.text = settings.daemonPort.toString();
    listen_ports.text = settings.listenPorts
        .toString()
        .replaceFirst('[', "")
        .replaceFirst("]", "");
    listen_interface.text = settings.listenInterface;
    listen_random_port.text = settings.listenRandomPort.toString();
    outgoing_ports.text = settings.outgoingPorts
        .toString()
        .replaceFirst('[', "")
        .replaceFirst("]", "");
    port.text = settings.proxy["port"].toString();
    hostname.text = settings.proxy["hostname"].toString();
    password.text = settings.proxy["password"].toString();
    user_name.text = settings.proxy["username"].toString();
    cache_size.text = settings.cacheSize.toString();
    cache_expiry.text = settings.cacheExpiry.toString();
    //--------------------------------------------
  }
}
