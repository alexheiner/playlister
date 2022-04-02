import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import './api_path.dart';
import '../models/playlist.dart';
import '../models/playlist_tracks.dart';
import '../utils/prefs.dart';
import 'token.dart';

class SpotifyApi {

  static Future<Playlist> getPlaylist(String playlistId) async {
    Token token = await getToken();
    playlistId = "2pEkQW3dSQyu1JNepjSNCX";
    Uri uri = Uri.parse(APIPath.getPlaylist(playlistId));
    final response = await http.get(uri, 
      headers: {'Authorization': 'Bearer ' + token.access_token}
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody);
      return Playlist.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to get a playlist with status code ${response.statusCode}');
    }
  }

  static Future<PlaylistTracks> getTracks(String playlistId) async {
    Token token = await getToken();

    // playlistId = "2pEkQW3dSQyu1JNepjSNCX";
    Uri uri = Uri.parse(APIPath.getTracks(playlistId));
    final response = await http.get(uri, 
      headers: {'Authorization': 'Bearer ' + token.access_token}
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      print(responseBody);
      return PlaylistTracks.fromJson(responseBody);
    } else {

      throw Exception(
          'Failed to get a playlist with status code ${response.statusCode}');
    }
  }
  
  static Future<Token> getClientCredentialsToken() async {
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
      Token token = Token.fromJson(responseBody);
      Prefs.setToken(token);
      return token;
    } else {
      throw Exception(
          'Failed to get client credentials with status code ${response.statusCode}');
    }
  }

  static Future<Token> getToken() async {
    // Token token = Prefs.getToken();
    Token token = await getClientCredentialsToken();
    // if(token.access_token == "" || token.isExpired()){
    //   Token token = await getClientCredentialsToken();
    //   Prefs.setToken(token);
    // }
    return token;
  }
}