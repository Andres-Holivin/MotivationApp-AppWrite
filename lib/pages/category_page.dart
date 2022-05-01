import 'dart:typed_data';

import 'package:MotivationApps/services/appwrite_service.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: context.read<AppWriteService>().getCurrentUser(),
      builder: (BuildContext c, AsyncSnapshot<User?> snapshot) => Scaffold(
          appBar: AppBar(
            shadowColor: Colors.black12,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text('Category',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    SizedBox(height: 10),
                    Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                FutureBuilder<DocumentList?>(
                  future: context.read<AppWriteService>().getCategory(),
                  builder:
                      (BuildContext c, AsyncSnapshot<DocumentList?> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        childAspectRatio:
                            ((MediaQuery.of(context).size.width / 2) /
                                (MediaQuery.of(context).size.height * 0.25)),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: List.generate(
                          snapshot.data?.documents.length ?? 0,
                          (index) {
                            return InkWell(
                              onTap: () {},
                              child: CategoryItem(
                                title: snapshot
                                        .data?.documents[index].data['title'] ??
                                    'error',
                                onTap: () {},
                                image: snapshot.data?.documents[index]
                                        .data['file_id'] ??
                                    '',
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(),
              ],
            ),
          )),
    );
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
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: FutureBuilder<Uint8List>(
            future: context.read<AppWriteService>().getCategoryPicture(image),
            builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Container(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3), blurRadius: 10)
                      ],
                    ),
                    child: Column(children: [
                      Expanded(
                        flex: 9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            snapshot.data ?? Uint8List(0),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                      )
                    ]));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
