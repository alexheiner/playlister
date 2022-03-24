import 'package:flutter/material.dart';

class Discover extends StatelessWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover'), 
        leading: IconButton(
            onPressed: ()=> Navigator.pop(context, 'fromDiscoverScreen'), 
            icon: Icon(Icons.arrow_back)
          )
      ),
      body: Center(
        child: Text('Discover Screen')
      ),
    );
  }
}