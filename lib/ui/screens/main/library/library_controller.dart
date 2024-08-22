import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/model/library_list_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryController extends GetxController {
  bool isLoading = false;
  List<LibraryListData> libraryListData = [];
  var pdfPath = '';
  Future<void> loadPdfFromUrl(String url) async {
    isLoading = true;
    update();
    try {
      PermissionStatus status = await Permission.storage.status;
      if (status.isGranted) {
        await downloadAndOpenPdf(url);
      } else if (status.isDenied || status.isRestricted) {
        PermissionStatus result = await Permission.storage.request();
        if (result.isGranted) {
          await downloadAndOpenPdf(url);
        } else if (result.isDenied) {
          showAppSnackBar( 'Permission Denied : Storage permission is required to download and open PDF files.');
        } else if (result.isPermanentlyDenied) {
          // Permission permanently denied, direct user to settings
          showAppSnackBar( 'Permission Permanently Denied : Please enable storage permission in settings.');
          openAppSettings();
        }
      } else if (status.isPermanentlyDenied) {
        showAppSnackBar('Permission Permanently Denied : Please enable storage permission in settings.');
        openAppSettings();
      } else if (status.isRestricted) {
        // Permission is restricted on this device (like parental controls)
        showAppSnackBar( 'Permission Restricted : Storage permission is restricted on this device.');
      }
    } catch (e) {
      showAppSnackBar( "Error : ${e.toString()}");
    } finally {
      isLoading = false;
      update();
    }
  }
  Future<void> downloadAndOpenPdf(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var tempDir = await getTemporaryDirectory();
        var file = File('${tempDir.path}/downloaded.pdf');
        await file.writeAsBytes(response.bodyBytes);
        pdfPath = file.path;
        OpenResult result = await OpenFile.open(file.path);
        print(result);
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      showAppSnackBar( "Error : ${e.toString()}");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
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
          LibraryListModel libraryListModel = LibraryListModel.fromJson(result.toJson());
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
