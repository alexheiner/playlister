import 'package:flutter/material.dart';

class OutlineElevatedButton  extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final Size size;
  final double fontSize;
  final Color fontColor;
  final Color borderColor;
  final Color backgroundColor;
  const OutlineElevatedButton (
    {
      required this.callback,
      required this.title,
      required this.size,
      required this.fontSize, 
      required this.fontColor,
      required this.borderColor,
      required this.backgroundColor,
      Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        // not sure if elevation would make sense or not
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: borderColor)
          )
        ),
        fixedSize: MaterialStateProperty.all(size),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      onPressed: callback,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: fontColor
          ),
        ),
      )
    );
  }
}