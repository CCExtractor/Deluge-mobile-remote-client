import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';

class error extends StatefulWidget {
  final VoidCallback retry;
  final String account_name;
  error({Key key, @required this.retry, this.account_name})
      : super(key: key);
  @override
  _errorState createState() =>
      _errorState(retry: retry, account_name: account_name);
}

class _errorState extends State<error> {
  final VoidCallback retry;
  final String account_name;
  _errorState({Key key, @required this.retry,this.account_name});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
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
                account_name!=null?
                  Text(
                  account_name,
                  style: TextStyle(
                      fontFamily: theme.font_family,
                    ),
                ):new Container(height: 0.0,width: 0.0,),
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
                        "If you have just installed deluge at your remote location, you may need to log in on the web ui once.",
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
                    child: Text("Deluge may be down.",
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
                        "Deluge is taking time to respond, May be some internal problem.",
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
                        "It may also possible that Deluge is working but it is taking time to respond.",
                        style: TextStyle(fontFamily: theme.font_family))))
          ],
        ),
        RaisedButton(
          elevation: 5.0,
          onPressed: () {
            retry();
          },
          color: Colors.red,
          child: Text("Retry",
              style: TextStyle(
                  fontFamily: theme.font_family, color: Colors.white)),
        )
      ],
    )));
  }
}
