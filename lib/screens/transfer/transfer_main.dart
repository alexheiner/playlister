import 'package:flutter/material.dart';
import 'package:playlister/config/themes/colors.dart';
import '../../widgets/buttons/filled_button.dart';
import '../../widgets/navigation/default_app_bar.dart';
import '../../widgets/text_input.dart';
import '../../widgets/buttons/outline_button.dart';
import '../../widgets/blur_gradient.dart';
import '../../config/routes/routes_config.dart';
import '../../widgets/playlist/playlist_view.dart';
class Transfer extends StatefulWidget {
  Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final inputController = TextEditingController();

  @override
  void initState() {
    // inputController.text = 'https://open.spotify.com/playlist/2pEkQW3dSQyu1JNepjSNCX?si=d4046e6a2b114f31';
    inputController.text = 'https://open.spotify.com/playlist/37i9dQZF1DX0kbJZpiYdZl?si=04aab415fea145ec';
    super.initState();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlurGradient(
        child: Scaffold( 
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: DefaultAppBar(
            title: 'Transfer', 
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 60, 15.0, 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Center(
                    child: Text(
                      'Paste the link to your playlist',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30
                      )
                    ),
                  ),
                ),
                
                TextInput(
                  controller: inputController,
                  placeholder: 'Playlist Link',
                  icon: Icons.search,
                  autoFocus: true,
                ),
                Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineElevatedButton(
                        callback: () => Navigator.pushNamed(context, HomeScreenRoute),
                        title: 'Cancel', 
                        size: Size(150.0, 25),
                        fontSize: 22,
                        fontColor: Colors.white,
                        borderColor: OpaqueGray,
                        backgroundColor: Colors.transparent.withOpacity(0),
                      ),
                      FilledElevatedButton(
                        callback: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlaylistView(playlistLink: inputController.text))
                          );

                        },
                        title: 'Search', 
                        size: Size(150.0, 25),
                        fontSize: 20,
                        backgroundColor: OpaqueGray
                      ),
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
