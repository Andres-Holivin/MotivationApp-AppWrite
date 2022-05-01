import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseService extends ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String _key =
      "AAAAR3qSCd8:APA91bEPpPmtsVXbmOR1cwrtMQRTTYkZIoNA65DRgp_SEAbzghRDTyRP3LlpFxhNls34OfBZfHpt6Ge48USCqIS6ZWMxBWNsmI0UzRoWYe6NCnzNF7KChDRCq91VjYZKrg33-eeU9RrB";
  late NotificationSettings _notification;
  FirebaseService() {
    setInit();
  }
  void setInit() async {
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
    return await messaging.getToken(vapidKey: _key);
  }

  Future<void> sendMessage() async {
    // Firebase.
    // Firebase..sendMessage(to: await getToken(),ttl: "hello",)
  }
//   NotificationSettings settings = await messaging.requestPermission(
//   alert: true,
//   announcement: false,
//   badge: true,
//   carPlay: false,
//   criticalAlert: false,
//   provisional: false,
//   sound: true,
// );
}
