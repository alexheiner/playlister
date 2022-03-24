import 'package:flutter/material.dart';

import '/config/routes/routes_config.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, DiscoverScreenRoute),
          child: const Text('Discover') ,
          ),
      ),
    );
  }
}