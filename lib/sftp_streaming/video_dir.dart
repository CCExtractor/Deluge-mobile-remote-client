import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:flutter/services.dart';

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
     List<DeviceOrientation> orientations=[DeviceOrientation.portraitUp];
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      
  ]);
    controller = BetterPlayerListVideoPlayerController();
    Future.delayed(Duration(seconds: 1), () {
      controller.play();
    });
  }
  @override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text(file_name),
          backgroundColor: theme.base_color,
        ),
        body:  Column(
         
         
          children: [Expanded(
            flex: 10,
            child:
               BetterPlayerListVideoPlayer(
                BetterPlayerDataSource(
                    BetterPlayerDataSourceType.network,
                    // videoListData!.videoUrl,
                    selected_file,
                  
                    notificationConfiguration:
                        BetterPlayerNotificationConfiguration(
                            showNotification: true,
                            title: "Streaming on",
                            author:file_name.toString()),
                    headers: headers),

                configuration: BetterPlayerConfiguration(
                  autoPlay: false,
                  deviceOrientationsAfterFullScreen: orientations
                  
             
                ),
                //key: Key(videoListData.hashCode.toString()),
                playFraction: 0.8,
                betterPlayerListVideoPlayerController: controller,
                
              )),
            
          ],
        ));
  }
}
