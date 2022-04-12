import 'package:flutter/material.dart';
import '../../../../models/applemusic/playlist.dart';

class PlaylistTrack extends StatelessWidget {
  final Track track;
  final Function callback;
  const PlaylistTrack({required this.track, required this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: const Color(0x202020), boxShadow: [
          BoxShadow(color: Color.fromARGB(255, 0, 0, 0).withAlpha(100), blurRadius: 10.0),
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      IconButton(
                        onPressed: ()=> callback(track.id),
                        icon: Icon(Icons.close),
                        color: Color.fromARGB(255, 83, 83, 83),
                        iconSize: 26,
                      ),
                      Image.network(
                        track.attributes.artwork.url,
                        height: 45,
                        width: 45,
                      )
                    ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                track.attributes.name,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w200),
                                ),
                              if(track.attributes.contentRating != "")
                                Icon(Icons.explicit_rounded, size: 15, color: Colors.grey,),
                              
                            ],
                          ),
                          FittedBox(
                            child: 
                            Text(
                                // _getArtists(track.artists),
                                track.attributes.artistName,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}