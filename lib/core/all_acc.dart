import 'dart:io';

import 'package:deluge_client/database/dbmanager.dart';
import 'package:deluge_client/api/apis.dart';
import 'package:flutter/widgets.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

class all_account_core {
  static final DbbucketManager db = new DbbucketManager();

  static Map<String, dynamic> all_account_cookie = Map<String, dynamic>();
  static Future<Map<String, dynamic>> config_cache(BuildContext context) async {
    List<Bucket> acc = await db.getbucketitem();
    for (int i = 0; i < acc.length; i++) {
      apis
          .authentication_to_deluge(
              acc[i].deluge_url,
              acc[i].deluge_pwrd,
              acc[i].has_deluge_pwrd,
              acc[i].is_reverse_proxied,
              acc[i].username,
              acc[i].password,
              acc[i].via_qr,
              context)
          .then((List<Cookie> t) => {
                print(t),
                if (t != null)
                  {
                    // print(all_account_cookie.runtimeType),
                    all_account_cookie.putIfAbsent(acc[i].deluge_url, () => t),
                  }
              });
    }

    return all_account_cookie;
  }

  static String error_account = "";

  static Map<multtorrent, Properties> output = Map<multtorrent, Properties>();
  static Future<Map<multtorrent, Properties>> config_torrent_list(
      Map<String, dynamic> cookies, BuildContext context) async {
    List<Bucket> acc = await db.getbucketitem();
    // @todo i need to add that already logged in account can not logged in to make unique
    print("before it have :" + output.length.toString());
    print("its content is:" + output.toString());
    if (output.length > 0) {
      output.clear();
    }
    for (int i = 0; i < acc.length; i++) {
      List<Cookie> cke = cookies[acc[i].deluge_url];

      Map<String, Properties> t = await apis.get_torrent_list(
          cke,
          acc[i].deluge_url,
          acc[i].is_reverse_proxied,
          acc[i].username,
          acc[i].password,
          acc[i].via_qr,
          context);

      print(t);
      if (t == null) {
        error_account = acc[i].deluge_url.toString();
      }
      // todo i will add url with the hash of map
      for (int j = 0; j < t.length; j++) {
        String hash = t.keys.elementAt(j);
        Properties cont = t[hash];
        output.putIfAbsent(multtorrent(hash: hash, need: acc[i]), () => cont);
      }
    }

    return output;
  }
}

class multtorrent {
  String hash;
  Bucket need;
  multtorrent({this.hash, this.need});
}
