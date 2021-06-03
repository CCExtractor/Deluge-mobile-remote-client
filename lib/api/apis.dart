import 'dart:convert';
import 'dart:io';



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
}
