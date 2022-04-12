import 'package:flutter/material.dart';
import '../../../config/themes/colors.dart';
import 'widgets/spotify_playlist_view_skeleton.dart';
import './widgets/spotify_playlist_view_skeleton.dart';
import './widgets/playlist_list_view.dart';
import 'spotify_utils.dart';
import '../../../models/spotify/playlist.dart';
import '../widgets/playlist_back_arrow.dart';

class SpotifyPlaylistView extends StatefulWidget {
  final String playlistId;
  SpotifyPlaylistView({required this.playlistId, Key? key}) : super(key: key);

  @override
  State<SpotifyPlaylistView> createState() => _SpotifyPlaylistViewState();
}

class _SpotifyPlaylistViewState extends State<SpotifyPlaylistView> {
  late Future<Playlist> _playlist;
  bool colorNav = false;
  String playlistName = '';
  SpotifyUtils utils = new SpotifyUtils();
  @override
  void initState() {
    super.initState();
    _playlist = utils.getPlaylist(widget.playlistId);
  }

  void _setColorNav() {
    setState(() {
      colorNav = !colorNav;
    });
  }

  void _setPlaylistName(String name) {
    setState(() {
      playlistName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double playlistImageHeight = screenSize.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkBody,
        body: Stack(
          children: [
            FutureBuilder<Playlist>(
              future: _playlist,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return getShimmerContent(screenSize, playlistImageHeight);
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return PlaylistView(
                      playlist: snapshot.data,
                      callback: _setColorNav,
                      setName: _setPlaylistName);
                } else {
                  return Text('No data');
                }
              },
            ),
            PlaylistBackArrow(shouldClose: colorNav, playlistName: playlistName)
          ],
        ),
      ),
    );
  }
}
