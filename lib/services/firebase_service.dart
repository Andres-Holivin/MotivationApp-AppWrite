import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FirebaseService extends ChangeNotifier {
  FirebaseMessaging? messaging = null;
  String _key = "";
  late NotificationSettings _notification;

  FirebaseService() {
    setInit();
    print("call firebase service");
  }
  void setInit() async {
    print("call init state");
    messaging = FirebaseMessaging.instance;
    _key = await dotenv.get('FIREBASE_CLOUD_MESSEGING_KEY');
    _notification = (await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    ));
  }

  Future<String?> getToken() async {
    return await messaging?.getToken(vapidKey: _key);
  }

  Future<void> registerNotification() async {
    getToken().then((value) async {
      print(value);
      try {
        http
            .post(Uri.parse('https://api.rnfirebase.io/messaging/send'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode({
                  'token': value,
                  'data': {
                    'via': 'FlutterFire Cloud Messaging!!!',
                    'count': '1',
                  },
                  'notification': {
                    'title': 'Hello FlutterFire!',
                    'body': 'This notification (#1) was created via FCM!',
                  },
                }))
            .then((value) => print("line 56 " + value.body.toString()))
            .catchError((error) => print(error.toString()));
      } catch (e) {
        print("line 44" + e.toString());
      }
    });
  }
}
