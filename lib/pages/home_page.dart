import 'package:flutter/material.dart';

import '../configs/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Home"),
      body: Center(
        child: Column(
          children: [Text("data")],
        ),
      ),
    );
  }
}
