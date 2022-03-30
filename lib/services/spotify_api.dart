import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import './api_path.dart';
import '../models/playlist.dart';

class SpotifyApi {

  static Future<Playlist> getPlaylist(String playlistId) async {
    playlistId = "2pEkQW3dSQyu1JNepjSNCX";
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
  static Future<void> getClientCredentialsToken() async {
    String clientID = dotenv.env['CLIENT_ID'].toString();
    String secret = dotenv.env['SECRET'].toString();
    String credentials = clientID + ":" + secret;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);  
    print(encoded);
    final response = await http.post(Uri.parse(APIPath.requestToken), 
    headers: {'Authorization': 'Basic ' + encoded},
    body: {"grant_type": "client_credentials"}

    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody);
    } else {
      throw Exception(
          'Failed to get client credentials with status code ${response.statusCode}');
    }
  }
}