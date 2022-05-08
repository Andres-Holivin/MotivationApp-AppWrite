import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/app_router.gr.dart';
import '../models/user_scheduler_model.dart';
import '../services/appwrite_service.dart';
import '../services/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  }

  Future<List<UserSchedulerModel>>? userSchedulerModels = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: context.read<FirebaseService>().getToken(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
            Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                "Motivation Scheduler",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    userSchedulerModels =
                        context.read<AppWriteService>().getListScheduler();
                  },
                  child: Consumer<AppWriteService>(
                    builder: (BuildContext context, value, Widget? child) =>
                        FutureBuilder<List<UserSchedulerModel>>(
                      future: value.getListScheduler(),
                      builder: (context, snapshot) => ListView.builder(
                          itemCount: (snapshot.data?.length ?? 0) + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data?.length != index &&
                                snapshot.hasData) {
                              var item = snapshot.data?[index];
                              return ItemHome(userSchedulerModel: item);
                            } else {
                              return const SizedBox(
                                height: 74,
                              );
                            }
                          }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: FloatingActionButton(
          onPressed: () {
            context.router.push(const CategoryPageRoute());
          },
          child: const Icon(Icons.add),
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
                actions: [
                  TextButton(child: const Text("Ok"), onPressed: () async {})
                ]));
  }
}

class ItemHome extends StatefulWidget {
  const ItemHome({Key? key, required this.userSchedulerModel})
      : super(key: key);
  final UserSchedulerModel? userSchedulerModel;

  @override
  State<ItemHome> createState() => _ItemHomeState();
}

class _ItemHomeState extends State<ItemHome> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.memory(
                widget.userSchedulerModel?.categoryIcon ?? Uint8List(0),
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.userSchedulerModel?.categoryTitle ?? "error",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(widget.userSchedulerModel?.schedulerType ?? "error"),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  context
                      .read<AppWriteService>()
                      .deleteSchedule(widget.userSchedulerModel?.id ?? "");
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
            // Switch(
            //   value: widget.userSchedulerModel?.status ?? false,
            //   onChanged: (value) {
            //     setState(() {
            //       context.read<AppWriteService>().changeScheduleStatus(
            //           value, widget.userSchedulerModel?.id ?? "");
            //     });
            //   },
            //   activeTrackColor: Colors.lightGreenAccent,
            //   activeColor: Colors.green,
            // ),
          ],
        ),
      ),
    );
  }
}
