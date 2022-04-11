import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/spotify_provider.dart';
import '../spotify_utils.dart';
import './playlist_cover_photo.dart';
import '../../../../models/spotify/playlist.dart';
import '../../../../models/spotify/track.dart';
import '../../../../widgets/buttons/filled_button.dart';

class PlaylistView extends StatefulWidget {
  final Playlist playlist;
  final Function callback;
  final Function setName;

  const PlaylistView(
      {required this.playlist,
      required this.callback,
      required this.setName,
      Key? key})
      : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  late Playlist _playlist;
  late List<Track> _tracks;
  late Function _callback;
  late Function _setName;
  ScrollController controller = ScrollController();
  SpotifyUtils utils = new SpotifyUtils();
  bool closeTopContainer = false;
  double topContainer = 0;
  @override
  void initState() {
    super.initState();
    _playlist = widget.playlist;
    _callback = widget.callback;
    _setName = widget.setName;
    setState(() {
      _tracks = _playlist.tracks;
    });
    controller.addListener(() {
      double value = controller.offset / 119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 1;
      });
      _setName(_playlist.name);
    });
  }

  void _export() async {
    final List<String> ids = _tracks.map((t) => t.uri).toList();
    print(ids.toString());
    final res =
        utils.createAndFillPlaylist(_playlist.name, ids, _playlist.owner.id);
  }

  void _removeTrack(String uri) {
    setState(() {
      _tracks.removeWhere((element) => element.uri == uri);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double playlistImageHeight = screenSize.height * 0.30;
    SpotifyUtils utils = new SpotifyUtils();
    return Container(
      height: screenSize.height,
      child: Column(
        children: [
          //playlist image
          AnimatedOpacity(
            onEnd: () => _callback(),
            duration: const Duration(milliseconds: 300),
            opacity: closeTopContainer ? 0 : 1,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: screenSize.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : playlistImageHeight,
                child: PlaylistCoverPhoto(
                    playlistImageUrl: _playlist.playlistImageUrl)),
          ),
          // playlist songs
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: _tracks.length + 1,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            _playlist.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.7),
                          ),
                        ),
                        Text(
                          _playlist.description,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 0),
                                  child: Text(
                                    _playlist.owner.name,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                if (_playlist.followers > 0)
                                  Text(
                                    '${utils.formatNumber(_playlist.followers)} followers',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                              ],
                            ),
                            FilledElevatedButton(
                              callback: () => _export(),
                              title: 'Export',
                              size: Size(95, 25),
                              icon: Icons.import_export,
                              iconSize: 17,
                              fontSize: 12,
                              backgroundColor: Color.fromARGB(255, 29, 185, 84),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  // return widget.playlistContent.tracks[index - 1];
                  return utils.getTrackWidget(_tracks[index - 1], _removeTrack);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
