import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/add_patient_repo/add_patient_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:uuid/uuid.dart';

class AddCaseSelectionController extends GetxController {
  int currentStep = 0;
  bool isLoading = false;
  bool isStepOneComplete = false;

  File? intraRightImageFile;
  File? intraLeftImageFile;
  File? intraFaceImageFile;
  File? faceImageFile;
  File? radiosFirstImageFile;
  File? radiosSecondImageFile;
  TextEditingController upperJawImageFileTextCtrl = TextEditingController();
  TextEditingController lowerJawImageFileTextCtrl = TextEditingController();
  File? upperJawImageFile;
  File? lowerJawImageFile;
  File? dicomFile;

  bool isUploadStl = false;
  bool isDcomFileLoading = false;
  double uploadProgress = 0.0;
  String? uploadId;
  String dicomFileName = LocaleKeys.uploadDICOMFile.translateText;
  DateTime? pickedDate;
  String? dateTextField;
  GlobalKey<FormState> patientInformationFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController patientRequestController = TextEditingController();
  TextEditingController treatmentGoalController = TextEditingController();
  Map<int, bool> stepErrors = <int, bool>{};

  @override
  void onInit() {
    super.onInit();
  }

  void changeData({bool? isStepOneComplete, int? step}) {
    this.isStepOneComplete = isStepOneComplete ?? this.isStepOneComplete;
    this.currentStep = step ?? this.currentStep;
    update();
  }

  String getFileName(String? filePath, int length) {
    if (filePath == null || filePath.isEmpty)
      return LocaleKeys.uploadDICOMFile.translateText;
    return filePath.length > length
        ? filePath.substring(filePath.length - length)
        : filePath;
  }

  Future<void> uploadPatientSingleImage({File? file, String? paramName}) async {
    isLoading = false;
    ResponseItem result = await AddPatientRepo.uploadPatientSingleImage(
      file: file,
      paramName: paramName,

      /// todo change : when api is created
      patientId: "patientData?.patientId.toString()",
    );
    isLoading = false;
    try {
      if (result.status) {
        isLoading = false;
      } else {
        isLoading = false;
      }
    } catch (e) {
      isLoading = false;
    }
    update();
  }

  Future<void> uploadDicomFile(File file, String forWhat) async {
    isDcomFileLoading = true;
    uploadProgress = 0.0;
    update();

    if (uploadId == null) {
      uploadId = generateUploadId();
    }

    String fileExtension = getFileExtension(file);

    int chunkSize = 10 * 1024 * 1024;
    int totalChunks = (file.lengthSync() / chunkSize).ceil();

    RandomAccessFile raf = await file.open();
    bool allChunksUploaded = true;

    try {
      for (int i = 0; i < totalChunks; i++) {
        int start = i * chunkSize;
        int end = start + chunkSize;
        if (end > file.lengthSync()) {
          end = file.lengthSync();
        }

        raf.setPositionSync(start);
        List<int> chunkBytes = raf.readSync(end - start);

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

          /// todo : add patient id when api calling
          patientId:
              "patientData?.patientId.toString() ?? patientId.toString()",
          forWhat: forWhat,
        );
        if (!result.status) {
          showAppSnackBar('Chunk $i upload failed: ${result.msg}');
          allChunksUploaded = false;
          break;
        }
        uploadProgress = (i + 1) / totalChunks;
        update();
        await chunkFile.delete();
      }
      uploadProgress = 1.0;
      update();
    } catch (e) {
      showAppSnackBar('File upload failed: $e');
      allChunksUploaded = false;
    } finally {
      await raf.close();

      uploadId = null;
      isDcomFileLoading = false;
      update();

      if (allChunksUploaded) {
        showAppSnackBar(LocaleKeys.fileUploadedSuccessfully.translateText);
      } else {
        showAppSnackBar(LocaleKeys.fileUploadFailed.translateText);
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
}
