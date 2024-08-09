import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/model/comment_model.dart';
import 'package:lynerdoctor/model/patient_details_model.dart';
import 'package:lynerdoctor/model/patient_treatment_model.dart';
import 'package:lynerdoctor/model/prescription_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class PatientsDetailsController extends GetxController {
  int selectedScreen = 0;
  bool isLoading = false;
  int patientId = 0;
  int patientTreatmentId = 0;
  TextEditingController commentController = TextEditingController();
  TextEditingController nextVisitController = TextEditingController();
  TextEditingController treatmentNoteController = TextEditingController();
  PatientDetailsModel? patientDetailsModel;
  RxBool isShowLink = false.obs;
  PrescriptionData? prescriptionData;
  List<CommentModel?> commentModelList = [];
  List<PatientTreatmentModel?> patientTreatmentModelList = [];
  double uploadProgress = 0.0;
  String? uploadId;
  bool isDcomFileLoading = false;
  var taskId;
  var progress;

  @override
  void onInit() {
    patientId = Get.arguments ?? 0;
    getPatientCommentsDetails();
    getPatientInformationDetails();
    bindBackgroundIsolate();
    super.onInit();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  void changeData({int? selectedIndex}) {
    selectedScreen = selectedIndex ?? selectedScreen;
    update();
  }

  getPatientInformationDetails() async {
    isLoading = true;
    ResponseItem result =
        await PatientsRepo.getPatientInformationDetails(patientId: patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          patientDetailsModel = PatientDetailsModel.fromJson(result.data);
          isShowLink.value =
              patientDetailsModel?.patient3DModalLink?.isNotEmpty ?? false;
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  getPatientTreatmentsDetails() async {
    isLoading = true;
    ResponseItem result =
        await PatientsRepo.getPatientTreatmentsDetails(patientId: patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          patientTreatmentModelList.clear();
          PatientTreatmentResponseModel patientTreatmentResponseModel =
              PatientTreatmentResponseModel.fromJson(result.toJson());
          if (patientTreatmentResponseModel.patientTreatmentModel != null) {
            patientTreatmentModelList
                .addAll(patientTreatmentResponseModel.patientTreatmentModel!);
          }
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      log("error ------> $e");
    }
    update();
  }

  getPatientPrescriptionDetails() async {
    isLoading = true;
    ResponseItem result =
        await AddPatientRepo.getPatientPrescriptionDetails(patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          prescriptionData = PrescriptionData.fromJson(result.data);
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      log("error ------> $e");
    }
    update();
  }

  getPatientCommentsDetails() async {
    isLoading = true;
    commentModelList.clear();
    ResponseItem result =
        await PatientsRepo.getPatientCommentsDetails(patientId: patientId);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          List commentDataList = result.data as List;
          for (int i = 0; i < commentDataList.length; i++) {
            CommentModel? commentModel =
                CommentModel.fromJson(commentDataList[i]);
            commentModelList.add(commentModel);
          }
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
      log("error ------> $e");
    }
    update();
  }

  Future<bool> addEditPatientTreatments(
      {bool isEdit = false, required BuildContext context}) async {
    bool isEditOrAdd = false;
    hideKeyBoard(context);
    if (nextVisitController.text.isEmpty) {
      showAppSnackBar("Please enter next visit.");
    } else if (treatmentNoteController.text.isEmpty) {
      showAppSnackBar("Please enter treatment notes.");
    } else {
      isLoading = true;
      commentModelList.clear();
      ResponseItem result = await PatientsRepo.addEditPatientTreatments(
        patientId: patientId,
        treatmentNotes: treatmentNoteController.text.trim(),
        nextVisit: nextVisitController.text.trim(),
        isEdit: isEdit,
        patientTreatmentId: patientTreatmentId,
      );
      isLoading = false;
      try {
        if (result.status) {
          if (result.data != null) {
            isEditOrAdd = true;
            isLoading = false;
          }
        } else {
          isLoading = false;
        }
        showAppSnackBar(result.msg);
      } catch (e) {
        showAppSnackBar(result.msg);
        isLoading = false;
        log("error ------> $e");
      }
    }
    update();
    return isEditOrAdd;
  }

  Future<bool> deletePatientTreatments() async {
    isLoading = true;
    bool isDelete = false;
    commentModelList.clear();
    ResponseItem result = await PatientsRepo.deletePatientTreatments(
        patientTreatmentId: patientTreatmentId);
    try {
      if (result.status) {
        isDelete = true;
        isLoading = false;
      } else {
        isLoading = false;
      }
      showAppSnackBar(result.msg);
    } catch (e) {
      showAppSnackBar(result.msg);
      isLoading = false;
      log("error ------> $e");
    }
    update();
    return isDelete;
  }

  Future<void> uploadFile(File file, var patientId) async {
    isDcomFileLoading = true;
    uploadProgress = 0.0;
    update();
    // Generate unique upload ID if not already set
    if (uploadId == null) {
      uploadId = generateUploadId();
    }
    // Determine file extension
    String fileExtension = getFileExtension(file);
    // Split file into chunks
    int chunkSize = 10 * 1024 * 1024; // 1 MB chunks
    int totalChunks = (file.lengthSync() / chunkSize).ceil();

    RandomAccessFile raf = await file.open();
    bool allChunksUploaded = true; // Track overall success

    try {
      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > file.lengthSync()) {
          end = file.lengthSync();
        }

        raf.setPositionSync(start);
        List<int> chunkBytes = raf.readSync(end - start);

        // Write chunk to temporary file
        File chunkFile = File('${file.path}_chunk_$i');
        await chunkFile.writeAsBytes(chunkBytes);
        for (int j = 0; j < 100; j++) {
          await Future.delayed(Duration(milliseconds: 10));
          uploadProgress = (i + j / 100) / totalChunks;
          update();
        }
        ResponseItem result = await AddPatientRepo.uploadPatientDcomFile(
          file: chunkFile,
          chunkIndex: '$i',
          extension: fileExtension,
          totalChunks: '$totalChunks',
          uploadId: uploadId,
          patientId: patientId.toString(),
        );
        if (!result.status) {
          // Handle failure
          showAppSnackBar('Chunk $i upload failed: ${result.msg}');
          allChunksUploaded = false; // Set overall success to false
          break; // Exit loop on failure
        }
        uploadProgress = (i + 1) / totalChunks;
        update();
        // Delete temporary chunk file
        await chunkFile.delete();
      }
      uploadProgress = 1.0;
      update();
    } catch (e) {
      // Handle exceptions
      showAppSnackBar('File upload failed: $e');
      allChunksUploaded = false; // Set overall success to false
    } finally {
      await raf.close();
      // Reset uploadId for next upload
      uploadId = null;
      isDcomFileLoading = false;
      update();
      // Show final success or failure message
      if (allChunksUploaded) {
        showAppSnackBar('File uploaded successfully');
      } else {
        showAppSnackBar('File upload failed');
      }
    }
  }

  String getFileExtension(File file) {
    String fileName = file.path;
    int dotIndex = fileName.lastIndexOf('.');
    return (dotIndex != -1) ? fileName.substring(dotIndex + 1) : '';
  }

  String generateUploadId() {
    var uuid = Uuid();
    return uuid.v4();
  }

  // Future<void> downloadFile(String url) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final savedDir = directory.path;
  //
  //   taskId = await FlutterDownloader.enqueue(
  //     url: url,
  //     savedDir: savedDir,
  //     fileName: '147_3823311178_147.svg',
  //     // Optional: specify the name of the file
  //     showNotification: true,
  //     // Show download progress in notification bar
  //     openFileFromNotification: true, // Click on notification to open the file
  //   );
  //   update();
  // }
  Future<void> downloadFile(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final savedDir = directory.path;
    final filePath = '$savedDir/downloaded_file.svg';

    // Delete existing partial file
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }

    taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedDir,
      fileName: 'downloaded_file.svg', // Specify the correct file extension
      showNotification: true,
      openFileFromNotification: true,
    );

    update();
  }
  void bindBackgroundIsolate() {
    final port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        port.sendPort, 'downloader_send_port');
    port.listen((dynamic data) {
      taskId = data[0];
      int status = data[1];
      progress = data[2];
    });
    update();
  }
}
