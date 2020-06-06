import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viewnotion/config/config.dart';
import 'package:viewnotion/screen/wallpaper_view_screen.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var images = [
    'https://images.unsplash.com/photo-1499858476316-343e284f1f67?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1539453198476-931a0137f0d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
    'https://images.unsplash.com/photo-1589223050080-165d4cb53c13?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2122&q=80',
    'https://images.unsplash.com/photo-1589223051446-09d09d8f0107?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1554743847-2604e27f3dd9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80',
    'https://images.unsplash.com/photo-1587501019799-776d242afa7c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80',
    'https://images.unsplash.com/photo-1591039325737-cb4b299e3f13?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1591286137319-7d628a082387?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1591253604755-a03c59ca2883?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Divider(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 32.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Explore",
                style: titleTextStyle,
              ),
            ),
          ),
          StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            itemCount: images.length,
            // mainAxisSpacing: 20,
            // crossAxisSpacing: 20,
            //padding: EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WallPaperViewScreen(images[index]),
                    ),
                  );
                },
                child: Hero(
                  tag: images[index],
                  child: CachedNetworkImage(
                    placeholder: (ctx, index) => Image(
                      image: AssetImage("assets/images/loading-image.gif"),
                    ),
                    imageUrl: images[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
