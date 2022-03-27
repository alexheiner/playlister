import 'package:flutter/material.dart';

class Transfer extends StatelessWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Transfer'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context, 'fromTransferScreen'),
              icon: Icon(Icons.arrow_back))),
      body: Center(child: Text('Transfer Screen')),
    );
  }
}
