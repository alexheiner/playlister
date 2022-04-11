import 'package:flutter/material.dart';
import '../../../config/themes/colors.dart';
import 'widgets/spotify_playlist_view_skeleton.dart';
import './widgets/spotify_playlist_view_skeleton.dart';
import './widgets/playlist_list_view.dart';
import 'spotify_utils.dart';
import '../../../models/spotify/playlist.dart';
import 'dart:ui';

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
            Positioned(
              left: 0.0,
              top: 0.0,
              child: ClipRect(
                child: Container(
                  height: 50,
                  width: screenSize.width,
                  alignment: Alignment.centerLeft,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: colorNav ? 3.0 : 0,
                      sigmaY: colorNav ? 3.0 : 0,
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        if (colorNav)
                          Center(
                              child: Text(
                            playlistName,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                      ],
                    ),
                  ),
                  color: colorNav
                      ? Color.fromARGB(193, 20, 20, 20)
                      : Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
