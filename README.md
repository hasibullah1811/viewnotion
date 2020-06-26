# viewnotion

Simple App to demonstrate the use of Mobile SDK ML KIT that brings Google's machine learning expertise to Android and iOS apps in a powerful yet easy-to-use package. Whether you're new or experienced in machine learning, you can implement the functionality you need in just a few lines of code.

![alt text](https://lh3.googleusercontent.com/pw/ACtC-3ffvLb5CyVxwVbtObdZs98xlZCOpPpiwMuYCUQiGcszkNNTkgUpSN_E1qHxeDlFhffn71gyiJdaQHHhNq7VVNbYfodZPItSBzNDEqdtTSq55rsJuc6YKvw0jLtv4hXvGhSJfgF8SSLNVCRUfJ6hTuyA=w546-h969-no?authuser=0 "Screen")

## Work in progress

The features :
- ✔️ Image labeling
- ⌛ Text recognition		
- ⌛ Face detection		
- ⌛ Barcode scanning				
- ⌛ Object detection & tracking		
- ⌛ Landmark recognition		
- ⌛ Language identification		
- ⌛ Translation		
- ⌛ Smart Reply		
- ⌛ AutoML model inference		
- ⌛ Custom model inference
  
# How It Works
 Using an ML Vision Detector 
    Create a FirebaseVisionImage object from your image. To create a FirebaseVisionImage from an image File object:

    final File imageFile = getImageFile();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
    
 Create an instance of a detector. 
 
    final BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    final ImageLabeler cloudLabeler = FirebaseVision.instance.cloudImageLabeler();
    final FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    
  You can also configure all detectors, except TextRecognizer, with desired options.
  
    final ImageLabeler labeler = FirebaseVision.instance.imageLabler(
    ImageLabelerOptions(confidenceThreshold: 0.75),
    );
