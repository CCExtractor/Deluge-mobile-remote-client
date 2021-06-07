import 'dart:convert';
import 'dart:io';
import 'package:deluge_client/settings/deluge/core_settings.dart';

class apis {
  static int network_request = 0;
  static Future<List<Cookie>> authentication_to_deluge(
    String url,
    String password,
    String has_deluge_pass,
    String is_reverse_proxied,
    String seed_username,
    String seed_pass,
    String qr_auth,
  ) async {
    Map<String, dynamic> payload = {
      "id": network_request++,
      "method": "auth.login",
      "params": [has_deluge_pass == 'true' ? "$password" : "deluge"]
    };
    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }

      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(payload),
        ),
      );

      final response = await request.close();
      // print(response.cookies);
      List<Cookie> cookie = response.cookies;

      final responseBody = await response.transform(utf8.decoder).join();

      return cookie;
      // print(responseBody);
      // print(jsonDecode(responseBody));
      // final result = Model.fromJson(json.decode(responseBody));
    } catch (error) {
      print(error);
    }
  }

  //-------------------------------------------------------------------------
  static Future<Map<String, dynamic>> get_torrent_list(
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    try {
      Map<String, dynamic> requestPayload = {
        "method": "core.get_torrents_status",
        "params": [[], []],
        "id": network_request++
      };
      final httpclient = new HttpClient();
      //try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();
      // print(response.cookies);
      cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> client_output = json.decode(responseBody);

      return client_output;
    } catch (e) {
      return new Map();
    }
  }

  //------------------------------------------------------------------------------
  static void resume_activity(
      String key,
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.resume_torrent",
      "params": [
        ["$key"]
      ],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      // we do not need response body here

    } catch (e) {
      print(e);
    }
  }

  //-------------------------------------------
  static void pause_activity(
      String key,
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.pause_torrent",
      "params": [
        ["$key"]
      ],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      print(e);
    }
  }

  //--------------------------------------------------------------------------
  static void delete_activity(
      List<Cookie> cookie,
      String key,
      bool remove_file,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.remove_torrent",
      "params": ["$key", remove_file],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      print(e);
    }
  }

  //--
  static Future<bool> auth_validity(
      String url,
      String password,
      String has_deluge_pass,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> payload = {
      "id": network_request++,
      "method": "auth.login",
      "params": [has_deluge_pass == 'true' ? "$password" : "deluge"]
    };
    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");

      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));

        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(payload),
        ),
      );

      final response = await request.close();
      // print(response.cookies);
      List<Cookie> cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      print(responseBody);
      Map<String, dynamic> auth_out = await json.decode(responseBody);
      bool output = auth_out["result"];
      return output;

      // print(responseBody);
      // print(jsonDecode(responseBody));
      // final result = Model.fromJson(json.decode(responseBody));
    } catch (error) {
      print(error);
      return false;
    }
  }
  //---------------------------------

  //--------------------------------

  //------------------------------------------------------------------------
  static void add_torrent_file(
      String base64,
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.add_torrent_file",
      "params": ["", "$base64", ""],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      // cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      print(jsonDecode(responseBody));
      // after adding file then it should refresh it self;
    } catch (e) {
      print(e);
    }
  }
  //--------------------------------------------------------------

  static void add_magnet(
      String link,
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.add_torrent_magnet",
      "params": ["$link", {}],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      // cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
    } catch (e) {
      print(e);
    }
  }

  //-----------------------------------------
  static Future<Map<String, dynamic>> fetch_config(
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.get_config",
      "params": [],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      // cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> res = json.decode(responseBody);
      return res;
    } catch (e) {
      print(e);
    }
  }

  static Future<int> fetch_free_space(
      List<Cookie> cookie,
      String download_path,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.get_free_space",
      "params": [download_path],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      // cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> res = json.decode(responseBody);
      return res['result'];
    } catch (e) {
      print(e);
    }
  }

  static void update_config_settings(
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    List out_going_port_param =
        core_settings.outgoing_ports.text.toString().split(",");
    List listen_port_param =
        core_settings.listen_ports.text.toString().split(",");
    Map<String, dynamic> param = {
      "download_location": core_settings.download_Directory.text.toString(),
      "torrentfiles_location":
          core_settings.torrent_file_Directory.text.toString(),
      "move_completed_path":
          core_settings.move_after_completion_path.text.toString(),
      "max_upload_speed": core_settings.max_upload_speed.text.toString(),
      "max_download_speed": core_settings.max_download_speed.text.toString(),
      "max_upload_slots_global": core_settings.max_upload_slots.text.toString(),
      "max_half_open_connections":
          core_settings.max_half_open_connection.text.toString(),
      "max_connections_per_second":
          core_settings.max_connection_per_second.text.toString(),
      "max_connections_per_torrent":
          core_settings.max_connection_per_torrent.text.toString(),
      "max_upload_slots_per_torrent":
          core_settings.max_uploads_slots_per_torrent.text.toString(),
      "max_download_speed_per_torrent":
          core_settings.max_download_speed_per_torrent.text.toString(),
      //--
      "send_info": core_settings.send_info,
      "allow_remote": core_settings.allow_remote,
      "pre_allocate_storage": core_settings.pre_allocate_storage,
      "random_port": core_settings.random_port,
      "listen_use_sys_port": core_settings.listen_use_sys_port,
      "listen_reuse_port": core_settings.listen_reuse_port,
      "random_outgoing_ports": core_settings.random_outgoing_ports,
      "copy_torrent_file": core_settings.copy_torrent,
      "del_copy_torrent_file": core_settings.delete_copy_torrent_file,
      "prioritize_first_last_pieces":
          core_settings.prioritize_first_last_pieces,
      "sequential_download": core_settings.sequential_download,
      "dht": core_settings.dht,
      "upnp": core_settings.upnp,
      "natpmp": core_settings.natpmp,
      "utpex": core_settings.utpex,
      "lsd": core_settings.lsd,
      "rate_limit_ip_overhead": core_settings.rate_limit_ip_overhead,
      "auto_manage_prefer_seeds": core_settings.auto_manage_prefer_seeds,
      "shared": core_settings.shared,
      "super_seeding": core_settings.super_seeding,
      //--------------------------------------------------
      "daemon_port": core_settings.daemon_port.text.toString(),
      "listen_ports": listen_port_param,
      "listen_interface": core_settings.listen_interface.text.toString(),
      "listen_random_port": core_settings.listen_random_port.text.toString(),
      "outgoing_ports": out_going_port_param,
      "proxy": {
        "port": core_settings.port.text.toString(),
        "hostname": core_settings.hostname.text.toString(),
        "username": core_settings.user_name.text.toString(),
        "password": core_settings.password.text.toString(),
        "force_proxy": core_settings.force_proxy,
        "anonymous_mode": core_settings.anonymous_mode,
        "proxy_hostnames": core_settings.proxy_hostnames,
        "proxy_peer_connections": core_settings.proxy_peer_connections,
        "proxy_tracker_connections": core_settings.proxy_tracker_connections,
      },
      "cache_size": core_settings.cache_size.text.toString(),
      "cache_expiry": core_settings.cache_expiry.text.toString(),
    };
    Map<String, dynamic> requestPayload = {
      "method": "core.set_config",
      "params": [param],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      // cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> res = json.decode(responseBody);
      print(res);
    } catch (e) {
      print(e);
    }
  }

  //----------------------------------------
  static Future<Map<String, dynamic>> fetch_settings(
      List<Cookie> cookie,
      String url,
      String is_reverse_proxied,
      String seed_username,
      String seed_pass,
      String qr_auth) async {
    Map<String, dynamic> requestPayload = {
      "method": "core.get_config",
      "params": [],
      "id": network_request++
    };

    final httpclient = new HttpClient();
    try {
      final request = await httpclient.postUrl(Uri.parse(
          is_reverse_proxied == 'true' ? "$url/deluge/json" : "$url/json"));
      request.headers.contentType = new ContentType("application", "json");
      request.headers.add("Cookie", cookie);
      if (seed_username.length > 0 && seed_pass.length > 0) {
        String auth =
            'Basic ' + base64Encode(utf8.encode('$seed_username:$seed_pass'));
        request.headers.add('authorization', auth);
      }
      if (qr_auth.length > 0) {
        request.headers.add('X-QR-AUTH', qr_auth);
      }

      request.add(
        utf8.encode(
          jsonEncode(requestPayload),
        ),
      );

      final response = await request.close();

      // cookie = response.cookies;
      final responseBody = await response.transform(utf8.decoder).join();
      Map<String, dynamic> res = json.decode(responseBody);
      return res;
    } catch (e) {
      print(e);
    }
  }
  //----------------------------------------

}
