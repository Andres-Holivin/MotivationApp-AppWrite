import 'package:MotivationApps/models/category_model.dart';
import 'package:MotivationApps/models/enum_scheduler_type.dart';
import 'package:MotivationApps/services/appwrite_service.dart';
import 'package:MotivationApps/services/firebase_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddSchedulerDetailPage extends StatefulWidget {
  const AddSchedulerDetailPage({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);
  final CategoryModel categoryModel;

  @override
  State<AddSchedulerDetailPage> createState() => _AddSchedulerDetailPageState();
}

class _AddSchedulerDetailPageState extends State<AddSchedulerDetailPage> {
  EnumSchedulerType valueDropdown = EnumSchedulerType.values.first;
  Future<bool> createNotification(categoryId, type) async {
    String? deviceToken = await context.read<FirebaseService>().getToken();
    context
        .read<AppWriteService>()
        .createScheduler(deviceToken!, categoryId, type)
        .then((value) {
      if (value != null) {
        print(value.toString());
      } else {
        print("error");
      }
    }).catchError((e) => print(e));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black12,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text("Details",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Image.memory(widget.categoryModel.file,
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          TitleIcon(categoryModel: widget.categoryModel),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Remind me in every",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              DropdownButton<EnumSchedulerType>(
                                  value: valueDropdown,
                                  items: EnumSchedulerType.values.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e
                                          .toString()
                                          .split('.')[1]
                                          .toUpperCase()),
                                    );
                                  }).toList(),
                                  onChanged: (EnumSchedulerType? e) {
                                    setState(() {
                                      valueDropdown = e!;
                                    });
                                  }),
                            ],
                          ),
                          const SizedBox(height: 32),
                          TextButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              onPressed: () {
                                createNotification(
                                        widget.categoryModel.categoryId,
                                        valueDropdown)
                                    .then((value) {
                                  value
                                      ? context.router.pop()
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                  title: const Text('Error'),
                                                  content: const Text(
                                                      "Something went wrong"),
                                                  actions: [
                                                    TextButton(
                                                        child:
                                                            const Text("Close"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ]));
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 10),
                                child: Text(
                                  "Create Notification",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}

class TitleIcon extends StatelessWidget {
  const TitleIcon({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.memory(
            categoryModel.icon,
            height: 72,
            width: 72,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          categoryModel.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
