import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    Key? key,
    required this.customPaint,
    required this.onImage,
    this.onCameraFeedReady,
    this.onDetectorViewModeChanged,
    this.onCameraLensDirectionChanged,
    this.initialCameraLensDirection = CameraLensDirection.back,
    required this.imageClickCountTap,
  }) : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final CameraLensDirection initialCameraLensDirection;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final Function(int imageClickCount) imageClickCountTap;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final AddPatientController addPatientController =
      Get.put(AddPatientController());
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  bool _changingCameraLens = false;
  List<File> smileImg = [];
  String faceText = LocaleKeys.profile.translateText;
  final CameraLensDirection initialCameraLensDirection =
      CameraLensDirection.front;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (int i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _liveFeedBody());
  }

  Widget _liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();

    AssetGenImage image = Assets.images.imgProfileDetect;
    if (smileImg.length == 0) {
      image = Assets.images.imgProfileDetect;
    } else if (smileImg.length == 1) {
      image = Assets.images.imgFaceDetect;
    } else if (smileImg.length == 2) {
      image = Assets.images.imgSmileDetect;
    } else if (smileImg.length == 3) {
      image = Assets.images.imgIntraMaxDetect;
    } else if (smileImg.length == 4) {
      image = Assets.images.imgIntraMandDetect;
    } else if (smileImg.length == 5) {
      image = Assets.images.imgInterRightDetect;
    } else if (smileImg.length == 6) {
      image = Assets.images.imgInterFaceDetect;
    } else if (smileImg.length == 7) {
      image = Assets.images.imgInterLeftDetect;
    }
    return SafeArea(
      child: Container(
        color: Color(0xFFF4F6FA),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _changingCameraLens
                ? Center(
                    child: Text(LocaleKeys.changingCameraLens.translateText))
                : CameraPreview(_controller!),
            if (widget.customPaint != null) widget.customPaint!,
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width *
                    ((smileImg.length == 0) ||
                            (smileImg.length == 1) ||
                            (smileImg.length == 2)
                        ? 0.7
                        : 0.4),
                height: MediaQuery.of(context).size.width *
                    ((smileImg.length == 0) ||
                            (smileImg.length == 1) ||
                            (smileImg.length == 2)
                        ? 0.7
                        : 0.4),
                child: image.image(
                  width: MediaQuery.of(context).size.width *
                      ((smileImg.length == 0) ||
                              (smileImg.length == 1) ||
                              (smileImg.length == 2)
                          ? 0.85
                          : 0.5),
                  height: MediaQuery.of(context).size.height *
                      ((smileImg.length == 0) ||
                              (smileImg.length == 1) ||
                              (smileImg.length == 2)
                          ? 0.33
                          : 0.15),
                  fit: BoxFit.contain,
                  color: addPatientController.isClick
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                ),
              ),
            ),
            _backButton(),
            _captureCamera(),
            //_switchLiveCameraToggle(),
          ],
        ),
      ),
    );
  }

  // Widget _switchLiveCameraToggle() => Positioned(
  //       bottom: 8,
  //       right: 8,
  //       child: SizedBox(
  //         height: 50.0,
  //         width: 50.0,
  //         child: FloatingActionButton(
  //           heroTag: Object(),
  //           onPressed: _switchLiveCamera,
  //           backgroundColor: Colors.black,
  //           child: Icon(
  //             Platform.isIOS
  //                 ? Icons.flip_camera_ios_outlined
  //                 : Icons.flip_camera_android_outlined,
  //             size: 25,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     );

  Widget _backButton() => Positioned(
        top: 10,
        left: 15,
        child: Row(
          children: [
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: FloatingActionButton(
                shape: CircleBorder(),
                heroTag: Object(),
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
            10.space(),
            faceText.normalText(fontSize: 18),
          ],
        ),
      );

  void showClickImageAcceptModifyDialog(XFile? image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Container(
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.file(
                    File(image?.path ?? ''),
                    height: 400,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          children: [
                            5.space(),
                            Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.red,
                            ),
                            Text(LocaleKeys.modify.translateText),
                            5.space(),
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(color: Colors.grey, width: 4),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          smileImg.add(File(image?.path ?? ''));
                          widget.imageClickCountTap(smileImg.length);
                          if (smileImg.length == 1) {
                            faceText = LocaleKeys.face.translateText;
                          }
                          if (smileImg.length == 2) {
                            faceText = LocaleKeys.smile.translateText;
                          }
                          if (smileImg.length == 3) {
                            faceText = LocaleKeys.intraMax.translateText;
                          }
                          if (smileImg.length == 4) {
                            faceText = LocaleKeys.intraMand.translateText;
                          }
                          if (smileImg.length == 5) {
                            faceText = LocaleKeys.intraRight.translateText;
                          }
                          if (smileImg.length == 6) {
                            faceText = LocaleKeys.intraFace.translateText;
                          }
                          if (smileImg.length == 7) {
                            faceText = LocaleKeys.intraLeft.translateText;
                          }
                          if (smileImg.length == 8) {
                            Get.back(result: smileImg);
                          }
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            5.space(),
                            Icon(
                              Icons.check,
                              size: 25,
                              color: Colors.green,
                            ),
                            Text(LocaleKeys.accept.translateText),
                            5.space(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _captureCamera() => Positioned(
        left: 0,
        bottom: 10,
        right: 0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
                width: 50.0,
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  heroTag: Object(),
                  onPressed: () async {
                    try {
                      final XFile? image = await _controller?.takePicture();
                      print(image?.path);
                      showClickImageAcceptModifyDialog(image);
                    } catch (e) {
                      print(e);
                    }
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              5.space(),
              SizedBox(
                height: 50.0,
                width: 50.0,
                child: FloatingActionButton(
                  shape: CircleBorder(),
                  heroTag: Object(),
                  onPressed: _switchLiveCamera,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Platform.isIOS
                        ? Icons.flip_camera_ios_outlined
                        : Icons.flip_camera_android_outlined,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future _startLiveFeed() async {
    final CameraDescription camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then(
      (void _) {
        if (!mounted) {
          return;
        }
        _controller?.startImageStream(
          (CameraImage image) {
            processCameraImage(image);
          },
        ).then(
          (void value) {
            if (widget.onCameraFeedReady != null) {
              widget.onCameraFeedReady!();
            }
            if (widget.onCameraLensDirectionChanged != null) {
              widget.onCameraLensDirectionChanged!(camera.lensDirection);
            }
          },
        );
        setState(() {});
      },
    );
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void processCameraImage(CameraImage image) {
    final InputImage? inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) {
      return;
    }
    widget.onImage(inputImage);
  }

  final Map<DeviceOrientation, int> _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) {
      return null;
    }
    final CameraDescription camera = _cameras[_cameraIndex];
    final int sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      int? rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) {
        return null;
      }
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) {
      return null;
    }

    // get image format
    final InputImageFormat? format =
        InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) {
      return null;
    }
    final Plane plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
