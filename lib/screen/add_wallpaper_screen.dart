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
                padding: const EdgeInsets.all(8.0),
                child: Text("Click on the image above to upload your image"),
              ),
              SizedBox(
                height: 20,
              ),
              detectedLabel != null
                  ? Wrap(
                      spacing: 5,
                      children: detectedLabel.map((label) {
                        return Chip(
                          label: Text(label.text),
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

    //Print out the labels
    print('Objects in the image ------------ Confidence');
    for (var label in labels) {
      print("${label.text} ----------- [${label.confidence}]");
    }
    setState(() {
      detectedLabel = labels;
      _image = image;
    });
  }
}
