import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';

class error extends StatefulWidget {
  final VoidCallback retry;
  error({Key key, @required this.retry}) : super(key: key);
  @override
  _errorState createState() => _errorState(retry: retry);
}

class _errorState extends State<error> {
  final VoidCallback retry;
  _errorState({Key key, @required this.retry});

  @override
  Widget build(BuildContext context) {
    return 
   Expanded(child:
     SingleChildScrollView(
      
       
       child:
    Column(
      children: [
        
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Image.asset(
                "assets/server_end_error.png",
                height: 300.0,
                width: 300.0,
              ),
            )
          ],
        ),
        Padding(
            padding: EdgeInsets.all(13.0),
            child: Container(
                child: Column(
              children: [
                Text(
                  "Deluge is not responding.",
                  style: TextStyle(
                      fontFamily: theme.font_family,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: theme.base_color,
                  thickness: 4.0,
                  indent: 55.0,
                  endIndent: 55.0,
                ),
              ],
            ))),
        Row(
          children: [
            Icon(Icons.insights_outlined),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                        "If you have just installed deluge at your remote location, you might need to log in on the web ui once.",
                        style: TextStyle(fontFamily: theme.font_family))))
          ],
        ),
        Row(
          children: [
            Icon(Icons.insights_outlined),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text("Deluge might be down.",
                        style: TextStyle(fontFamily: theme.font_family))))
          ],
        ),
        Row(
          children: [
            Icon(Icons.insights_outlined),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                        "Deluge is taking time to respond might be some internal problem.",
                        style: TextStyle(fontFamily: theme.font_family))))
          ],
        ),
        Row(
          children: [
            Icon(Icons.insights_outlined),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                        "It might also possible that Deluge is working but it is taking time to respond, As solution you can retry.",
                        style: TextStyle(fontFamily: theme.font_family))))
          ],
        ),
        RaisedButton(
          elevation: 5.0,
          onPressed: () {
            retry();
          },
          color: Colors.red,
          child: Text("Retry", style: TextStyle(fontFamily: theme.font_family,color: Colors.white)),
        )
      ],
    )));
  }
}
