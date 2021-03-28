import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deluge_client/api_manager.dart';
import 'package:deluge_client/controlpanel.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:requests/requests.dart';

void main(List<String> args) {
  runApp(demo());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class demo extends StatefulWidget {
  @override
  _demoState createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Deluge 's client demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: view(),
    );
  }
}

class view extends StatefulWidget {
  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {
  double speed = 0.0;
  Future<ThinClient> torrent;
  List<Cookie> cookie = null;
  //https://github.com/dart-lang/http/issues/184
  Map<String, dynamic> payload = {
    "id": 1,
    "method": "auth.login",
    "params": ["deluge"]
  };

  void authentication_to_deluge() async {
    final httpclient = new HttpClient();
    final request =
        await httpclient.postUrl(Uri.parse("http://192.168.43.197:8112/json"));
    request.headers.contentType = new ContentType("application", "json");

    request.add(
      utf8.encode(
        jsonEncode(payload),
      ),
    );

    final response = await request.close();
    // print(response.cookies);
    cookie = response.cookies;
    final responseBody = await response.transform(utf8.decoder).join();
    // print(responseBody);
    // print(jsonDecode(responseBody));
    // final result = Model.fromJson(json.decode(responseBody));
  }

  Map<String, dynamic> requestPayload = {
    "method": "core.get_torrents_status",
    "params": [[], []],
    "id": 2
  };

  Future<ThinClient> get_torrent_list() async {
    final httpclient = new HttpClient();
    //try {
    final request =
        await httpclient.postUrl(Uri.parse("http://192.168.43.197:8112/json"));
    request.headers.contentType = new ContentType("application", "json");
    request.headers.add("Cookie", cookie);

    request.add(
      utf8.encode(
        jsonEncode(requestPayload),
      ),
    );

    final response = await request.close();
    // print(response.cookies);
    cookie = response.cookies;
    final responseBody = await response.transform(utf8.decoder).join();
    //print(responseBody);
    // print(jsonDecode(responseBody));
    final ThinClient output = thinClientFromJson(responseBody);
    // print(responseBody);
    return output;
    // } catch (e) {
    //   return new ThinClient();
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    // authentication_to_deluge();
    authentication_to_deluge();

    torrent_list();

    super.initState();
  }

  void torrent_list() {
    // --it was for delaying function
    Future.delayed(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          torrent = get_torrent_list();

          // setting state for ui changes realtime
        });
      }
    });
    //------------------------------------->>
    // it will keep checking and checking the status
    // Timer.periodic(Duration(seconds: 2), (timer) {
    //   setState(() {
    //     torrent = get_torrent_list();
    //   });
    // });

    /*
    refresh torr.. function first get the list of torrent at initial phase and it
    will keep getting latest torrent status inorder to get to know about the realtime changes
    such as downloading status
    */
  }

  //---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: ClipPath(
                clipper: CustomAppBar(),
                child: Container(
                  color: Color.fromRGBO(66, 85, 112, 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 26.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Deluge',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                  TextSpan(
                                      text: '\n\t\t\t\t\t\t\t\t\tRemote Client',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      )),
                                ])),

                            //title row
                          ],
                        ),
                        Flexible(
                            fit: FlexFit.tight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.add_to_queue),
                                    color: Colors.white,
                                    tooltip: "Add new",
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("ok");
                                    }),
                                IconButton(
                                    icon: Icon(Icons.delete_forever_sharp),
                                    tooltip: "Delete",
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("ok");
                                    }),
                                IconButton(
                                    icon: Icon(Icons.pause_outlined),
                                    tooltip: "pause all",
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("ok");
                                    }),
                                IconButton(
                                    tooltip: "start all",
                                    icon: Icon(Icons.play_arrow_rounded),
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("ok");
                                    }),
                                IconButton(
                                    icon: Icon(Icons.settings),
                                    tooltip: "Setting",
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("ok");
                                    }),
                                //----------------speed meter
                                IconButton(
                                    icon: Icon(Icons.speed_sharp),
                                    tooltip: "Speed checker",
                                    color: Colors.white,
                                    iconSize: 30.0,
                                    onPressed: () {
                                      print("ok");
                                    }),
                                Text(
                                  "$speed MB/S",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                )),
            preferredSize: Size.fromHeight(kToolbarHeight + 150)),
        body: FutureBuilder<ThinClient>(
            future: torrent,
            builder:
                (BuildContext context, AsyncSnapshot<ThinClient> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                //------------
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ));
              } else {
                return RefreshIndicator(
                    onRefresh: () async {
                      await torrent_list();
                    },
                    child: ListView.builder(
                        // where snapshot data means here is torrent=snapshot.data
                        itemCount: snapshot.data.result.length,
                        itemBuilder: (context, index) {
                          Map<String, Result> res_torrent = new Map();
                          res_torrent = snapshot.data.result;
                          // it is the key that is basically idententity of list
                          String key = res_torrent.keys.elementAt(index);

                          //inside the result array
                          Result inside_res = res_torrent[key];
                          bool paused = inside_res.paused;
                          bool completed = inside_res.isFinished;
                          // we will be returning row and col
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      inside_res.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              //2nd row
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Size: " +
                                          (inside_res.totalSize ~/ 1000000)
                                              .toString() +
                                          " MB",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: !completed
                                          ? paused
                                              ? Icon(Icons.pause)
                                              : Icon(
                                                  Icons.account_tree_outlined)
                                          : Icon(Icons.download_done_outlined),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_downward_sharp),
                                          Text(
                                            inside_res.maxDownloadSpeed
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Icon(Icons.arrow_upward),
                                          Text(
                                              inside_res.maxUploadSpeed
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //----------
                              //download info
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    download_progress(
                                      torrent_id: key,
                                      cookie: cookie,
                                      tor_name: inside_res.name,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromRGBO(66, 85, 112, 1),
                                height: 10.0,
                                thickness: 5.0,
                              )
                            ],
                          );
                        }));
                //p---
              }
              //---

              //----
            }));
  } //------------

}

