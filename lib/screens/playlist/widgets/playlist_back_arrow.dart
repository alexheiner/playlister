import 'package:flutter/material.dart';
import 'dart:ui';

class PlaylistBackArrow extends StatelessWidget {
  late bool shouldClose = false;
  final playlistName;
  PlaylistBackArrow({required this.shouldClose, required this.playlistName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final Size screenSize = MediaQuery.of(context).size;
    return Positioned(
              left: 0.0,
              top: 0.0,
              child: ClipRect(
                child: Container(
                  height: 50,
                  width: screenSize.width,
                  alignment: Alignment.centerLeft,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: shouldClose?  3.0 : 0,
                      sigmaY: shouldClose?  3.0 : 0,
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white,),
                          onPressed: ()=> Navigator.pop(context),
                        ),
                        if(shouldClose)
                          Center(child: Text(playlistName, style: TextStyle(color: Colors.white, fontSize: 18),)),
                      ],
                    ),
                  ),
                  color: shouldClose ? Color.fromARGB(193, 20, 20, 20) : Colors.transparent,
                ),
              ),
            );
  }
}