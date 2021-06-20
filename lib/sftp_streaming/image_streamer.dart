import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class img extends StatefulWidget {
  final String path;
  final Map<String,String> headers;
  img({Key key, @required this.path, @required this.headers}) : super(key: key);

  @override
  _imgState createState() => _imgState(path: path,
  headers: headers
  );
}

class _imgState extends State<img> {
  final String path;
  final Map<String,String> headers;
  _imgState({@required this.path,@required this.headers});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage(path,
          headers: headers)
    ));
  }
}
