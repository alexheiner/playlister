import 'package:flutter/material.dart';
class FilledElevatedButton  extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final Size size;
  final double fontSize;
  final Color backgroundColor;
  const FilledElevatedButton (
    {
      required this.callback,
      required this.title,
      required this.size,
      required this.fontSize,
      required this.backgroundColor,
      Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        // might want to add elevation
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )
        ),
        fixedSize: MaterialStateProperty.all<Size>(size),
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      ),
      onPressed: callback,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
      )
    );
  }
}