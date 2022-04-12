import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../../config/themes/colors.dart';
import '../../../../models/applemusic/playlist.dart';
import '../../../../services/applemusic/ios_channel.dart';


class PlaylistCoverPhoto extends StatelessWidget {
  final String playlistImageUrl;
  final String playlistname;
  final String playlistOwner;
  final List<Track> tracks;
  IosChannel iosChannel = new IosChannel();

  PlaylistCoverPhoto(
    {required this.playlistImageUrl,
    required this.playlistname,
    required this.playlistOwner,
    required this.tracks});
    
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
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
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: ClipRRect(
                    
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      playlistImageUrl,
                      height: 300,
                      width: 300,
                    ),
                  )
                  ),
                ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(playlistname, style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
            Text(playlistOwner, style: TextStyle(color: AppleMusicPrimary, fontSize: 18)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    child: Text('Cancel', style: TextStyle(color: AppleMusicPrimary),),
                    onPressed: ()=> print('export'),
                    color: Color(0xff1a1a1c),
                  ),
                  CupertinoButton(
                    child: Text('Export', style: TextStyle(color: AppleMusicPrimary),),
                    onPressed: () async {
                      bool success = await iosChannel.exportPlaylistFromApple(playlistname, tracks);
                      print("Success: ${success}");
                    },
                    color: Color(0xff1a1a1c),
                  ),
                ],
              ),
            ),

          ],
        )
      ],
    );
  }
}

/**
 * 
 * https://music.apple.com/us/playlist/todays-hits/pl.f4d106fed2bd41149aaacabb233eb5eb
 * https://music.apple.com/us/playlist/help-me-sleep/pl.1c8b514172fa461089272f7f52babc0a
 * https://music.apple.com/us/playlist/carpool/pl.a41b57f4a28840ffb53dd5392e649ed1
 * https://music.apple.com/us/curator/apple-music-sleep/1558257257
 */