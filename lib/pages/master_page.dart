import 'package:MotivationApps/components/custom_navigation_bar.dart';
import 'package:MotivationApps/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../components/custom_app_bar.dart';
import '../models/navigation_data_model.dart';
import 'list_page.dart';
import 'notification_page.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: _currentIndex == 0
              ? "Home"
              : _currentIndex == 1
                  ? "List"
                  : _currentIndex == 2
                      ? "Notification"
                      : ""),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        ItemPage(index: _currentIndex),
        ItemNavigationBar(
          index: _currentIndex,
          onItemSelected: (index) => setState(() => _currentIndex = index),
        ),
      ]),
    );
  }
}

class ItemNavigationBar extends StatelessWidget {
  const ItemNavigationBar(
      {Key? key, required this.index, required this.onItemSelected})
      : super(key: key);
  final int index;

  final ValueChanged<int> onItemSelected;
  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      selectedIndex: index,
      onItemSelected: onItemSelected,
      items: [
        NavigationData(icon: Ionicons.grid_outline, color: Colors.blue),
        NavigationData(
          icon: Ionicons.reader_outline,
          color: Colors.green,
        ),
        NavigationData(
          icon: Ionicons.notifications_outline,
          color: Colors.yellow,
        )
      ],
    );
  }
}

class ItemPage extends StatelessWidget {
  const ItemPage({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: const [HomePage(), ListPage(), NotificationPage()],
    );
  }
}
