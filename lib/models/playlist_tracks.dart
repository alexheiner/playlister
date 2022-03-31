import './user.dart';
import 'track.dart';

class PlaylistTracks {
  PlaylistTracks(
      // {required this.limit,
      {required this.total,
      // required this.offset,
      // required this.next,
      // required this.previous,
      required this.tracks});
      // final int limit;
      final int total;
      // final int offset;
      // final String next;
      // final String previous;
      final List<Track> tracks;

  factory PlaylistTracks.fromJson(Map<String, dynamic> json) {
    // if (json == null) return null;
    // final limit = json['limit'];
    final total = json['total'];
    // final offset = json['offset'];
    // final next = json['next'];
    // final previous = json['previous'];
    List items = json['items'];
    final tracks = items.map((item) => Track.fromJson(item['track'])).toList();
    return PlaylistTracks(
      // limit: limit,
      total: total,
      // offset: offset,
      // next: next,
      // previous: previous,
      tracks: tracks
    );
  }

  Map<String, dynamic> toJson() => {
      // "limit": limit,
      "total": total,
      // "offset": offset,
      // "next": next,
      // "previous": previous,
      "tracks": tracks
      };
}