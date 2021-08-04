import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'dart:math';
import 'package:deluge_client/control_center/theme.dart';
import 'package:intl/intl.dart';
import 'package:charcode/charcode.dart';
import 'package:deluge_client/control_center/theme_controller.dart';
import 'package:deluge_client/api/models/torrent_prop.dart';

class more_info extends StatelessWidget {
  final Properties inside_res;
  final bool paused;
  more_info({Key key, @required this.inside_res,this.paused}) : super(key: key);

  final format = new DateFormat('dd-MM-yyyy hh:mm a');
  final eta = new DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildList() {
      return Column(
        children: <Widget>[
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "ETA",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              !paused?
                (inside_res.eta~/60)
                  .toString()+":"+(inside_res.eta%60).toString():"_:_",
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Save path",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              inside_res.savePath,
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Is shared?",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              inside_res.shared.toString(),
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Is Private?",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              inside_res.private.toString(),
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Total peers",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              inside_res.numPeers.toString(),
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Total seeds",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              inside_res.numSeeds.toString(),
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            title: Text(
              "Date and time added",
              style: TextStyle(fontSize: 12.0, fontFamily: theme.font_family),
            ),
            subtitle: Text(
              format
                  .format(DateTime.fromMillisecondsSinceEpoch(
                      inside_res.timeAdded * 1000))
                  .toString(),
              style: TextStyle(fontSize: 14.0, fontFamily: theme.font_family),
            ),
          ),
        ],
      );
    }

    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: false,
          ),
          header: ExpandableIcon(
            theme: const ExpandableThemeData(
              expandIcon: Icons.arrow_drop_down,
              collapseIcon: Icons.arrow_drop_up,
              iconColor: Colors.black,
              iconSize: 20.0,
              iconPadding: EdgeInsets.only(right: 5),
              hasIcon: false,
            ),
          ),
          collapsed: Container(),
          expanded: buildList(),
        ),
      ),
    );
  }
}
//------------------------------------
