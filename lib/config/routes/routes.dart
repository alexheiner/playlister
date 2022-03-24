import 'package:flutter/material.dart';
import 'routes_config.dart';

import '/screens/discover/discover_screen.dart';
import '/screens/home/home_screen.dart';

Route<dynamic> generageRoutes(RouteSettings settings){
  switch(settings.name){
    case HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case DiscoverScreenRoute:
      return MaterialPageRoute(builder: (context) => Discover());
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}