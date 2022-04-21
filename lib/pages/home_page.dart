import 'package:flutter/material.dart';

import '../configs/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar("Hi, Andres"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Category",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CategoryItem(
                          image: "",
                          onTap: () {},
                          title: "',
                        ),
                        // SizedBox(width: 10),
                        // CategoryItem(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        // CategoryItem(),
                        // SizedBox(width: 10),
                        // CategoryItem(),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Login With Google")),
            ],
          ),
        ));
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.image,
  }) : super(key: key);
  final String title;
  final GestureTapCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.red),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(child: Text("data"))),
    );
  }
}
