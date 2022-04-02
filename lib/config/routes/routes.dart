import 'package:flutter/material.dart';
import 'package:playlister/screens/manage/spotify_login_screen.dart';
import '../../screens/transfer/transfer_main.dart';
import 'routes_config.dart';

import '/screens/discover/discover_screen.dart';
import '/screens/manage/manage_screen.dart';
import '/screens/manage/spotify_login_screen.dart';
import '/screens/home/home_screen.dart';

Route<dynamic> generageRoutes(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case DiscoverScreenRoute:
      return MaterialPageRoute(builder: (context) => Discover());
    case ManageScreenRoute:
      return MaterialPageRoute(builder: (context) => Manage());
    case TransferScreenRoute:
      return MaterialPageRoute(builder: (context) => Transfer());
    case SpotifyLoginScreenRoute:
      return MaterialPageRoute(builder: (context) => SpotifyLogin());
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}
