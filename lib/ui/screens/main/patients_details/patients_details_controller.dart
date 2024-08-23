import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/comment_model.dart';
import 'package:lynerdoctor/model/patient_details_model.dart';
import 'package:lynerdoctor/model/patient_treatment_model.dart';
import 'package:lynerdoctor/model/prescription_model.dart';
import 'package:lynerdoctor/ui/screens/main/patients/patients_controller.dart';
import 'package:lynerdoctor/ui/widgets/common_dialog.dart';
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
  CommentModel? commentModel;
  List<CommentModel?> commentModelList = [];
  List<PatientTreatmentModel?> patientTreatmentModelList = [];
  double uploadProgress = 0.0;
  String? uploadId;
  bool isCommentFileLoading = false;
  bool showProgressDialog = false;
  File? commentFile;
  String commentFileName = "Upload Comment File";
  var taskId;
  var progress;

  int selectedScreenIndex = 0;
  double progressValue = 0.0;

  @override
  void onInit() {
    patientId = Get.arguments ?? 0;
    getPatientCommentsDetails();
    getPatientInformationDetails();
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

  Future<bool> addTextPatientComments() async {
    isLoading = true;
    bool isAddTextComment = false;
    ResponseItem result = await PatientsRepo.addTextPatientComments(
      patientId: patientId,
      comment: commentController.text.trim(),
    );
    try {
      if (result.status) {
        isAddTextComment = true;
        commentController.clear();
      }
      isLoading = false;
      showAppSnackBar(result.msg);
    } catch (e) {
      isLoading = false;
      log("error ------> $e");
    }
    update();
    return isAddTextComment;
  }

  String getFileName(String? filePath, int length) {
    if (filePath == null || filePath.isEmpty) return "Upload Comment File";
    return filePath.length > length
        ? filePath.substring(filePath.length - length)
        : filePath;
  }

  Future<bool> uploadCommentFile(File file, var patientId) async {
    bool isUploadFile = false;
    isCommentFileLoading = true;

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
        ResponseItem result = await PatientsRepo.uploadCommentFileFile(
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
      isCommentFileLoading = false;
      update();
      // Show final success or failure message
      if (allChunksUploaded) {
        isUploadFile = true;
        showAppSnackBar('File uploaded successfully');
      } else {
        showAppSnackBar('File upload failed');
      }
    }
    return isUploadFile;
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

  void setProgressValue({double? downloadProgress, bool? showDialogProgress}) {
    progressValue = downloadProgress ?? progressValue;
    showProgressDialog = showDialogProgress ?? showProgressDialog;
    log('downloadProgress ---------------> $downloadProgress');
    if (progressValue == 100) {
      progressValue = 0.0;
      showProgressDialog = false;
    }
    update();
  }

  void deletePatient(String patientId, int? adminArchive) {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return CommonDialog(
          dialogBackColor: Colors.white,
          tittleText: adminArchive != 0 ? "UnArchive" : "Archive",
          buttonText: LocaleKeys.confirm.translateText,
          buttonCancelText: LocaleKeys.cancel.translateText,
          descriptionText:
              "Are you sure you want to ${adminArchive != 0 ? "UnArchive" : "Archive"} this patient?",
          cancelOnTap: () => Get.back(),
          onTap: () {
            callDeletePatientApi(patientId);
            Get.find<PatientsController>().getClinicListBySearchOrFilter();
            isLoading =false;
            Get.back();
          },
          alignment: Alignment.center,
        );
      },
    );
  }

  void callDeletePatientApi(String patientId) async {
    isLoading = true;
    Get.back();
    ResponseItem result = await PatientsRepo.deletePatient(
      patientId: patientId,
    );
    try {
      if (result.status) {
        showAppSnackBar(result.msg);

        // patientList.clear();
        // getClinicListBySearchOrFilter();
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }
}
