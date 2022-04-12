import 'package:flutter/material.dart';
import '../../utils/utils.dart';
import 'applemusic/applemusic_playlist_view.dart';
import 'spotify/spotify_playlist_view.dart';

class PlaylistView extends StatefulWidget {
  final String playlistLink;
  PlaylistView({required this.playlistLink, Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  late String playlistId = "";
  late String platform = "";
  late String errorMsg = "";
  @override
  void initState() {
    try {
      Map<String, String> playlistInfo = parsePlaylistLink(widget.playlistLink);
      setState(() {
        playlistId = playlistInfo['id'].toString();
        platform = playlistInfo['platform'].toString();
      });
    } on Exception catch (_) {
      setState(() {
        errorMsg = "Invalid playlist Link";
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (platform == "Spotify")
      return SpotifyPlaylistView(playlistId: playlistId);
    if (platform == "AppleMusic")
      return AppleMusicPlaylistView(playlistId: playlistId);
    return Text(errorMsg);
  }
}
