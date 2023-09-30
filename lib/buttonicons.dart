import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final background;
  final String button;
  final text, clicked;

  Buttons(
      {required this.background,
      required this.text,
      required this.button,
      required this.clicked});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clicked,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 1,
            width: 1,
            color: background,
            child: Center(
              child: Text(
                button,
                style: TextStyle(color: text, fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
