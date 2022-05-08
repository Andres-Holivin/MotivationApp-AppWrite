import 'package:appwrite/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/app_router.gr.dart';
import '../services/appwrite_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    cekCurrentUser();
  }

  void cekCurrentUser() async {
    User? user = await context.read<AppWriteService>().getCurrentUser();
    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        context.router.replace(const MasterPageRoute());
      } else {
        context.router.replace(const LoginPageRoute());
      }
    });
  }

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
                  flex: 9,
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
                  flex: 1,
                  child: Column(
                    children: const [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
