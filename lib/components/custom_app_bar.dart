import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/app_router.gr.dart';
import '../services/appwrite_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: Colors.black12,
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Consumer(
            builder: (BuildContext c, value, Widget? child) => PopupMenuButton(
                offset: const Offset(0, 55),
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 40,
                ),
                itemBuilder: (c) => [
                      PopupMenuItem(
                        onTap: () {
                          // c.read<LocalNotificationService>().sendNotification();
                          c.read<AppWriteService>().logOut().then(
                              (_) => c.router.replace(const SplashPageRoute()));
                        },
                        child: Row(children: const [
                          Icon(Icons.exit_to_app, color: Colors.black),
                          SizedBox(width: 10),
                          Text("Logout"),
                        ]),
                      ),
                    ]),
          ),
        )
      ],
      backgroundColor: Colors.white,
    );
  }
}
