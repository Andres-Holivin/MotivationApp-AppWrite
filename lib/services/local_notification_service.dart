import 'dart:math';

import 'package:MotivationApps/models/enum_scheduler_type.dart';
import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService extends ChangeNotifier {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  AndroidInitializationSettings? initializationSettingsAndroid;
  MacOSInitializationSettings? initializationSettingsMacOS;
  late var context;
  late var cron;
  InitializationSettings? initializationSettings;
  IOSInitializationSettings? initializationSettingsIOS;
  LocalNotificationService(c) {
    context = c;
    cron = Cron();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    initializationSettingsIOS = const IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: null);
    initializationSettingsMacOS = const MacOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    tz.initializeTimeZones();

    setInit();
  }
  void setInit() async {
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings!,
        onSelectNotification: selectNotification);
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
  }

  void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SecondScreen(payload),
              //   ),
              // );
            },
          )
        ],
      ),
    );
  }

  Future<void> scheduleNotification(
      // String userId, CategoryModel category, EnumSchedulerType type
      ) async {
    // var id = int.parse(DateFormat("yyyyMMddhhmmss").format(DateTime.now()));
    tz.initializeTimeZones();
    // print("line 91 " + category.toString());
    EnumSchedulerType type = EnumSchedulerType.Daily;
    flutterLocalNotificationsPlugin?.zonedSchedule(
        0,
        "hello",
        "hello",
        // category.title,
        // category.text[Random.secure().nextInt(category.text.length - 1)],
        tz.TZDateTime.now(tz.local).add(type == EnumSchedulerType.Daily
            ? const Duration(minutes: 1)
            : (type == EnumSchedulerType.Weekly
                ? const Duration(days: 7)
                : (type == EnumSchedulerType.Monthly
                    ? const Duration(days: 30)
                    : throw Exception("Unknown scheduler type")))),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> testNotification() async {
    flutterLocalNotificationsPlugin?.zonedSchedule(
        Random().nextInt(1000),
        "hello",
        "hello",
        // category.title,
        // category.text[Random.secure().nextInt(category.text.length - 1)],
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> sendNotification() async {
    // const AndroidNotificationDetails androidPlatformChannelSpecifics =
    //     AndroidNotificationDetails('your channel id', 'your channel name',
    //         channelDescription: 'your channel description',
    //         importance: Importance.max,
    //         priority: Priority.high,
    //         ticker: 'ticker');
    // const NotificationDetails platformChannelSpecifics =
    //     NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        ?.show(0, 'plain title', 'plain body', null, payload: 'item x');
  }
}
