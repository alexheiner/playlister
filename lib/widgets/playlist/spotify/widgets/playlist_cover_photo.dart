import 'package:flutter/material.dart';

class PlaylistCoverPhoto extends StatelessWidget {
  final String playlistImageUrl;
  PlaylistCoverPhoto({required this.playlistImageUrl});
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(color: Colors.white),
            child: Image.network(
              playlistImageUrl,
              height: 300,
              width: 300,
            )
            ),
          ),
      ),
    );
  }
}