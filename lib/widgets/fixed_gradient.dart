import 'package:flutter/material.dart';
class FixedGradient extends StatelessWidget {
  final Widget child;
  
  static const List<Color> colorList = [
    Color(0xFF20E95D),
    Color(0xFF69A6F9),
    Color(0xFF7572FF),
    Color(0xFFFA57C1),
  ];

  static const List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  static const int index = 0;
  static const Color bottomColor = Color(0xFF20E95D);
  static const Color topColor = Color(0xFFFA57C1);
  static const Alignment begin = Alignment.bottomLeft;
  static const Alignment end = Alignment.topRight;

  const FixedGradient({required this.child});
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin, end: end, colors: [bottomColor, topColor])
        ),
        child: child,
      ),
    );
  }
}