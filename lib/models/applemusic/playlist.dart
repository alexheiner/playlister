class Playlist {
  Playlist({
    required this.id,
    required this.type,
    required this.href,
    required this.attributes,
    required this.tracks,
  });
  late final String id;
  late final String type;
  late final String href;
  late final Attributes attributes;
  late final Tracks tracks;
  
  Playlist.fromJson(Map<String, dynamic> json){
    json.forEach((key, value) {
      id = value[0]['id'];
      type = value[0]['type'];
      href = value[0]['href'];
      attributes = Attributes.fromJson(value[0]['attributes']);
      tracks = Tracks.fromJson(value[0]['relationships']['tracks']);
    });
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['href'] = href;
    _data['attributes'] = attributes.toJson();
    _data['relationships']['tracks'] = tracks.toJson();
    return _data;
  }
}

class Attributes {
  Attributes({
    required this.playlistType,
    required this.isChart,
    required this.curatorName,
    required this.lastModifiedDate,
    required this.url,
    required this.artwork,
    required this.name,
  });
  late final String playlistType;
  late final bool isChart;
  late final String curatorName;
  late final String lastModifiedDate;
  late final String url;
  late final Artwork artwork;
  late final String name;
  
  Attributes.fromJson(Map<String, dynamic> json){
    playlistType = json['playlistType'];
    isChart = json['isChart'];
    curatorName = json['curatorName'];
    lastModifiedDate = json['lastModifiedDate'];
    url = json['url'];
    artwork = Artwork.fromJson(json['artwork']);
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['playlistType'] = playlistType;
    _data['isChart'] = isChart;
    _data['curatorName'] = curatorName;
    _data['lastModifiedDate'] = lastModifiedDate;
    _data['url'] = url;
    _data['artwork'] = artwork.toJson();
    _data['name'] = name;
    return _data;
  }
}

class Artwork {
  Artwork({
    required this.width,
    required this.height,
    required this.url,
  });
  late final int width;
  late final int height;
  late final String url;
  
  Artwork.fromJson(Map<String, dynamic> json){
    width = json['width'];
    height = json['height'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['width'] = width;
    _data['height'] = height;
    _data['url'] = url;
    return _data;
  }
}

class Tracks {
  Tracks({
    required this.href,
    required this.tracks,
  });
  late final String href;
  late final List<Track> tracks;
  
  Tracks.fromJson(Map<String, dynamic> json){
    href = json['href'];
    tracks = List.from(json['data']).map((e)=>Track.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['href'] = href;
    _data['data'] = tracks.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Track {
  Track({
    required this.id,
    required this.type,
    required this.href,
    required this.attributes,
  });
  late final String id;
  late final String type;
  late final String href;
  late final TrackAttributes attributes;
  
  Track.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    href = json['href'];
    attributes = TrackAttributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['type'] = type;
    _data['href'] = href;
    _data['attributes'] = attributes.toJson();
    return _data;
  }
}

class TrackAttributes {
  TrackAttributes({
    required this.artwork,
    required this.artistName,
    required this.url,
    required this.discNumber,
    required this.genreNames,
    required this.durationInMillis,
    required this.releaseDate,
    required this.name,
    required this.isrc,
    required this.hasLyrics,
    required this.albumName,
    required this.trackNumber,
    required this.composerName,
    required this.contentRating,
  });
  late final Artwork artwork;
  late final String artistName;
  late final String url;
  late final int discNumber;
  late final List<String> genreNames;
  late final int durationInMillis;
  late final String releaseDate;
  late final String name;
  late final String isrc;
  late final bool hasLyrics;
  late final String albumName;
  late final int trackNumber;
  late final String composerName;
  late final String contentRating;
  
  TrackAttributes.fromJson(Map<String, dynamic> json){
    artwork = Artwork.fromJson(json['artwork']);
    artistName = json['artistName'];
    url = json['url'];
    discNumber = json['discNumber'];
    genreNames = List.castFrom<dynamic, String>(json['genreNames']);
    durationInMillis = json['durationInMillis'];
    releaseDate = json['releaseDate'];
    name = json['name'];
    isrc = json['isrc'];
    hasLyrics = json['hasLyrics'];
    albumName = json['albumName'];
    trackNumber = json['trackNumber'];
    composerName = json['composerName'];
    contentRating = json.containsKey('contentRating') ? json['contentRating'] : "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['artwork'] = artwork.toJson();
    _data['artistName'] = artistName;
    _data['url'] = url;
    _data['discNumber'] = discNumber;
    _data['genreNames'] = genreNames;
    _data['durationInMillis'] = durationInMillis;
    _data['releaseDate'] = releaseDate;
    _data['name'] = name;
    _data['isrc'] = isrc;
    _data['hasLyrics'] = hasLyrics;
    _data['albumName'] = albumName;
    _data['trackNumber'] = trackNumber;
    _data['composerName'] = composerName;
    _data['contentRating'] = contentRating;
    return _data;
  }
}