import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/spotify_api.dart';
import '../../../models/spotify/playlist.dart';
import '../../../models/spotify/track.dart';
import '../../../models/spotify/artist.dart';

class SpotifyUtils {
  
  static String _getArtists(List<Artist> artists){
    String artistsStr = "";
    artists.asMap().forEach((index, artist) => {
      index > 0 ? artistsStr += (", " + artist.name) : artistsStr += artist.name
    });
    return artistsStr;
  }

  Future<Playlist> getPlaylist(String playlistId) async {
    Playlist playlist = await SpotifyApi.getPlaylist(playlistId);
    // return _getPlaylistData(playlist);
    return playlist;
  }

  String formatNumber(int number){
    final value = new NumberFormat("#,##0", "en_US");
    return "${value.format(number)}";
  }

  Widget getTrackWidget(Track track, Function callback){
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
                        onPressed: ()=> callback(track.uri),
                        icon: Icon(Icons.close),
                        color: Color.fromARGB(255, 83, 83, 83),
                        iconSize: 26,
                      ),
                      Image.network(
                        track.albumImageUrl,
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
                          FittedBox(
                            child: Text(
                            track.name,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 220, 220, 220)),
                            ),
                          ),
                          Row(
                            children: [
                              if(track.explicit)
                                Icon(Icons.explicit_rounded, size: 15, color: Colors.grey,),
                              Text(
                                _getArtists(track.artists),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                            ],
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
