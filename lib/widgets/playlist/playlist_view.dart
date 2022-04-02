import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import './applemusic_playlist_view.dart';
import './spotify_playlist_view.dart';

class PlaylistView extends StatefulWidget {
  final String playlistLink;
  PlaylistView({required this.playlistLink, Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  late String playlistId;
  late String platform;
  @override
  void initState() {
    Map<String, String> playlistInfo = parsePlaylistLink(widget.playlistLink);
    setState(() {
      playlistId = playlistInfo['id'].toString();
      platform = playlistInfo['platform'].toString();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return platform == "Spotify" ? 
      SpotifyPlaylistView(playlistId: playlistId) :
      AppleMusicPlaylistView(playlistId: playlistId);
  }
}