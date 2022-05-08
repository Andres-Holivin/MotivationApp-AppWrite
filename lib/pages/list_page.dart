import 'dart:typed_data';

import 'package:MotivationApps/models/category_model.dart';
import 'package:MotivationApps/services/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel?>>(
        future: context.read<AppWriteService>().getCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data!.length != index
                            ? ListItem(
                                categoryModel: snapshot.data?[index],
                              )
                            : const SizedBox(
                                height: 74,
                              );
                      }),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    required this.categoryModel,
  }) : super(key: key);
  final CategoryModel? categoryModel;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool _show = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, left: 18, right: 18),
      child: Card(
        color: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: _show == true
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                    : BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
              child: Column(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.categoryModel?.file != null
                        ? Image.memory(
                            widget.categoryModel?.file ?? Uint8List(0),
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          )
                        : const CircularProgressIndicator()),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: widget.categoryModel?.icon != null
                          ? Image.memory(
                              widget.categoryModel!.icon,
                              width: 44,
                              fit: BoxFit.fill,
                            )
                          : const CircularProgressIndicator(),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      widget.categoryModel?.title ?? "error",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _show = !_show;
                        });
                      },
                      icon: _show == false
                          ? const Icon(Icons.expand_more)
                          : const Icon(Icons.expand_less),
                    )
                  ],
                ),
              ]),
            ),
            if (_show == true)
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Colors.grey[200],
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.categoryModel!.text.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = widget.categoryModel?.text[index];
                        return Text(item.toString());
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )),
              )
          ],
        ),
      ),
    );
  }
}
