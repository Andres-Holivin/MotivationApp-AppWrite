import 'package:MotivationApps/services/appwrite_service.dart';
import 'package:MotivationApps/services/client_provider.dart';
import 'package:MotivationApps/services/firebase_service.dart';
import 'package:MotivationApps/services/local_notification_service.dart';
import 'package:appwrite/appwrite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'configs/app_router.gr.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future main() async {
  await dotenv.load(fileName: ".env.local");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

final _appRouter = AppRouter();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Client _client;
  @override
  void initState() {
    super.initState();
    getConfig();
  }

  void getConfig() async {
    _client = await clientProvider();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalNotificationService>(
            create: (context) => LocalNotificationService(
                  context,
                )),
        ChangeNotifierProvider<AppWriteService>(
            create: (context) => AppWriteService(_client)),
        ChangeNotifierProvider<FirebaseService>(
            create: (context) => FirebaseService()),
      ],
      child: MaterialApp.router(
        title: 'Motivation Apps',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        builder: (context, child) => child!,
      ),
    );
  }
}
