import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void init() {
    //-------------------
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings);
  }

  static Future<void> notification_on_progress(
      String id,
      int identity_container,
      String progress_channel,
      String title,
      String msg,
      int percent) async {
    await Future<void>.delayed(const Duration(seconds: 1), () async {
      final AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
              id, progress_channel, 'progress channel description',
              channelShowBadge: false,
              importance: Importance.max,
              priority: Priority.high,
              onlyAlertOnce: true,
              showProgress: true,
              ongoing: true,
              maxProgress: 100,
              progress: percent);
      final NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          identity_container, title, msg, platformChannelSpecifics);
    });
  }

  //---------------------------------------------------------------

  //----------------------------------------------------------
  static List<String> store_ids = List<String>();
  static int fetch_noti_id(String hash) {
    return store_ids.indexOf(hash);
  }
}
