import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/face_detector/face_detector_painter.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';

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
      title: LocaleKeys.faceDetector.translateText,
      customPaint: customPaint,
      text: _text,
      onImage: (InputImage inputImage) {
        _processImage(inputImage);
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

  Future<void> _processImage(InputImage inputImage) async {
    if (!canProcess) return;
    if (isBusy) return;
    isBusy = true;
    setState(() {
      _text = '';
    });
    final List<Face> faces = await faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final FaceDetectorPainter painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        cameraLensDirection,
        imageCount,
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      String text = 'Faces found: ${faces.length}\n\n';
      for (final Face face in faces) {
        text += 'face: ${face.boundingBox}\n\n';
      }

      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
