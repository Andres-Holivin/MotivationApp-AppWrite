import 'package:MotivationApps/configs/app_router.gr.dart';
import 'package:MotivationApps/pages/home_page.dart';
import 'package:MotivationApps/services/appwrite.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../components/custom_pop_up.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.lightBlueAccent,
            Colors.blueAccent,
            Colors.blueAccent,
            Colors.lightBlueAccent,
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_transparent.png",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                      )
                    ],
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Login With",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconAuth(
                              icon: Ionicons.logo_google,
                              onTap: () {
                                OauthGoogle();
                                context.router.replace(const HomePageRoute());
                              }),
                          SizedBox(width: 20),
                          IconAuth(
                              icon: Ionicons.logo_github,
                              onTap: () {
                                OauthGithub();
                                context.router.replace(const HomePageRoute());
                              }),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class IconAuth extends StatelessWidget {
  const IconAuth({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: IconButton(
        color: Colors.white,
        splashColor: Colors.black12,
        splashRadius: 20,
        onPressed: onTap,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
