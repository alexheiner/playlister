import 'package:flutter/services.dart';
import 'dart:convert';
import '../../../models/applemusic/playlist.dart';


class AppleMusicUtils {
  static const platform = MethodChannel('playlister');

    Future<Playlist> getPlaylist(String playlistId) async {
    try{
      var send = <String, dynamic> {"playlistId": "pl.u-9yJIaY8lE5"};
      final String res = await platform.invokeMethod('getPlaylist', send);
      Map<String, dynamic> map = json.decode(res);
      Playlist playlist = Playlist.fromJson(map);
      return playlist;
    } on PlatformException catch(_) {
      throw Exception('Error');
    }
    
  }
}