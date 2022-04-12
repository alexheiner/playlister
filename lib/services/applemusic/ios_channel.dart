import 'package:flutter/services.dart';
import 'dart:convert';
import '../../models/applemusic/playlist.dart';
import '../../models/spotify/track.dart' as Spotify;
import '../../models/applemusic/apple_music_export_result.dart';

class IosChannel {
  static const platform = MethodChannel('playlister');

  Future<Playlist> getPlaylist(String playlistId) async {
    try{
      var send = <String, dynamic> {"playlistId": playlistId};
      final String res = await platform.invokeMethod('getPlaylist', send);
      Map<String, dynamic> map = json.decode(res);
      Playlist playlist = Playlist.fromJson(map);
      return playlist;
    } on PlatformException catch(_) {
      throw Exception('Error');
    }
    
  }
  Future<bool> exportPlaylistFromApple(String name, List<Track> tracks) async {
    try{
      var send = <String, dynamic> {"name": name, "tracks": json.encode(tracks)};
      var res = await platform.invokeMethod('exportPlaylistFromApple', send);
      if(res == "success"){
        print("success");
        return true;
      }
      return false;

    } on PlatformException catch(e) {
      print('!!error!! ' + e.message.toString());
      return false;
    }
    
  }
  Future<void> exportPlaylistFromSpotify(String name, List<Spotify.Track> tracks) async {
    try{
      var send = <String, dynamic> {"name": name, "tracks": json.encode(tracks)};
      var res = await platform.invokeMapMethod<String, dynamic>('exportPlaylistFromSpotify', send);
      if(res != null){
        AppleMusicExportResult result = AppleMusicExportResult.fromJson(res);
        print(result.message);
      }

    } on PlatformException catch(e) {
      print('!!error!! ' + e.message.toString());
      throw Exception('Error');
    }
    
  }


}