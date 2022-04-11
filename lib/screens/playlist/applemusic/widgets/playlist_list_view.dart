import 'package:flutter/material.dart';

class PlaylistView extends StatefulWidget {
  PlaylistView({Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('here!', style: TextStyle(color: Colors.pink),),);
  }
}