
enum Platform {
  AppleMusic,
  Spotify
}

Map<String, String> parsePlaylistLink(String link) {
  String id = "";
  String platform = "";
  if(link.contains('spotify')){
    List<String> splitLink = link.split('/');
    id = splitLink.last.split('?')[0];
    platform = "Spotify";
  }
  else if(link.contains('apple')) {
    id = 'apple';
    platform = "AppleMusic";
    print('apple');
  }
  Map<String, String> playlistInfo = {
    "id": id,
    "platform": platform,
  };
  print("map " + playlistInfo.toString());
  return playlistInfo;
}

String getSongDuration(String milliseconds) {
  Duration duration = new Duration(milliseconds: int.parse(milliseconds));
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  if (duration.inHours > 0)
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  else
    return "$twoDigitMinutes:$twoDigitSeconds";
}