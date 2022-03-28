import 'package:flutter/material.dart';
import '/config/themes/colors.dart';

class DefaultAppBar extends StatefulWidget {
  final String title;
  final Function? callback;
  DefaultAppBar(
    {
      required this.title,
      this.callback,
      Key? key
    }) : super(key: key);

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
        ),
      ),
      leading: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: OpaqueGray,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 5),
          child: IconButton(
          onPressed: () {
            if(widget.callback != null){
              widget.callback!(context);
            }
            // default back button behavior
            else{
              Navigator.pop(context);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19,
          ),
          color: Colors.white,
          ),
        )
      ),
      backgroundColor: Colors.transparent,
    );
  }
}