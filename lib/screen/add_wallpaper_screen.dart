import 'package:flutter/material.dart';

class AddWallpaperScreen extends StatefulWidget {
  @override
  _AddWallpaperScreenState createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallpaper'),
      ),
    );
  }
}