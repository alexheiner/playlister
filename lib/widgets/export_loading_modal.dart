import 'package:flutter/material.dart';
import 'dart:ui';
import '../config/themes/colors.dart';

class ExportLoadingModal extends ModalRoute<void> {
  final String playlistName;
  final String exportToPlatform;
  ExportLoadingModal({
    required this.playlistName,
    required this.exportToPlatform
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;


  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    // This makes sure that text and other content follows the material style

    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context, playlistName, exportToPlatform),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, String playlistName, String exportToPlatform) {
    final Size screenSize = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, screenSize.height * .25, 15, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Text(
                  'Exporting ${playlistName} to your ${exportToPlatform} library',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30.0,),
                ),
              ),
              SizedBox(
                width: screenSize.width * .5,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: exportToPlatform == "Spotify" ? SpotifyGreen : AppleMusicPrimary,
                ),

              ),
              // ElevatedButton(onPressed: ()=> Navigator.pop(context), child: Text('back'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  void closeIndicator(context){
    
  }
}