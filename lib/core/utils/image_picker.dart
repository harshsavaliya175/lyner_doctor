import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/main/add_patient/add_patient_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import 'face_detector/detect_single_image/single_image_click_face_detector_view.dart';

ImageUploadUtils imageUploadUtils = ImageUploadUtils();

class ImageUploadUtils {
  void openImageChooser(
      {required BuildContext context, required Function onImageChose}) {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            elevation: 0,
            builder: (BuildContext context) {
              return Container(
                child: Wrap(
                  children: [
                    ListTile(
                      title: Text(LocaleKeys.gallery.translateText),
                      leading: Icon(Icons.photo_library),
                      onTap: () {
                        _imageFormGallery(
                            context: context, onImageChose: onImageChose);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text(LocaleKeys.camera.translateText),
                      leading: Icon(Icons.photo_camera),
                      onTap: () {
                        imageFromCamera(
                            context: context, onImageChose: onImageChose);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          )
        : showDialog(
            context: context,
            useSafeArea: false,
            builder: (BuildContext context) {
              return SimpleDialog(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(LocaleKeys.selectImage.translateText),
                children: [
                  ListTile(
                    title: Text(LocaleKeys.photoLibrary.translateText),
                    leading: Icon(Icons.photo_library),
                    onTap: () {
                      _imageFormGallery(
                          context: context, onImageChose: onImageChose);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(LocaleKeys.camera.translateText),
                    leading: Icon(Icons.photo_camera),
                    onTap: () {
                      imageFromCamera(
                          context: context, onImageChose: onImageChose);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
  }

  void faceDetectingOpenImageChooser({
    required BuildContext context,
    required Function onImageChose,
    required int imageCount,
    required String title,
  }) {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            elevation: 0,
            builder: (BuildContext context) {
              return GetBuilder<AddPatientController>(
                builder: (AddPatientController ctrl) {
                  return Container(
                    child: Wrap(
                      children: [
                        ListTile(
                          title: Text(LocaleKeys.gallery.translateText),
                          leading: Icon(Icons.photo_library),
                          onTap: () {
                            _imageFormGallery(
                                context: context, onImageChose: onImageChose);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text(LocaleKeys.camera.translateText),
                          leading: Icon(Icons.photo_camera),
                          onTap: () {
                            Get.to(
                              () => SingleImageClickFaceDetectorView(
                                imageCount: imageCount,
                                title: title,
                              ),
                            )?.then(
                              (result) {
                                if (result != null && result is File) {
                                  onImageChose(result);
                                  Get.back();
                                  // ctrl.intraLeftImageFile = result;
                                  // ctrl.uploadPatientSingleImage(
                                  //     paramName: 'patient_inter_gauche',
                                  //     file: result);
                                  // ctrl.update();
                                }
                              },
                            );
                            // imageFromCamera(
                            //     context: context, onImageChose: onImageChose);
                            // Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        : showDialog(
            context: context,
            useSafeArea: false,
            builder: (BuildContext context) {
              return SimpleDialog(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text(LocaleKeys.selectImage.translateText),
                children: [
                  ListTile(
                    title: Text(LocaleKeys.photoLibrary.translateText),
                    leading: Icon(Icons.photo_library),
                    onTap: () {
                      _imageFormGallery(
                          context: context, onImageChose: onImageChose);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(LocaleKeys.camera.translateText),
                    leading: Icon(Icons.photo_camera),
                    onTap: () {
                      imageFromCamera(
                          context: context, onImageChose: onImageChose);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
  }

  void openProfileImageChooser(
      {required BuildContext context,
      required Function onProfileChose,
      required Function onLogoChose}) {
    Platform.isIOS
        ? showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Container(
                  child: Wrap(
                    children: [
                      ListTile(
                        title: Text(LocaleKeys.selectPhoto.translateText),
                        onTap: () {
                          onProfileChose();
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text(LocaleKeys.selectLogo.translateText),
                        onTap: () {
                          onLogoChose();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(LocaleKeys.selectPhotoOrLogo.translateText),
                children: [
                  ListTile(
                    title: Text(LocaleKeys.selectPhoto.translateText),
                    onTap: () {
                      Navigator.pop(context);
                      onProfileChose();
                    },
                  ),
                  ListTile(
                    title: Text(LocaleKeys.selectLogo.translateText),
                    onTap: () {
                      Navigator.pop(context);
                      onLogoChose();
                    },
                  ),
                ],
              );
            },
          );
  }

  /*void _imageFormGallery(
      {required BuildContext context, required Function onImageChose}) async {
    var status = await (Platform.isIOS
        ? Permission.storage.request()
        : Permission.mediaLibrary.request());
    if (status.isGranted) {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
        onImageChose(File(pickedFile.files.single.path!));
        print(pickedFile.files.single.path);
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: "Without this permission app can not change  picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: "Settings",
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : null,
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message:
              "To access this feature please grant permission from settings.",
          mainButton: SnackBarAction(
            label: "Settings",
            textColor: Colors.amber,
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
  }

  void imageFromCamera({
    required BuildContext context,
    required Function onImageChose,
  }) async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 100);
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.path));
        onImageChose(File(pickedFile.path));
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
                "Without this permission app can not change profile picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: "Settings",
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : SnackBarAction(
                    label: "Settings",
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  ),
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
                "To access this feature please grant permission from settings.",
            mainButton: SnackBarAction(
              label: "Settings",
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3)),
      );
      return;
    }
  }*/

  void _imageFormGallery(
      {required BuildContext context, required Function onImageChose}) async {
    PermissionStatus status = await (Platform.isIOS
        ? Permission.storage.request()
        : Permission.mediaLibrary.request());
    if (status.isGranted) {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
        XFile? photoCompressedFile =
            await compressImage(File(pickedFile.files.single.path!));
        onImageChose(File(photoCompressedFile!.path));
        print(pickedFile.files.single.path);
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message: LocaleKeys
              .withoutThisPermissionAppCanNotChangeProfilePicture.translateText,
          mainButton: Platform.isIOS
              ? SnackBarAction(
                  label: LocaleKeys.settings.translateText,
                  // textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    openAppSettings();
                  },
                )
              : null,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message: LocaleKeys
              .toAccessThisFeaturePleaseGrantPermissionFromSettings
              .translateText,
          mainButton: SnackBarAction(
            label: LocaleKeys.settings.translateText,
            textColor: Colors.amber,
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    log("filePathfilePath--${filePath}");
    // String filePath = await HeicToJpg.convert(path);
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  void imageFromCamera(
      {required BuildContext context, required Function onImageChose}) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 100);
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.path));
        XFile? photoCompressedFile = await compressImage(File(pickedFile.path));
        onImageChose(File(photoCompressedFile!.path));
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: LocaleKeys
                .withoutThisPermissionAppCanNotChangeProfilePicture
                .translateText,
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: LocaleKeys.settings.translateText,
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : SnackBarAction(
                    label: LocaleKeys.settings.translateText,
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  ),
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: LocaleKeys
                .toAccessThisFeaturePleaseGrantPermissionFromSettings
                .translateText,
            mainButton: SnackBarAction(
              label: LocaleKeys.settings.translateText,
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3)),
      );
      return;
    }
  }

  void pickFileFormStorage({
    required BuildContext context,
    required Function onFileChose,
  }) async {
    if (Platform.isIOS) {
      // Directly open file picker for iOS as it doesn't need manageExternalStorage permission
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (pickedFile != null) {
        onFileChose(File(pickedFile.files.single.path!));
        print(pickedFile.files.single.path);
      }
      return;
    } else {
      // Handle Android permissions
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final FilePickerResult? pickedFile =
            await FilePicker.platform.pickFiles(
          type: FileType.any,
        );
        if (pickedFile != null) {
          onFileChose(File(pickedFile.files.single.path!));
          print(pickedFile.files.single.path);
        }
        return;
      } else if (status.isDenied) {
        Get.showSnackbar(
          GetSnackBar(
              message: LocaleKeys
                  .withoutThisPermissionAppCanNotChangeProfilePicture
                  .translateText,
              mainButton: Platform.isIOS
                  ? SnackBarAction(
                      label: LocaleKeys.settings.translateText,
                      // textColor: Theme.of(context).accentColor,
                      onPressed: () {
                        openAppSettings();
                      },
                    )
                  : null,
              duration: Duration(seconds: 3)),
        );
        return;
      } else if (status.isPermanentlyDenied) {
        Get.showSnackbar(
          GetSnackBar(
            message: LocaleKeys
                .toAccessThisFeaturePleaseGrantPermissionFromSettings
                .translateText,
            mainButton: SnackBarAction(
              label: LocaleKeys.settings.translateText,
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }
  }

  void pickStlFileFormStorage({
    required BuildContext context,
    required Function onFileChose,
  }) async {
    if (Platform.isIOS) {
      // Directly open file picker for iOS as it doesn't need manageExternalStorage permission
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['stl'],
      );
      if (pickedFile != null) {
        onFileChose(File(pickedFile.files.single.path!));
        print(pickedFile.files.single.path);
      }
      return;
    } else {
      // Handle Android permissions
      PermissionStatus status =
          await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final FilePickerResult? pickedFile =
            await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['stl'],
        );
        if (pickedFile != null) {
          onFileChose(File(pickedFile.files.single.path!));
          print(pickedFile.files.single.path);
        }
        return;
      } else if (status.isDenied) {
        Get.showSnackbar(
          GetSnackBar(
              message: LocaleKeys
                  .withoutThisPermissionAppCanNotChangeProfilePicture
                  .translateText,
              mainButton: Platform.isIOS
                  ? SnackBarAction(
                      label: LocaleKeys.settings.translateText,
                      // textColor: Theme.of(context).accentColor,
                      onPressed: () {
                        openAppSettings();
                      },
                    )
                  : null,
              duration: Duration(seconds: 3)),
        );
        return;
      } else if (status.isPermanentlyDenied) {
        Get.showSnackbar(
          GetSnackBar(
            message: LocaleKeys
                .toAccessThisFeaturePleaseGrantPermissionFromSettings
                .translateText,
            mainButton: SnackBarAction(
              label: LocaleKeys.settings.translateText,
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }
  }
}

/*ImageUploadUtils imageUploadUtils = ImageUploadUtils();

class ImageUploadUtils {
  void openImageChooser(
      {required BuildContext context, required Function onImageChose}) {
    Platform.isIOS
        ? showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 0,
      builder: (context) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                title: Text("Gallery"),
                leading: Icon(Icons.photo_library),
                onTap: () {
                  _imageFormGallery(
                      context: context, onImageChose: onImageChose);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Camera"),
                leading: Icon(Icons.photo_camera),
                onTap: () {
                  imageFromCamera(
                      context: context, onImageChose: onImageChose);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    )
        : showDialog(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Select Image"),
          children: [
            ListTile(
              title: Text("Photo Library"),
              leading: Icon(Icons.photo_library),
              onTap: () {
                _imageFormGallery(
                    context: context, onImageChose: onImageChose);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Camera"),
              leading: Icon(Icons.photo_camera),
              onTap: () {
                imageFromCamera(
                    context: context, onImageChose: onImageChose);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void openProfileImageChooser(
      {required BuildContext context,
        required Function onProfileChose,
        required Function onLogoChose}) {
    Platform.isIOS
        ? showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  title: Text("Select photo"),
                  onTap: () {
                    onProfileChose();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Select logo"),
                  onTap: () {
                    onLogoChose();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    )
        : showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Select Photo or Logo"),
          children: [
            ListTile(
              title: Text("Select photo"),
              onTap: () {
                Navigator.pop(context);
                onProfileChose();
              },
            ),
            ListTile(
              title: Text("Select logo"),
              onTap: () {
                Navigator.pop(context);
                onLogoChose();
              },
            ),
          ],
        );
      },
    );
  }

  */ /*void _imageFormGallery(
      {required BuildContext context, required Function onImageChose}) async {
    var status = await (Platform.isIOS
        ? Permission.storage.request()
        : Permission.mediaLibrary.request());
    if (status.isGranted) {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
        onImageChose(File(pickedFile.files.single.path!));
        print(pickedFile.files.single.path);
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: "Without this permission app can not change  picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: "Settings",
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : null,
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message:
              "To access this feature please grant permission from settings.",
          mainButton: SnackBarAction(
            label: "Settings",
            textColor: Colors.amber,
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
  }

  void imageFromCamera({
    required BuildContext context,
    required Function onImageChose,
  }) async {
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 100);
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.path));
        onImageChose(File(pickedFile.path));
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
                "Without this permission app can not change profile picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
                    label: "Settings",
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  )
                : SnackBarAction(
                    label: "Settings",
                    // textColor: Theme.of(context).accentColor,
                    onPressed: () {
                      openAppSettings();
                    },
                  ),
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
                "To access this feature please grant permission from settings.",
            mainButton: SnackBarAction(
              label: "Settings",
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3)),
      );
      return;
    }
  }*/ /*

  void _imageFormGallery(
      {required BuildContext context, required Function onImageChose}) async {
    var status = await (Platform.isIOS
        ? Permission.storage.request()
        : Permission.mediaLibrary.request());
    if (status.isGranted) {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
        XFile? photoCompressedFile =
        await compressImage(File(pickedFile.files.single.path!));
        onImageChose(File(photoCompressedFile!.path));
        print(pickedFile.files.single.path);
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message: "Without this permission app can not change  picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
              label: "Settings",
              // textColor: Theme.of(context).accentColor,
              onPressed: () {
                openAppSettings();
              },
            )
                : null,
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
          message:
          "To access this feature please grant permission from settings.",
          mainButton: SnackBarAction(
            label: "Settings",
            textColor: Colors.amber,
            onPressed: () {
              openAppSettings();
            },
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
  }

  Future<XFile?> compressImage(File file) async {
    final filePath = file.absolute.path;
    log("filePathfilePath--${filePath}");
    // String filePath = await HeicToJpg.convert(path);
    final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    if (lastIndex == filePath.lastIndexOf(RegExp(r'.png'))) {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
          filePath, outPath,
          minWidth: 1000,
          minHeight: 1000,
          quality: 50,
          format: CompressFormat.png);
      return compressedImage;
    } else {
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        minWidth: 1000,
        minHeight: 1000,
        quality: 50,
      );
      return compressedImage;
    }
  }

  void imageFromCamera(
      {required BuildContext context, required Function onImageChose}) async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 100);
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.path));
        XFile? photoCompressedFile = await compressImage(File(pickedFile.path));
        onImageChose(File(photoCompressedFile!.path));
      }
      return;
    } else if (status.isDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
            "Without this permission app can not change profile picture.",
            mainButton: Platform.isIOS
                ? SnackBarAction(
              label: "Settings",
              // textColor: Theme.of(context).accentColor,
              onPressed: () {
                openAppSettings();
              },
            )
                : SnackBarAction(
              label: "Settings",
              // textColor: Theme.of(context).accentColor,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3)),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      Get.showSnackbar(
        GetSnackBar(
            message:
            "To access this feature please grant permission from settings.",
            mainButton: SnackBarAction(
              label: "Settings",
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3)),
      );
      return;
    }
  }

  void pickFileFormStorage({
    required BuildContext context,
    required Function onFileChose,
  }) async {
    if (Platform.isIOS) {
      // Directly open file picker for iOS as it doesn't need manageExternalStorage permission
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );
      if (pickedFile != null) {
        onFileChose(File(pickedFile.files.single.path!));
        print(pickedFile.files.single.path);
      }
      return;
    } else {
      // Handle Android permissions
      PermissionStatus status =
      await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final FilePickerResult? pickedFile =
        await FilePicker.platform.pickFiles(
          type: FileType.any,
        );
        if (pickedFile != null) {
          onFileChose(File(pickedFile.files.single.path!));
          print(pickedFile.files.single.path);
        }
        return;
      } else if (status.isDenied) {
        Get.showSnackbar(
          GetSnackBar(
              message: "Without this permission app can not change  picture.",
              mainButton: Platform.isIOS
                  ? SnackBarAction(
                label: "Settings",
                // textColor: Theme.of(context).accentColor,
                onPressed: () {
                  openAppSettings();
                },
              )
                  : null,
              duration: Duration(seconds: 3)),
        );
        return;
      } else if (status.isPermanentlyDenied) {
        Get.showSnackbar(
          GetSnackBar(
            message:
            "To access this feature please grant permission from settings.",
            mainButton: SnackBarAction(
              label: "Settings",
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }
  }

  void pickStlFileFormStorage({
    required BuildContext context,
    required Function onFileChose,
  }) async {
    if (Platform.isIOS) {
      // Directly open file picker for iOS as it doesn't need manageExternalStorage permission
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'stl',
        ],
      );
      if (pickedFile != null) {
        onFileChose(File(pickedFile.files.single.path!));
        print(pickedFile.files.single.path);
      }
      return;
    } else {
      // Handle Android permissions
      PermissionStatus status =
      await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        final FilePickerResult? pickedFile =
        await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: [
            'stl',
          ],
        );
        if (pickedFile != null) {
          onFileChose(File(pickedFile.files.single.path!));
          print(pickedFile.files.single.path);
        }
        return;
      } else if (status.isDenied) {
        Get.showSnackbar(
          GetSnackBar(
              message: "Without this permission app can not change  picture.",
              mainButton: Platform.isIOS
                  ? SnackBarAction(
                label: "Settings",
                // textColor: Theme.of(context).accentColor,
                onPressed: () {
                  openAppSettings();
                },
              )
                  : null,
              duration: Duration(seconds: 3)),
        );
        return;
      } else if (status.isPermanentlyDenied) {
        Get.showSnackbar(
          GetSnackBar(
            message:
            "To access this feature please grant permission from settings.",
            mainButton: SnackBarAction(
              label: "Settings",
              textColor: Colors.amber,
              onPressed: () {
                openAppSettings();
              },
            ),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }
  }
}*/
