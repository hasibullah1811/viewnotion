import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddWallpaperScreen extends StatefulWidget {
  @override
  _AddWallpaperScreenState createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  File _image;
  bool isUploading = false;
  bool uploadComplete = false;

  final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
  List<ImageLabel> detectedLabel;

  //Firebase References
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Firestore _db = Firestore.instance;

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
        title: Text('Image Object Detection'),
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
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 12.0, bottom: 12, left: 8, right: 8),
              //   child: Text("Click on the image above to upload your image"),
              // ),
              SizedBox(
                height: 5,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Objects in the Image",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
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
              SizedBox(
                height: 40,
              ),

              if (isUploading) ...[
                Text("Image is uploading...."),
              ],
              if (uploadComplete) ...[
                Text("Image is Uploaded!"),
              ],
              RaisedButton(
                onPressed: () {
                  _uploadImage();
                },
                child: Text("Upload Image"),
              ),
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
      detectedLabel = labels.reversed.toList();
      _image = image;
    });
  }

  void _uploadImage() async {
    if (_image != null) {
      String fileName =
          path.basename(_image.path); // Getting the file name of the image

      // Getting the current user ID
      FirebaseUser _currentUser = await _auth.currentUser();
      String uid = _currentUser.uid;

      // Upload the image to the firebase Storage
      StorageUploadTask task = _storage
          .ref()
          .child("Wallpapers")
          .child(uid)
          .child(fileName)
          .putFile(_image);

      // Get the uplaoded image data
      task.events.listen((e) {
        if (e.type == StorageTaskEventType.progress) {
          setState(() {
            isUploading = true;
          });
        }
        if (e.type == StorageTaskEventType.success) {
          setState(() {
            uploadComplete = true;
            isUploading = false;
          });
          e.snapshot.ref.getDownloadURL().then((imageUrl) {
            //gets the image URL
            Navigator.of(context).pop();
          });
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please select an image to upload..."),
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("Okay"),
              ),
            ],
          );
        },
      );
    }
  }
}
