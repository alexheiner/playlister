import './user.dart';
import './track.dart';

class Playlist {
  Playlist(
      {required this.name,
      required this.description,
      required this.followers,
      required this.id,
      required this.isPublic,
      required this.playlistImageUrl,
      required this.numOfTracks,
      required this.externalUrl,
      required this.owner,
      required this.tracks});
  final String name;
  final String description;
  final int followers;
  final String id;
  final String externalUrl;
  final User owner;
  final bool isPublic;
  final int numOfTracks;
  final String playlistImageUrl;
  final List<Track> tracks;

  factory Playlist.fromJson(Map<String, dynamic> json) {
    // if (json == null) return null;
    final name = json['name'];
    final description = json['description'];
    final followers = json['followers']['total'];
    final id = json['id'];
    final externalUrl = json['external_urls']['spotify'];
    final isPublic = json['public'];
    final playlistImageUrl = json['images'].length != 0 ? json['images'][0]['url'] : null;
    final numOfTracks = json['tracks']['total'];
    List items = json['tracks']['items'];
    final tracks = items.map((item) => Track.fromJson(item['track'])).toList();
    final owner = User.fromJson(json['owner']);
    return Playlist(
        name: name,
        description: description,
        followers: followers,
        id: id,
        externalUrl: externalUrl,
        isPublic: isPublic,
        playlistImageUrl: playlistImageUrl,
        numOfTracks: numOfTracks,
        owner: owner,
        tracks: tracks);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'id': id,
        'external_url': externalUrl,
        'is_public': isPublic,
        'playlist_image_url': playlistImageUrl,
        'num_of_tracks': numOfTracks,
        'owner': owner.toJson(),
      };
}