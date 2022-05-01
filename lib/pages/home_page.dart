import 'package:MotivationApps/configs/app_router.gr.dart';
import 'package:MotivationApps/services/firebase_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../services/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationService _notificationService = NotificationService();
  late FirebaseMessaging messaging;
  String? notificationText;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      print(event.data.values);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Notification"),
              content: Text(event.notification!.body!),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    // getNotification();
  }

  void getNotification() async {
    _notificationService.init(_onDidReceiveLocalNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: TextButton(
          onPressed: () async {
            _notificationService.showNotification("hello");
            print(await FirebaseService().getToken());
          },
          child: Text("token"),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: FloatingActionButton(
          onPressed: () {
            context.router.push(const CategoryPageRoute());
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<dynamic> _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: Text(title ?? ''),
            content: Text(body ?? ''),
            actions: [TextButton(child: Text("Ok"), onPressed: () async {})]));
  }
}
