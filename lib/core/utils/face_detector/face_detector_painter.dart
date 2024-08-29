import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';

import 'coordinates_translator.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
    this.faces,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
    this.imageCount,
  );

  final List<Face> faces;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;
  final int imageCount;

  final AddPatientController addPatientController =
      Get.put(AddPatientController());

  bool detectSmile(Face face) {
    FaceContour? upperLipTop = face.contours[FaceContourType.upperLipTop];
    FaceContour? upperLipBottom = face.contours[FaceContourType.upperLipBottom];
    FaceContour? lowerLipTop = face.contours[FaceContourType.lowerLipTop];
    FaceContour? lowerLipBottom = face.contours[FaceContourType.lowerLipBottom];
    bool isSmiling = false;
    // Check head rotation angles
    // final rotationX = face.headEulerAngleX; // X-axis rotation
    // final rotationZ = face.headEulerAngleZ; // Z-axis rotation
    final double? rotationY = face.headEulerAngleY; // Y-axis rotation

    if (imageCount == 0) {
      if (rotationY != null) {
        if (!(rotationY < -10) && !(rotationY > 10)) {
          if (upperLipTop != null &&
              upperLipBottom != null &&
              lowerLipTop != null &&
              lowerLipBottom != null) {
            isSmiling = true;
            // isSmiling = face.smilingProbability != null &&
            //     face.smilingProbability! > 0.5;
          }
        }
      }
    } else if (imageCount == 1 || imageCount == 6) {
      if (rotationY != null) {
        if (!(rotationY < -10) && !(rotationY > 10)) {
          if (upperLipTop != null &&
              upperLipBottom != null &&
              lowerLipTop != null &&
              lowerLipBottom != null) {
            isSmiling = face.smilingProbability != null &&
                face.smilingProbability! > 0.5;
          }
        }
      }
    } else if (imageCount == 2) {
      if (rotationY != null) {
        if (rotationY > 10) {
          isSmiling = true;
        }
      }
    } else if (imageCount == 5) {
      if (rotationY != null) {
        if (rotationY > 10) {
          if (upperLipTop != null &&
              upperLipBottom != null &&
              lowerLipTop != null &&
              lowerLipBottom != null) {
            isSmiling = face.smilingProbability != null &&
                face.smilingProbability! > 0.5;
          }
        }
      }
    } else if (imageCount == 7) {
      if (rotationY != null) {
        if (rotationY < -10) {
          if (upperLipTop != null &&
              upperLipBottom != null &&
              lowerLipTop != null &&
              lowerLipBottom != null) {
            isSmiling = face.smilingProbability != null &&
                face.smilingProbability! > 0.5;
          }
        }
        // if (rotationY > 10) {
        //   if (upperLipTop != null &&
        //       upperLipBottom != null &&
        //       lowerLipTop != null &&
        //       lowerLipBottom != null) {
        //     isSmiling = face.smilingProbability != null &&
        //         face.smilingProbability! > 0.5;
        //   }
        // }
      }
    }

    // if (imageCount == 0 || imageCount == 3) {
    //   if (rotationY != null) {
    //     if (!(rotationY < -10) && !(rotationY > 10)) {
    //       if (upperLipTop != null &&
    //           upperLipBottom != null &&
    //           lowerLipTop != null &&
    //           lowerLipBottom != null) {
    //         isSmiling = face.smilingProbability != null &&
    //             face.smilingProbability! > 0.5;
    //       }
    //     }
    //   }
    // } else if (imageCount == 1 || imageCount == 4) {
    //   if (rotationY != null) {
    //     if (rotationY < -10) {
    //       if (upperLipTop != null &&
    //           upperLipBottom != null &&
    //           lowerLipTop != null &&
    //           lowerLipBottom != null) {
    //         isSmiling = face.smilingProbability != null &&
    //             face.smilingProbability! > 0.5;
    //       }
    //     }
    //   }
    // } else if (imageCount == 2 || imageCount == 5) {
    //   if (rotationY != null) {
    //     if (rotationY > 10) {
    //       if (upperLipTop != null &&
    //           upperLipBottom != null &&
    //           lowerLipTop != null &&
    //           lowerLipBottom != null) {
    //         isSmiling = face.smilingProbability != null &&
    //             face.smilingProbability! > 0.5;
    //       }
    //     }
    //   }
    // }

    //
    //

    // FaceContour? upperLipTop = face.contours[FaceContourType.upperLipTop];
    // FaceContour? upperLipBottom = face.contours[FaceContourType.upperLipBottom];
    // FaceContour? lowerLipTop = face.contours[FaceContourType.lowerLipTop];
    // FaceContour? lowerLipBottom = face.contours[FaceContourType.lowerLipBottom];
    //
    // bool isSmiling = false;
    // if (upperLipTop != null &&
    //     upperLipBottom != null &&
    //     lowerLipTop != null &&
    //     lowerLipBottom != null) {
    //   isSmiling = (upperLipTop.points.first.y < lowerLipTop.points.first.y &&
    //       upperLipBottom.points.last.y < lowerLipBottom.points.last.y);
    //
    //   if (isSmiling) {
    //     print('User is smiling!');
    //   } else {
    //     print('User is not smiling.');
    //   }
    // }
    return isSmiling;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // final Paint landmarkPaint = Paint()
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 1.0
    //   ..color = Colors.green;

    for (final Face face in faces) {
      bool isSmiling = detectSmile(face);
      addPatientController.isClick = isSmiling;
      // final Paint borderPaint = Paint()
      //   ..style = PaintingStyle.stroke
      //   ..strokeWidth = 2.0
      //   ..color = isSmiling ? Colors.green : Colors.red;
      //
      // final double left = translateX(
      //   face.boundingBox.left,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );
      // final double top = translateY(
      //   face.boundingBox.top,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );
      // final double right = translateX(
      //   face.boundingBox.right,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );
      // final double bottom = translateY(
      //   face.boundingBox.bottom,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );

      // canvas.drawRect(
      //   Rect.fromLTRB(left, top, right, bottom),
      //   borderPaint,
      // );

      // paintContour(
      //   face: face,
      //   size: size,
      //   type: FaceContourType.face,
      //   borderPaint: borderPaint,
      //   canvas: canvas,
      // );
      // paintContour(
      //   face: face,
      //   size: size,
      //   type: FaceContourType.upperLipTop,
      //   borderPaint: borderPaint,
      //   canvas: canvas,
      // );
      // paintContour(
      //   face: face,
      //   size: size,
      //   type: FaceContourType.lowerLipBottom,
      //   borderPaint: borderPaint,
      //   canvas: canvas,
      // );

      //...........................

      // for (final FaceLandmarkType type in FaceLandmarkType.values) {
      //   paintLandmark(type);
      // }

      // void paintLandmark(FaceLandmarkType type) {
      //   final FaceLandmark? landmark = face.landmarks[type];
      //   if (landmark?.position != null) {
      //     canvas.drawCircle(
      //       Offset(
      //         translateX(
      //           landmark!.position.x.toDouble(),
      //           size,
      //           imageSize,
      //           rotation,
      //           cameraLensDirection,
      //         ),
      //         translateY(
      //           landmark.position.y.toDouble(),
      //           size,
      //           imageSize,
      //           rotation,
      //           cameraLensDirection,
      //         ),
      //       ),
      //       2,
      //       landmarkPaint,
      //     );
      //   }
      // }
    }
  }

  void paintContour({
    required FaceContourType type,
    required Face face,
    required Size size,
    required Canvas canvas,
    required Paint borderPaint,
  }) {
    FaceContour? contour = face.contours[type];
    if (contour?.points != null) {
      final Path path = Path();
      bool isFirstPoint = true;
      for (final Point point in contour!.points) {
        final Offset offset = Offset(
          translateX(
            point.x.toDouble(),
            size,
            imageSize,
            rotation,
            cameraLensDirection,
          ),
          translateY(
            point.y.toDouble(),
            size,
            imageSize,
            rotation,
            cameraLensDirection,
          ),
        );
        if (isFirstPoint) {
          path.moveTo(offset.dx, offset.dy);
          isFirstPoint = false;
        } else {
          path.lineTo(offset.dx, offset.dy);
        }
      }
      path.close();
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.faces != faces;
  }
}
