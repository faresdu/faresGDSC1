import 'package:flutter/material.dart';

class HierarchyButton extends StatelessWidget {
  final void Function() onPressed;
  final String name;

  const HierarchyButton({Key? key, required this.onPressed, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // <-- Radius
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Color(0xFF212A40)),
        onPressed: onPressed,
        child: Center(
          child:
              Text(name, style: TextStyle(fontSize: 28, color: Colors.white)),
        ),
      ),
    );
  }
}
