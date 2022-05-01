import 'package:MotivationApps/configs/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/appwrite_service.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameTxt = TextEditingController();
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
                        onSaved: (newValue) => nameTxt.text = newValue!,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
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
                                .regist(emailTxt.text, passwordTxt.text,
                                    nameTxt.text)
                                .then((value) => value == true
                                    ? context.router
                                        .push(const LoginPageRoute())
                                    : null);
                          }
                        },
                        child: const Text(
                          "Sing Up",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        )),
                    TextButton(
                        onPressed: () {
                          context.router.replace(const LoginPageRoute());
                        },
                        child: const Text(
                          "Sing In",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
