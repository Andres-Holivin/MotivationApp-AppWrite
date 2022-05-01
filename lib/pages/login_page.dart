import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../configs/app_router.gr.dart';
import '../services/appwrite_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailTxt = TextEditingController();
    var passwordTxt = TextEditingController();
    final _formKey = GlobalKey<FormState>();
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (newValue) => emailTxt.text = newValue!,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        obscureText: true,
                        onSaved: (newValue) => passwordTxt.text = newValue!,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 22.0),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context
                                .read<AppWriteService>()
                                .login(emailTxt.text, passwordTxt.text)
                                .then((value) => value == true
                                    ? context.router.push(MasterPageRoute())
                                    : null);
                          }
                        },
                        child: const Text(
                          "Sing In",
                          style: TextStyle(color: Colors.blue),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )),
                    TextButton(
                        onPressed: () {
                          context.router.replace(const RegistrationPageRoute());
                        },
                        child: const Text(
                          "Sing Up",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                const Spacer(),
                const Text("Or, Login With",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                IconAuth(
                    icon: Ionicons.logo_github,
                    onTap: () {
                      context
                          .read<AppWriteService>()
                          .loginOauth2("github")
                          .then((value) => value
                              ? context.router.replace(const MasterPageRoute())
                              : "");
                      // : showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) =>
                      //         const CustomPopUp(
                      //           title: "Error",
                      //         )));
                    }),
                const SizedBox(height: 32),
              ],
            ),
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
