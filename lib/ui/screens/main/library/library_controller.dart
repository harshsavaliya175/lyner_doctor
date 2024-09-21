import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/library_list_model.dart';

import 'video/video_screen.dart';

class LibraryController extends GetxController {
  bool isLoading = false;
  List<LibraryListData> libraryListData = [];
  String pdfPath = '';
  String youtubeUrl = '';

  // late YoutubePlayerController youtubeController;

/*  void initializeYoutubePlayer() {
    String? videoId = YoutubePlayer.convertUrlToId(youtubeUrl);
    if (videoId != null) {
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      print("Failed to extract video ID from URL");
    }
  }

  @override
  void onClose() {
    youtubeController.dispose();
    super.onClose();
  }*/

  void loadYoutubeUrl(String url) {
    youtubeUrl = url;
    Get.to(() => VideoScreen());
    update();
  }

  // Future<void> loadPdfFromUrl(String url) async {
  //   isLoading = true;
  //   update();
  //   try {
  //     PermissionStatus status = await Permission.manageExternalStorage.status;
  //     if (status.isGranted) {
  //       await downloadAndOpenPdf(url);
  //     } else if (status.isDenied || status.isRestricted) {
  //       PermissionStatus result = await Permission.storage.request();
  //       if (result.isGranted) {
  //         await downloadAndOpenPdf(url);
  //       } else if (result.isDenied) {
  //         showAppSnackBar(LocaleKeys
  //             .permissionDeniedStoragePermissionIsRequiredToDownloadAndOpenPDFFiles
  //             .translateText);
  //       } else if (result.isPermanentlyDenied) {
  //         // Permission permanently denied, direct user to settings
  //         showAppSnackBar(LocaleKeys
  //             .permissionPermanentlyDeniedPleaseEnableStoragePermissionInSettings
  //             .translateText);
  //         openAppSettings();
  //       }
  //     } else if (status.isPermanentlyDenied) {
  //       showAppSnackBar(LocaleKeys
  //           .permissionPermanentlyDeniedPleaseEnableStoragePermissionInSettings
  //           .translateText);
  //       openAppSettings();
  //     } else if (status.isRestricted) {
  //       // Permission is restricted on this device (like parental controls)
  //       showAppSnackBar(LocaleKeys
  //           .permissionRestrictedStoragePermissionIsRestrictedOnThisDevice
  //           .translateText);
  //     }
  //   } catch (e) {
  //     showAppSnackBar("Error : ${e.toString()}");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
  //
  // Future<void> downloadAndOpenPdf(String url) async {
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       var tempDir = await getTemporaryDirectory();
  //       var file = File('${tempDir.path}/downloaded.pdf');
  //       await file.writeAsBytes(response.bodyBytes);
  //       pdfPath = file.path;
  //       OpenResult result = await OpenFile.open(file.path);
  //       print(result);
  //     } else {
  //       throw Exception('Failed to load PDF');
  //     }
  //   } catch (e) {
  //     showAppSnackBar("Error : ${e.toString()}");
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    getLibraryListApi();
  }

  void getLibraryListApi() async {
    libraryListData.clear();
    isLoading = true;
    ResponseItem result = await PatientsRepo.getLibraryList();
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          LibraryListModel libraryListModel =
              LibraryListModel.fromJson(result.toJson());
          libraryListData.addAll(libraryListModel.data!);
          isLoading = false;
          print(libraryListModel);
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }
}
