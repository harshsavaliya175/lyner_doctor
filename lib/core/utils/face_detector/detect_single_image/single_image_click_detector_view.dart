import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:lynerdoctor/core/utils/face_detector/detect_single_image/single_image_click_camera_view.dart';

enum SingleImageClickDetectorViewMode { liveFeed, gallery }

class SingleImageClickDetectorView extends StatefulWidget {
  const SingleImageClickDetectorView({
    Key? key,
    required this.title,
    required this.onImage,
    this.customPaint,
    this.text,
    this.initialDetectionMode = SingleImageClickDetectorViewMode.liveFeed,
    this.initialCameraLensDirection = CameraLensDirection.back,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    required this.imageClickCountTap,
    required this.imageCount,
  }) : super(key: key);

  final int imageCount;
  final String title;
  final CustomPaint? customPaint;
  final String? text;
  final SingleImageClickDetectorViewMode initialDetectionMode;
  final Function(InputImage inputImage) onImage;
  final Function()? onCameraFeedReady;
  final Function(SingleImageClickDetectorViewMode mode)?
      onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;
  final Function(int imageClickCount) imageClickCountTap;

  @override
  State<SingleImageClickDetectorView> createState() =>
      _SingleImageClickDetectorViewState();
}

class _SingleImageClickDetectorViewState
    extends State<SingleImageClickDetectorView> {
  late SingleImageClickDetectorViewMode _mode;

  @override
  void initState() {
    _mode = widget.initialDetectionMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleImageClickCameraView(
      title: widget.title,
      photoIndex: widget.imageCount,
      customPaint: widget.customPaint,
      onImage: (InputImage inputImage) {
        widget.onImage(inputImage);
      },
      onCameraFeedReady: widget.onCameraFeedReady,
      onDetectorViewModeChanged: () {
        _onDetectorViewModeChanged();
      },
      initialCameraLensDirection: widget.initialCameraLensDirection,
      onCameraLensDirectionChanged: widget.onCameraLensDirectionChanged,
      imageClickCountTap: (int imageClickCount) {
        widget.imageClickCountTap(imageClickCount);
      },
    );
  }

  void _onDetectorViewModeChanged() {
    if (_mode == SingleImageClickDetectorViewMode.liveFeed) {
      _mode = SingleImageClickDetectorViewMode.gallery;
    } else {
      _mode = SingleImageClickDetectorViewMode.liveFeed;
    }
    if (widget.onDetectorViewModeChanged != null) {
      widget.onDetectorViewModeChanged!(_mode);
    }
    setState(() {});
  }
}
