import 'package:flutter/material.dart';

class AppleMusicPlaylistView extends StatefulWidget {
  final String playlistId;
  AppleMusicPlaylistView({required this.playlistId, Key? key}) : super(key: key);

  @override
  State<AppleMusicPlaylistView> createState() => _AppleMusicPlaylistViewState();
}

class _AppleMusicPlaylistViewState extends State<AppleMusicPlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apple music playlist view'),
      ),
    );
  }
}