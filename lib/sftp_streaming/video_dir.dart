import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class media_stream extends StatefulWidget {
  final String file_name;
  final String selected_file;
  final Map<String, dynamic> headers;
  media_stream(
      {Key key,
      @required this.selected_file,
      @required this.file_name,
      @required this.headers})
      : super(key: key);
  @override
  _media_streamState createState() =>
      _media_streamState(selected_file: selected_file, file_name: file_name,
      headers: headers
      );
}

class _media_streamState extends State<media_stream> {
  final String file_name;
  final String selected_file;
  final Map<String, dynamic> headers;
  _media_streamState({this.selected_file, this.file_name,this.headers});
  BetterPlayerListVideoPlayerController controller;
  void initState() {
    super.initState();
    controller = BetterPlayerListVideoPlayerController();
    Future.delayed(Duration(seconds: 1), () {
      controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text(file_name)),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: BetterPlayerListVideoPlayer(
                BetterPlayerDataSource(
                    BetterPlayerDataSourceType.network,
                    // videoListData!.videoUrl,
                    selected_file,
                    // "https://fremicro045.xirvik.com/downloads/The%20WIRED%20CD%20-%20Rip.%20Sample.%20Mash.%20Share/01%20-%20Beastie%20Boys%20-%20Now%20Get%20Busy.mp3",
                    notificationConfiguration:
                        BetterPlayerNotificationConfiguration(
                            showNotification: true,
                            title: "Streaming on",
                            author: "Deluge mobile Client"),
                    headers: headers),

                configuration: BetterPlayerConfiguration(
                  autoPlay: false,
                  aspectRatio: 1,
                ),
                //key: Key(videoListData.hashCode.toString()),
                playFraction: 0.8,
                betterPlayerListVideoPlayerController: controller,
              ),
            ),
          ],
        )));
  }
}
