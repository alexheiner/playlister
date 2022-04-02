
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