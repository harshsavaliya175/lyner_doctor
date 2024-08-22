import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'detector_view.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({super.key});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      enableLandmarks: true,
    ),
  );
  bool canProcess = true;
  bool isBusy = false;
  CustomPaint? customPaint;
  String? _text;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  int imageCount = 0;

  @override
  void dispose() {
    canProcess = false;
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: customPaint,
      text: _text,
      onImage: (InputImage inputImage) {
        // _processImage(inputImage);
      },
      imageClickCountTap: (int imageClickCount) {
        imageCount = imageClickCount;
      },
      initialCameraLensDirection: cameraLensDirection,
      onCameraLensDirectionChanged: (CameraLensDirection value) {
        return cameraLensDirection = value;
      },
    );
  }
}