class download_progress extends StatefulWidget {
  final String torrent_id;
  final List<Cookie> cookie;
  final String tor_name;
  const download_progress(
      {Key key, @required this.torrent_id, this.cookie, this.tor_name})
      : super(key: key);

  @override
  _download_progressState createState() =>
      _download_progressState(torrent_id, cookie, tor_name);
}

class _download_progressState extends State<download_progress> {
  String tor_id;
  String tor_name;
  List<Cookie> cookie;
  _download_progressState(this.tor_id, this.cookie, this.tor_name);
  double progress_percent = 0;
  //-----------------
  void get_status() async {
    var param = new List();
    param.add(tor_id);
    Map<String, dynamic> requestPayload = {
      "id": 3,
      "method": "web.get_torrent_files",
      "params": param
    };

    final httpclient = new HttpClient();
    //try {
    final request =
        await httpclient.postUrl(Uri.parse("http://192.168.43.197:8112/json"));
    request.headers.contentType = new ContentType("application", "json");
    request.headers.add("Cookie", cookie);

    request.add(
      utf8.encode(
        jsonEncode(requestPayload),
      ),
    );

    final response = await request.close();

    cookie = response.cookies;
    final responseBody = await response.transform(utf8.decoder).join();
    Map<String, dynamic> api_output = json.decode(responseBody);
    Map<String, dynamic> result = api_output['result'];
    Map<String, dynamic> content = result['contents'];
    Map<String, dynamic> torrent_info = content[tor_name];
    String middletemp = torrent_info['progress'].toString().substring(0, 4);
    double temp = double.parse(middletemp).toDouble();

    setState(() {
      progress_percent = temp;
    });

    // print(progress_percent);
    // } catch (e) {
    //   return new ThinClient();
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (this.mounted) {
        setState(() {
          get_status();
        });
      }
    });

    super.initState();
  }

//Text(tor_id == null ? "" : tor_id);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(15.0),
      child: new LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2000,
        percent: progress_percent,
        center: Text(
          (progress_percent * 100).roundToDouble().toString(),
          style: TextStyle(color: Colors.white),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Color.fromRGBO(66, 85, 112, 1),
      ),
    ));
  }
}

//----------------------------------------------------
