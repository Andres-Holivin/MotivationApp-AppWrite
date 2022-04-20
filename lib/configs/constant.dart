import 'package:flutter/material.dart';

AppBar CustomAppBar(title) {
  return AppBar(
    shadowColor: Colors.black26,
    title: Text(
      title,
      style: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: IconButton(
          icon: const Icon(
            Icons.account_circle,
            color: Colors.black,
            size: 36,
          ),
          onPressed: () {},
        ),
      )
    ],
    backgroundColor: Colors.white,
  );
}
