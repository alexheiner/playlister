import 'package:flutter/material.dart';

class SpotifyProvider extends ChangeNotifier {
  String _accessToken = '';

  String get accessToken {
    return _accessToken;
  }

  void set accessToken(String tkn) {
    _accessToken = tkn;
    notifyListeners();
  }
}
