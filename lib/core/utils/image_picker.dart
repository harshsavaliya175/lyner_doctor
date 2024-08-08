import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

ImageUploadUtils imageUploadUtils = ImageUploadUtils();

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
  }

  void pickFileFormStorage({
    required BuildContext context,
    required Function onFileChose,
  }) async {
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.any,
        // allowedExtensions: ['doc', 'pdf','zip',],
      );
      if (pickedFile != null) {
        // controller.addImage(File(pickedFile.files.single.path!));
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
