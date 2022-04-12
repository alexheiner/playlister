import 'artist.dart';

class Track{
  Track({
    required this.name,
    required this.id,
    required this.uri,
    required this.artists,
    required this.albumImageUrl,
    required this.durationMs,
    required this.explicit,
  });
  final String name;
  final String id;
  final String uri;
  final List<Artist> artists;
  final String albumImageUrl;
  final int durationMs;
  final bool explicit;

  factory Track.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final id = json['id'];
    final uri = json['uri'];

    final List<Artist> artists = (json['artists'] as List)
        .map((artist) => Artist.fromJson(artist))
        .toList();
        
    final images = json['album']['images'];
    final albumImageUrl = images.length > 1
        ? images[1]['url']
        : images.length > 0 ? images[0]['url'] : null;

    final durationMs = json['duration_ms'];
    final explicit = json['explicit'];
    return Track(
        name: name,
        id: id,
        uri: uri,
        artists: artists,
        albumImageUrl: albumImageUrl,
        durationMs: durationMs,
        explicit: explicit,
        );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['id'] = id ;
    _data['uri'] = uri ;
    _data['artists'] = artists.map((artist) => artist.toJson()).toList();
    _data['albumImageUrl'] = albumImageUrl;
    _data['durationMs'] = durationMs;
    _data['explicit'] = explicit;
    return _data;
  }

}