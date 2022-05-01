import 'package:flutter/material.dart';

import '../models/navigation_data_model.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar(
      {Key? key,
      required this.items,
      required this.onItemSelected,
      required this.selectedIndex})
      : super(key: key);
  final List<NavigationData> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.85),
                borderRadius: BorderRadius.circular(22)),
            width: double.infinity,
            height: 58,
            margin: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    items.length,
                    (index) => GestureDetector(
                          onTap: () => onItemSelected(index),
                          child: _BuildItem(
                              isSelected: selectedIndex == index,
                              icon: items[index].icon,
                              iconColor: items[index].color),
                        )))));
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem(
      {Key? key,
      required this.isSelected,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  final bool isSelected;
  final IconData icon;
  final MaterialColor iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconTheme(
            data: IconThemeData(
                size: 32, color: isSelected ? iconColor : Colors.white54),
            child: Icon(icon)),
        Container(
          width: 26,
          height: 3,
          decoration: BoxDecoration(
              color: isSelected ? iconColor : Colors.transparent,
              borderRadius: BorderRadius.circular(25)),
        )
      ]),
    );
  }
}
