import 'dart:io';

import 'package:flutter/material.dart';
import 'package:playlister/config/routes/routes_config.dart';
import 'package:animated_check/animated_check.dart';

import '../../config/themes/colors.dart';
import '../../widgets/blur_gradient.dart';
import '../../widgets/buttons/filled_button.dart';
import '../../widgets/navigation/default_app_bar.dart';

class SuccessView extends StatefulWidget {
  final String playlistName;
  SuccessView({required this.playlistName, Key? key}) : super(key: key);

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView>
    with SingleTickerProviderStateMixin {
  late String _playlistName;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _playlistName = widget.playlistName;

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));

    sleep(const Duration(seconds: 2));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BlurGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: DefaultAppBar(
            title: 'Export Complete',
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 60, 15.0, 0),
            child: Column(
              children: [
                AnimatedCheck(
                  color: Color(0xFF20E95D),
                  progress: _animation,
                  size: 200,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0),
                ),
                Text(
                  "$_playlistName",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Exported Successfully!",
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1), fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.only(top: 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledElevatedButton(
                          callback: () async {
                            Navigator.pushNamed(context, HomeScreenRoute);
                          },
                          title: 'Return Home',
                          size: Size(250.0, 50),
                          fontSize: 20,
                          backgroundColor: OpaqueGray),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
