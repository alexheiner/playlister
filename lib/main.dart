import 'package:flutter/material.dart';

import 'config/routes/routes.dart' as router;
import 'config/routes/routes_config.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playlister',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generageRoutes,
      initialRoute: HomeScreenRoute,
    );
  }
}