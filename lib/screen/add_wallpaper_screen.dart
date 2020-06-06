import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddWallpaperScreen extends StatefulWidget {
  @override
  _AddWallpaperScreenState createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  File _image;

  final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
  List<ImageLabel> detectedLabel;

  @override
  void dispose() {
    // TODO: implement dispose
    labeler.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallpaper'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  // Function to upload the image
                  _loadImage();
                },
                child: _image != null
                    ? Image.file(_image)
                    : Image(
                        image: AssetImage(
                            'assets/images/placeholder-upload-img.png'),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, bottom: 12, left: 8, right: 8),
                child: Text("Click on the image above to upload your image"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey[800], boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 1)
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Objects in the Image"),
                      Text("Confidence"),
                    ],
                  ),
                ),
              ),
              detectedLabel != null
                  ? Wrap(
                      spacing: 5,
                      children: detectedLabel.map((label) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              boxShadow: [
                                BoxShadow(color: Colors.black, spreadRadius: 1)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 4, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Chip(
                                  label: Text(label.text),
                                ),
                                Container(
                                  child: Text("${label.confidence}"),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _loadImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);

    List<ImageLabel> labels = await labeler.processImage(visionImage);

    // //Print out the labels
    // print('Objects in the image ------------ Confidence');
    // for (var label in labels) {
    //   print("${label.text} ----------- [${label.confidence}]");
    // }
    setState(() {
      detectedLabel = labels;
      _image = image;
    });
  }
}
