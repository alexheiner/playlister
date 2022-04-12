import 'package:flutter/material.dart';

class AppleMusicProvider extends ChangeNotifier {
  String _accessToken = '';

  String get accessToken {
    return _accessToken;
  }

  void set accessToken(String tkn) {
    _accessToken = tkn;
    notifyListeners();
  }
}

// https://music.apple.com/us/playlist/top-25-new-york-city/pl.a88b5c26caea48a59484370b6f79c9df