import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer getShimmerContent(Size screenSize, double playlistImageHeight){
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 67, 67, 67),
      highlightColor: Color.fromARGB(255, 82, 82, 82),
      child: Container(
      height: screenSize.height,
      child: Column(
        children: [
          //playlist image
          Container(
            width: screenSize.width,
            alignment: Alignment.topCenter,
            height: playlistImageHeight,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                child: Container(
                  width: 250,
                  height: playlistImageHeight - 50,
                  decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
            ),
          ),
          // playlist songs
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) => getShimmerLoading(),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 20),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    ),
    );
    
}

Shimmer getShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 67, 67, 67),
      highlightColor: Color.fromARGB(255, 82, 82, 82),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: ()=> print('pressed'),
              icon: Icon(Icons.close),
              color: Color.fromARGB(255, 83, 83, 83),
              iconSize: 26,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                    width: 150,
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 150,
                    height: 12.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }