import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './api_path.dart';
import '../models/playlist.dart';
import 'dart:convert';

class SpotifyApi {

  static Future<Playlist> getPlaylist(String playlistId) async {
    final response = await http.get(Uri.parse(APIPath.getPlaylist(playlistId)));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final onwerResponse =
          await http.get(Uri.parse(APIPath.getUserById(responseBody['owner']['id'])));
      responseBody['owner'] = json.decode(onwerResponse.body);
      return Playlist.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to get a playlist with status code ${response.statusCode}');
    }
  }
}