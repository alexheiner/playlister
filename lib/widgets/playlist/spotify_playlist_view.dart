import 'package:flutter/material.dart';
import '../navigation/default_app_bar.dart';
import '../../config/themes/colors.dart';
import '../../screens/transfer/spotify/constants.dart';
import '../../services/spotify_api.dart';
import '../../models/playlist_tracks.dart';

List<Widget> getPostsData() {
  List<dynamic> responseList = FOOD_DATA;
  List<Widget> listItems = [];
  responseList.forEach((post) {
    for(var i = 0; i < 20; i++){
      listItems.add(Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: const Color(0x202020), boxShadow: [
          BoxShadow(color: Color.fromARGB(255, 0, 0, 0).withAlpha(100), blurRadius: 10.0),
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    onPressed: ()=> print('pressed'),
                    icon: Icon(Icons.close),
                    color: Color.fromARGB(255, 83, 83, 83),
                    iconSize: 26,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                        child: Text(
                        post["name"],
                        style: const TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      
                      Text(
                        post["duration"],
                        style: const TextStyle(fontSize: 17, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )));
    }
  });

  return listItems;
}


Future<List<Widget>> _getPlaylist() async {
  // PlaylistTracks playlist = await SpotifyApi.getTracks(widget.playlistId);
  // print(playlist.total);
  return Future<List<Widget>>.delayed(
    const Duration(seconds: 5),
    () => getPostsData(),
  );
}

class SpotifyPlaylistView extends StatefulWidget {
  final String playlistId;
  SpotifyPlaylistView({required this.playlistId, Key? key}) : super(key: key);

  @override
  State<SpotifyPlaylistView> createState() => _SpotifyPlaylistViewState();
}

class _SpotifyPlaylistViewState extends State<SpotifyPlaylistView> {
  bool isLoading = false;
  late Future< List<Widget> > _playlist;

  @override
  void initState() {
    super.initState();
    _playlist = _getPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkBody,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: DefaultAppBar(
            title: 'Playlist', 
          ),
        ),
        body: FutureBuilder < List<Widget> > (
          initialData: [],
          future: _playlist,
          builder: (context, AsyncSnapshot<List<Widget>> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Visibility(
                    visible: snapshot.hasData,
                    child: Text(
                      'Loading..',
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  )
                ],
              );
            }
            else if(snapshot.connectionState == ConnectionState.done) {
              return PlaylistView(playlistTracks: snapshot.data ?? []);
            }
            else {
              return Text('No data');
            }
          },
        ),
      ),
    );
  }
}

class PlaylistView extends StatefulWidget {
  final List<Widget> playlistTracks;
  const PlaylistView({required this.playlistTracks, Key? key}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      double value = controller.offset/119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double playlistImageHeight = screenSize.height*0.30;
    return  Container(
      height: screenSize.height,
      child: Column(
        children: [
          //playlist image
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: closeTopContainer?0:1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: screenSize.width,
              alignment: Alignment.topCenter,
              height: closeTopContainer?0:playlistImageHeight,
              child: categoriesScroller
            ),
          ),
          // playlist songs
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: widget.playlistTracks.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                  return widget.playlistTracks[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Container(
                width: 250,
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.orange.shade400),
                child: Center(
                  child: Text(
                    'Playlist Image',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                    ),
                    )
                  )
                ),
              ),
      ),
    );
  }
}