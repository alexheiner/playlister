import 'package:flutter/material.dart';
import '../../../widgets/navigation/default_app_bar.dart';
import '../../../config/themes/colors.dart';
import './constants.dart';

class SpotifyPlaylistView extends StatefulWidget {
  SpotifyPlaylistView({Key? key}) : super(key: key);

  @override
  State<SpotifyPlaylistView> createState() => _SpotifyPlaylistViewState();
}

class _SpotifyPlaylistViewState extends State<SpotifyPlaylistView> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = FOOD_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      for(var i = 0; i < 20; i++){
        listItems.add(Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Color.fromARGB(255, 83, 83, 83), boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                      child: Text(
                      post["name"],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          )));
      }
    });
  
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: DarkBody,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: DefaultAppBar(
            title: 'Playlist', 
          ),
        ),
        body: Container(
          height: screenSize.height,
          child: Column(
            children: [
              //playlist image
              // AnimatedOpacity(
              //   duration: const Duration(milliseconds: 2000),
              //   opacity: closeTopContainer ? 0 : 1,
              //   child: AnimatedContainer(
              //     duration: const Duration(milliseconds: 2000),
              //     width: screenSize.width,
              //     alignment: Alignment.topCenter,
              //     height: closeTopContainer ? 0 : playlistImageHeight,
              //     child: Container(
              //       margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              //       child: FittedBox(
              //         fit: BoxFit.fill,
              //         alignment: Alignment.topCenter,
              //         child: Container(
              //           width: 150,
              //           height: categoryHeight,
              //           decoration: BoxDecoration(
              //             color: Colors.purple[200],
              //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: closeTopContainer?0:1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: screenSize.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer?0:playlistImageHeight,
                    child: categoriesScroller),
              ),
              // playlist songs
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: controller,
                  itemCount: itemsData.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                      return itemsData[index];
                  },
                ),
              ),
            ],
          ),
        ),
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
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
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