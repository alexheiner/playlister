import 'package:flutter/material.dart';
import '../spotify_utils.dart';
import './playlist_cover_photo.dart';
import '../../../../models/playlist.dart';
import '../../../buttons/filled_button.dart';

class PlaylistView extends StatefulWidget {
  final Playlist playlist;
  final Function callback;
  final Function setName;

  const PlaylistView(
    {required this.playlist, 
    required this.callback,
    required this.setName,
    Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}


class _PlaylistViewState extends State<PlaylistView> {
  late Playlist _playlist;
  late Function _callback;
  late Function _setName;
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  @override
  void initState() {
    super.initState();
    _playlist = widget.playlist;
    _callback = widget.callback;
    _setName = widget.setName;
    controller.addListener(() {
      double value = controller.offset/119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 1;
      });
    _setName(_playlist.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double playlistImageHeight = screenSize.height*0.30;
    SpotifyUtils utils = new SpotifyUtils();
    return  Container(
      height: screenSize.height,
      child: Column(
        children: [
          //playlist image
          AnimatedOpacity(
            onEnd: () => _callback(),
            duration: const Duration(milliseconds: 300),
            opacity: closeTopContainer?0:1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: screenSize.width,
              alignment: Alignment.topCenter,
              height: closeTopContainer?0:playlistImageHeight,
              child: PlaylistCoverPhoto(playlistImageUrl: _playlist.playlistImageUrl)
            ),
          ),
          // playlist songs
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: widget.playlist.tracks.length + 1,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if(index == 0){
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
                              letterSpacing: 0.7
                            ),
                          ),
                        ),
                        Text(
                          _playlist.description,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13
                          ),
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                                  child: Text(
                                    _playlist.owner.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15
                                    ),
                                  ),
                                ),
                                if(_playlist.followers > 0)
                                  Text(
                                    '${utils.formatNumber(_playlist.followers)} followers',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13
                                    ),
                                  ),
                              ],
                            ),
                            FilledElevatedButton(
                              callback: () => print('export!'),
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
                }
                else {
                  // return widget.playlistContent.tracks[index - 1];
                  return utils.getTrackWidget(widget.playlist.tracks[index - 1]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}