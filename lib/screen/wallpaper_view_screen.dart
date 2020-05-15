import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:viewnotion/config/config.dart';

class WallPaperViewScreen extends StatefulWidget {
  final String image;
  WallPaperViewScreen(this.image);
  @override
  _WallPaperViewScreenState createState() => _WallPaperViewScreenState();
}

class _WallPaperViewScreenState extends State<WallPaperViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
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
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Container(
                  child: Hero(
                    tag: widget.image,
                    child: CachedNetworkImage(
                      placeholder: (ctx, index) => Image(
                        image: AssetImage("assets/images/loading-image.gif"),
                      ),
                      imageUrl: widget.image,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
