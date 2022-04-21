import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class CustomPopUp extends StatefulWidget {
  const CustomPopUp({Key? key}) : super(key: key);

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RotationTransition(
              turns: _animation,
              child: const Icon(
                FontAwesome.gear,
                size: 48,
                color: Colors.blue,
              )),
          const SizedBox(height: 15),
          const Text(
            "Loading...",
            style: TextStyle(fontSize: 28),
          )
        ]),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
