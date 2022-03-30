import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import '../../config/routes/routes_config.dart';
import '../../provider/spotify_provider.dart';
import '../../widgets/animated_gradient.dart';
import '../../widgets/navigation/default_app_bar.dart';

class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  final Logger _logger = Logger(
    //filter: CustomLogFilter(), // custom logfilter can be used to have logs in release mode
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: DefaultAppBar(
            title: 'Transfer', 
          ),
        ),
      body: AnimatedGradient(
          child: SafeArea(child:// Figma Flutter Generator ManageWidget - FRAME
              Container(
                  width: 390,
                  height: 844,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 100,
                        left: 100,
                        child: Text(
                          'Link your accounts',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              letterSpacing: 0.10000000149011612,
                              fontWeight: FontWeight.normal,
                              height: 1.25),
                        )),
                    Positioned(
                        top: 200,
                        left: 100,
                        width: 175,
                        child: GestureDetector(
                            onTap: () async {
                              String token = await getAccessToken(context);
                              context.read<SpotifyProvider>().accessToken =
                                  token;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(100),
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                                color: Color.fromRGBO(
                                    51, 51, 51, 0.800000011920929),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.spotify,
                                      size: 20, color: Color(0xFF20E95D)),
                                  SizedBox(width: 8),
                                  Text(
                                    'Spotify',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        letterSpacing: 0.10000000149011612,
                                        fontWeight: FontWeight.normal,
                                        height: 1.4285714285714286),
                                  ),
                                  SizedBox(width: 8),
                                  if (context
                                          .watch<SpotifyProvider>()
                                          .accessToken !=
                                      "")
                                    Icon(FontAwesomeIcons.check,
                                        size: 20, color: Color(0xFF20E95D))
                                ],
                              ),
                            ))),
                    Positioned(
                        top: 275,
                        left: 100,
                        width: 175,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, SpotifyLoginScreenRoute);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(100),
                                  topRight: Radius.circular(100),
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                                color: Color.fromRGBO(
                                    51, 51, 51, 0.800000011920929),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.apple,
                                      size: 20, color: Color(0xFFffffff)),
                                  SizedBox(width: 8),
                                  Text(
                                    'Apple Music',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        letterSpacing: 0.10000000149011612,
                                        fontWeight: FontWeight.normal,
                                        height: 1.4285714285714286),
                                  ),
                                  SizedBox(width: 8),
                                  // Icon(FontAwesomeIcons.check,
                                  //     size: 20, color: Color(0xFF20E95D))
                                ],
                              ),
                            ))),
                  ]))),
    ));
  }

  Future<String> getAccessToken(context) async {
    try {
      var authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: dotenv.env['CLIENT_ID'].toString(),
          redirectUrl: dotenv.env['REDIRECT_URL'].toString(),
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      setStatus('Got a token: $authenticationToken');
      return authenticationToken;
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      setStatus('not implemented');
      return Future.error('not implemented');
    }
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    _logger.i('$code$text');
  }
}
