import 'package:flutter/material.dart';
import '../../../../models/applemusic/playlist.dart';
import '../widgets/playlist_cover_photo.dart';
import './playlist_track.dart';

class PlaylistView extends StatefulWidget {
  final Playlist playlist;
  PlaylistView({required this.playlist, Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  late Playlist _playlist;
  late List<Track> _tracks;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _playlist = widget.playlist;
    setState(() {
      _tracks = _playlist.tracks.tracks;
    });
  }

  void _removeTrack(String id) {
    setState(() {
      _tracks.removeWhere((track) => track.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: _tracks.length + 1,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return PlaylistCoverPhoto(
                    playlistImageUrl: _playlist.attributes.artwork.url,
                    playlistOwner: _playlist.attributes.curatorName,
                    playlistName: _playlist.attributes.name,
                    tracks: _tracks,
                  );
                } else {
                  return PlaylistTrack(
                      track: _tracks[index - 1], callback: _removeTrack);
                }
              }),
        ),
      ],
    );
  }
}
