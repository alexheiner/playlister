import 'package:flutter/material.dart';

class Manage extends StatelessWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Manage'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context, 'fromManageScreen'),
              icon: Icon(Icons.arrow_back))),
      body: Center(child: Text('Manage Screen')),
    );
  }
}
