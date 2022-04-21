import 'package:flutter/material.dart';

AppBar CustomAppBar(title) {
  return AppBar(
    shadowColor: Colors.black12,
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
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
