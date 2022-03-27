import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/animated_gradient.dart';
import '/config/routes/routes_config.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator HomepageWidget - FRAME
    return AnimatedGradient(
        child: Stack(children: <Widget>[
      Positioned(
          top: 130,
          left: 117,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TransferScreenRoute);
              },
              child: Container(
                  width: 150,
                  height: 150,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ))),
                    Positioned(
                        top: 30,
                        left: 38,
                        child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            child: Stack(children: <Widget>[
                              Positioned.fill(
                                top: 0,
                                left: 0,
                                child: Icon(FontAwesomeIcons.music,
                                    size: 75, color: Color(0xFFF333333)),
                              ),
                            ]))),
                    Positioned.fill(
                        top: 112,
                        left: 0,
                        child: Text(
                          'Transfer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(51, 51, 51, 1),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.10000000149011612,
                              fontWeight: FontWeight.normal,
                              height: 1.1111111111111112),
                        )),
                  ])))),
      Positioned(
          top: 318,
          left: 117,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DiscoverScreenRoute);
              },
              child: Container(
                  width: 151,
                  height: 150,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color:
                                  Color.fromRGBO(51, 51, 51, 0.800000011920929),
                            ))),
                    Positioned.fill(
                        top: 114,
                        left: 1,
                        child: Text(
                          'EXPLORE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              letterSpacing: 0.10000000149011612,
                              fontWeight: FontWeight.normal,
                              height: 1.1111111111111112),
                        )),
                    Positioned(
                        top: 24,
                        left: 33,
                        child: Container(
                            width: 84,
                            height: 84,
                            child: Stack(children: <Widget>[
                              Positioned.fill(
                                top: 0,
                                left: 0,
                                child: Icon(FontAwesomeIcons.compass,
                                    size: 75,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ]))),
                  ])))),
      // Figma Flutter Generator ButtonWidget - COMPONENT
      Positioned(
          top: 508,
          left: 117,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ManageScreenRoute);
              },
              child: Container(
                width: 151,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100),
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                  color: Color.fromRGBO(51, 51, 51, 0.800000011920929),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.user,
                        size: 15, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text(
                      'Manage',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          letterSpacing: 0.10000000149011612,
                          fontWeight: FontWeight.normal,
                          height: 1.4285714285714286),
                    ),
                  ],
                ),
              ))),
    ]));
  }
}
