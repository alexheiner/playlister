import 'package:flutter/material.dart';
import 'dart:async';
import '../../../models/applemusic/playlist.dart';
import '../../../config/themes/colors.dart';
import '../widgets/playlist_back_arrow.dart';
import './apple_music_utils.dart';
import '../widgets/playlist_shimmer_loading.dart';
import './widgets/playlist_list_view.dart';
class AppleMusicPlaylistView extends StatefulWidget {
  final String playlistId;
  AppleMusicPlaylistView({required this.playlistId, Key? key}) : super(key: key);

  @override
  State<AppleMusicPlaylistView> createState() => _AppleMusicPlaylistViewState();
}

class _AppleMusicPlaylistViewState extends State<AppleMusicPlaylistView> {
  late Future<Playlist> _playlist;
  String playlistName = '';
  AppleMusicUtils utils = new AppleMusicUtils();

  @override
  void initState() {
    super.initState();
    _playlist = utils.getPlaylist(widget.playlistId);
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double playlistImageHeight = screenSize.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkBody,
        body: Stack(
          children: [
            FutureBuilder < Playlist > (
              future: _playlist,
              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return getShimmerContent(screenSize, playlistImageHeight);
                }
                else if(snapshot.connectionState == ConnectionState.done) {
                  // return PlaylistView(playlist: snapshot.data, callback: _setColorNav, setName: _setPlaylistName);
                  return PlaylistView();
                }
                else if(snapshot.hasError){
                  return Text('Error getting playlist data');
                }
                else {
                  return Text('No data');
                }
              },
            ),
            PlaylistBackArrow(shouldClose: false, playlistName: playlistName)
          ],
        ),
      ),
    );
  }
}