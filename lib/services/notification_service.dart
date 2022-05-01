import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void init(
      Future<dynamic> Function(int, String?, String?, String?)? onDidReceive) {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceive);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    initializeLocalNotificationsPlugin(initializationSettings);

    // tz.initializeTimeZones();
  }

  void initializeLocalNotificationsPlugin(
      InitializationSettings initializationSettings) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String? payload) async {}
  void showNotification(String notificationMessage) async {
    await flutterLocalNotificationsPlugin.show(
        123,
        "test",
        notificationMessage,
        const NotificationDetails(
            android: AndroidNotificationDetails("123", "test",
                channelDescription: 'To remind you about upcoming birthdays')),
        payload: jsonEncode('{"hello": "world"}'));
  }
}
