import 'package:deluge_client/components/licence.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:deluge_client/control_center/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:deluge_client/control_center/theme_controller.dart';

class about extends StatefulWidget {
  @override
  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About",
            style: theme.app_bar_style,
          ),
          centerTitle: true,
          backgroundColor: theme.base_color,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Flexible(
                    fit: FlexFit.tight, child: Image.asset("assets/poster.png"))
              ],
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: theme_controller.is_it_dark()?Colors.white:Colors.black, fontSize: 36),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Deluge mobile client is open-source project.',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: ' it is design and developed by ',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: 'Mohammad Arshad',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: theme.font_family)),
                  TextSpan(
                      text: ' during ',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: 'Google Summer Of Code 2021',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: theme.font_family)),
                  TextSpan(
                      text: ' ',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: ' Under ',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: 'CCExtractor Development ',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: theme.font_family)),
                  TextSpan(
                      text: 'Organization',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: ',',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: ' With guidance of ',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                  TextSpan(
                      text: 'Mr.Carlos Fernandez',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          fontFamily: theme.font_family)),
                  TextSpan(
                      text: '.',
                      style: TextStyle(
                          fontSize: 30.0, fontFamily: theme.font_family)),
                ],
              ),
              textScaleFactor: 0.5,
            ),
            //---------------------------------------------------

            Padding(
                padding: const EdgeInsets.all(30.0),
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: false,
                  ),
                  header: Container(
                    color: theme.base_color,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          ExpandableIcon(
                            theme: const ExpandableThemeData(
                              expandIcon: Icons.arrow_drop_down,
                              collapseIcon: Icons.arrow_drop_up,
                              iconColor: Colors.white,
                              iconSize: 28.0,
                              iconPadding: EdgeInsets.only(right: 5),
                              hasIcon: false,
                            ),
                          ),
                          Expanded(
                            child: Text("License",
                                style: TextStyle(
                                    fontFamily: theme.font_family,
                                    color: Colors.white,
                                    fontSize: 20.0)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  collapsed: Container(),
                  expanded: license(),
                )),

            //-------------------------------------------
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Container(
                    child: Column(
                  children: [
                    ListTile(
                      tileColor: theme.base_color,
                      title: Text(
                        "Join our community at slack",
                        style: theme.warning_style,
                      ),
                      leading: ImageIcon(
                        AssetImage("assets/slack.png"),
                        color: Colors.white,
                      ),
                      onTap: () {
                        launchInBrowser("https://rhccgsoc15.slack.com/");
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: ListTile(
                          tileColor: theme.base_color,
                          title: Text(
                            "Make some pull requests",
                            style: theme.warning_style,
                          ),
                          leading: ImageIcon(
                            AssetImage("assets/github.png"),
                            color: Colors.white,
                          ),
                          onTap: () {
                            launchInBrowser("https://github.com/CCExtractor/Deluge-mobile-remote-client");
                          },
                        )),
                  ],
                )))
          ],
        )));
  }
}
