import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:viewnotion/config/config.dart';
import 'package:viewnotion/screen/add_wallpaper_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    super.initState();
  }

  void fetchUserData() async {
    FirebaseUser currentUser = await _auth.currentUser();
    setState(() {
      _user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: _user != null
            ? Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 96.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FadeInImage(
                        width: 80,
                        height: 80,
                        image: NetworkImage("${_user.photoUrl}"),
                        placeholder:
                            AssetImage("assets/images/placeholder.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "${_user.displayName}",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        _auth.signOut();
                      },
                      child: Text("Sign out"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 12,
                            blurRadius: 1,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("My Wallpapers"),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddWallpaperScreen(),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                    itemCount: 6,
                    // mainAxisSpacing: 20,
                    // crossAxisSpacing: 20,
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (ctx, index) {
                      return Image(
                        image: NetworkImage(
                          images[index],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text('Load More'),
                    ),
                  ),
                ],
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}
