import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viewnotion/config/config.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var images = [
    'https://images.pexels.com/photos/1927220/pexels-photo-1927220.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://images.pexels.com/photos/1123819/pexels-photo-1123819.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    'https://images.unsplash.com/photo-1557244056-ac3033d17d9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1568819317551-31051b37f69f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1553010254-267b14135d9b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1582944682271-172a57ce4b52?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'https://images.unsplash.com/photo-1520551149954-41255a5fa237?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/flagged/photo-1558829608-12b0a5d6dbc1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    'https://images.unsplash.com/photo-1527008527515-d18557de1589?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=628&q=80',
    'https://images.unsplash.com/photo-1522264334183-dc22c2332a2a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
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
                "Favorites",
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
              return CachedNetworkImage(
                placeholder: (ctx, index) => Image(
                  image: AssetImage("assets/images/loading-image.gif"),
                ),
                imageUrl: images[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
