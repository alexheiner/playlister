import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:playlister/models/spotify/track.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import '../models/applemusic/playlist.dart' as Apple;
import './api_path.dart';
import '../models/spotify/playlist.dart';
import '../models/spotify/token.dart';

class SpotifyApi {
  static Future<Playlist> getPlaylist(String playlistId) async {
    Token token = await getClientCredentialsToken();
    Uri uri = Uri.parse(APIPath.getPlaylist(playlistId));
    final response = await http
        .get(uri, headers: {'Authorization': 'Bearer ' + token.access_token});

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return Playlist.fromJson(responseBody);
    } else {
      throw Exception(
          'Failed to get a playlist with status code ${response.statusCode}');
    }
  }

  static Future<List<Track>> findSongByNameAndArtist(
      List<Apple.Track> tracks) async {
    List<Track> spotifyTracks = [];
    List<String> uris = [];
    
    tracks.forEach((t) {
      String name = t.attributes.name;
      int ind = name.indexOf("(");
      if(ind != -1){
        name = name.substring(0, ind);
      }
      String s = 'https://api.spotify.com/v1/search?q=track:${name} artist:${t.attributes.artistName}&type=track&market=US&limit=1';
      uris.add(s);
    });

    Token token = await getClientCredentialsToken();

    for(String u in uris) {
      Uri uri = Uri.parse(u);
      final res = await http
          .get(uri, headers: {'Authorization': 'Bearer ' + token.access_token});

      if (res.statusCode != 200) {
        throw Exception(
            'Failed to fetch user data with status code ${res.statusCode}, uri: $u, Message: ${res.body}');
      }

      final userInfoBody = json.decode(res.body);
      final Track? track = Track.fromJson(userInfoBody["tracks"]["items"][0]);

      if (track != null) spotifyTracks.add(track);
    }
    return spotifyTracks;
  }



  static Future<String> createAndFillPlaylist(
      String playlistName, List<String> songUris) async {
    // access token
    String userToken = await getUserAccessToken();

    // get user info
    Uri userInfoUri = Uri.parse(APIPath.getCurrentUser);
    Response userInfoRes = await http
        .get(userInfoUri, headers: {'Authorization': 'Bearer ' + userToken});

    if (userInfoRes.statusCode != 200) {
      throw Exception(
          'Failed to fetch user data with status code ${userInfoRes.statusCode}. Message: ${userInfoRes.body}');
    }

    final userInfoBody = json.decode(userInfoRes.body);
    final String userId = userInfoBody["id"];

    // Make playlist
    Uri createUri = Uri.parse(APIPath.createPlaylist(userId));

    Response createPlaylistRes = await http.post(createUri,
        headers: {'Authorization': 'Bearer ' + userToken},
        body: json.encode({"name": playlistName}));

    if (createPlaylistRes.statusCode != 201) {
      throw Exception(
          'Failed to create a playlist with status code ${createPlaylistRes.statusCode}. Message: ${createPlaylistRes.body}');
    }

    // Add songs to newly created playlist
    final createPlaylistBody = json.decode(createPlaylistRes.body);

    final String playlistUrl = createPlaylistBody["external_urls"]['spotify'];
    final String playlistId = createPlaylistBody["id"];

    Uri addSongsUri = Uri.parse(APIPath.addSongsToPlaylist(playlistId));
    final addSongsPostBody = json.encode({"uris": songUris});

    final addSongsRes = await http.post(addSongsUri,
        headers: {'Authorization': 'Bearer ' + userToken},
        body: addSongsPostBody);

    if (addSongsRes.statusCode != 201) {
      throw Exception(
          'Failed to add songs to a playlist with status code ${addSongsRes.statusCode}. Message: ${addSongsRes.body}');
    }
    // final addSongsResBody = json.decode(addSongsRes.body);

    // Return the snapshot ID of the updated playlist
    // return addSongsResBody["snapshot_id"];
    return playlistUrl;
  }

  static Future<String> getUserAccessToken() async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      return authenticationToken;
    } on PlatformException catch (e) {
      print("${e.code}, message: ${e.message}");
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      print('not implemented');
      return Future.error('not implemented');
    }
  }

  static Future<Token> getClientCredentialsToken() async {
    String clientID = dotenv.env['CLIENT_ID'].toString();
    String secret = dotenv.env['SECRET'].toString();
    String credentials = clientID + ":" + secret;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);
    print(encoded);
    final response = await http.post(Uri.parse(APIPath.requestToken), headers: {
      'Authorization': 'Basic ' + encoded
    }, body: {
      "grant_type": "client_credentials",
      "scopes": "playlist-modify-public,playlist-modify-private"
    });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      Token token = Token.fromJson(responseBody);
      return token;
    } else {
      throw Exception(
          'Failed to get client credentials with status code ${response.statusCode}');
    }
  }
}
