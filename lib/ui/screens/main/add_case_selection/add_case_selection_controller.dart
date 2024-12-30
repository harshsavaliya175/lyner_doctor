import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/api/case_repo/case_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/shared_prefs.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/model/case_model.dart';
import 'package:uuid/uuid.dart';

class AddCaseSelectionController extends GetxController {
  int currentStep = 0;
  bool isLoading = false;
  bool isStepOneComplete = false;
  List<File> smileImg = [];
  File? profileImageFile;
  File? faceImageFile;
  File? smileImageFile;
  File? intraRightImageFile;
  File? intraLeftImageFile;
  File? intraMaxImageFile;
  File? intraMandImageFile;
  File? intraFaceImageFile;
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
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController patientRequestController = TextEditingController();
  TextEditingController treatmentGoalController = TextEditingController();

  CaseModel? caseModel;
  int? caseId;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      caseId = Get.arguments[caseIdString];
    }

    print("--------------- Case Id : $caseId");

    if (caseId != null) {
      isLoading = true;
      await getPatientInformationDetails();
      if (caseModel?.photos?.dcomFileName != null &&
          caseModel!.photos!.dcomFileName!.isNotEmpty) {
        dicomFileName = getFileName(caseModel!.photos!.dcomFileName, 20);
      }
    }
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

  Future<void> getPatientInformationDetails() async {
    ResponseItem result = await AddCaseRepo.getCaseSelection(id: caseId ?? 0);
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          CaseSelectionModel caseSelectionModel =
              CaseSelectionModel.fromJson(result.toJson());
          caseModel = caseSelectionModel.caseModel;
          firstNameController.text = caseModel?.firstName ?? '';
          lastNameController.text = caseModel?.lastName ?? '';
          patientRequestController.text = caseModel?.patientRequest ?? "";
          treatmentGoalController.text = caseModel?.treatmentObjectives ?? "";
          if (caseModel?.dateOfBirth != null) {
            dateTextField = DateFormat(
              'dd/MM/yyyy',
              (preferences.getString(SharedPreference.LANGUAGE_CODE) ?? '')
                      .isNotEmpty
                  ? preferences.getString(SharedPreference.LANGUAGE_CODE)
                  : 'fr',
            ).format(caseModel!.dateOfBirth!);
            dateOfBirthController.text = dateTextField!;
          } else {
            dateOfBirthController.text = '';
          }

          upperJawImageFileTextCtrl.text =
              caseModel?.photos?.upperJawStlFile ?? '';
          lowerJawImageFileTextCtrl.text =
              caseModel?.photos?.lowerJawStlFile ?? '';
          print(isUploadStl);
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

  Future<void> addCaseInformation() async {
    isLoading = true;
    ResponseItem result = await AddCaseRepo.addCase(
      dateOfBirth: dateOfBirthController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      patientRequest: patientRequestController.text.trim(),
      treatmentGoal: treatmentGoalController.text.trim(),
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          CaseSelectionModel caseData =
              CaseSelectionModel.fromJson(result.toJson());
          caseModel = caseData.caseModel;
          caseId = caseModel!.id;
          print(caseModel);
          showAppSnackBar(
              LocaleKeys.addPatientRecordSuccessfully.translateText);
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

  Future<void> editCaseInformation({
    int isDraft = 1,
    bool? isBack,
  }) async {
    isLoading = true;
    ResponseItem result = await AddCaseRepo.editCase(
      id: caseId.toString(),
      dateOfBirth: dateOfBirthController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      patientRequest: patientRequestController.text.trim(),
      treatmentGoal: treatmentGoalController.text.trim(),
      isDraft: isDraft,
    );
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          CaseSelectionModel caseData =
              CaseSelectionModel.fromJson(result.toJson());
          caseModel = caseData.caseModel;
          caseId = caseModel!.id;
          print(caseModel);
          if (isBack != null && isBack) {
            Get.back();
          }
          // showAppSnackBar(
          //     LocaleKeys.addPatientRecordSuccessfully.translateText);
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

  bool validateUploadPhotoFiles() {
    if (profileImageFile == null &&
        (caseModel?.photos?.gauche == null || caseModel?.photos?.gauche == ''))
      return false;
    if (faceImageFile == null &&
        (caseModel?.photos?.face == null || caseModel?.photos?.face == ''))
      return false;
    if (smileImageFile == null &&
        (caseModel?.photos?.sourire == null ||
            caseModel?.photos?.sourire == '')) return false;
    if (intraMaxImageFile == null &&
        (caseModel?.photos?.interMax == null ||
            caseModel?.photos?.interMax == '')) return false;
    if (intraMandImageFile == null &&
        (caseModel?.photos?.interMandi == null ||
            caseModel?.photos?.interMandi == '')) return false;
    if (intraRightImageFile == null &&
        (caseModel?.photos?.interDroite == null ||
            caseModel?.photos?.interDroite == '')) return false;
    if (intraLeftImageFile == null &&
        (caseModel?.photos?.interGauche == null ||
            caseModel?.photos?.interGauche == '')) return false;
    if (intraFaceImageFile == null &&
        (caseModel?.photos?.interFace == null ||
            caseModel?.photos?.interFace == '')) return false;
    if (isUploadStl) {
      if (upperJawImageFile == null &&
          (caseModel?.photos?.upperJawStlFile == null ||
              caseModel?.photos?.upperJawStlFile == '')) return false;
      if (lowerJawImageFile == null &&
          (caseModel?.photos?.lowerJawStlFile == null ||
              caseModel?.photos?.lowerJawStlFile == '')) return false;
    }
    return true;
  }

  Future<void> uploadCaseSingleImage({
    File? file,
    required String paramName,
  }) async {
    isLoading = false;
    ResponseItem result = await AddCaseRepo.uploadCaseSingleImage(
      file: file,
      paramName: paramName,
      id: caseModel?.id.toString() ?? "",
      dateOfBirth: dateOfBirthController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      patientRequest: dateOfBirthController.text.trim(),
      treatmentObjectives: dateOfBirthController.text.trim(),
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

  Future<void> uploadCaseMultipleImage({required List<File> files}) async {
    isLoading = false;
    ResponseItem result = await AddCaseRepo.uploadCaseMultipleImage(
      imageList: files,
      id: caseModel?.id.toString() ?? '',
      dateOfBirth: dateOfBirthController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      patientRequest: dateOfBirthController.text.trim(),
      treatmentObjectives: dateOfBirthController.text.trim(),
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

  Future<void> uploadDicomFile(
    File file,
    // String forWhat,
  ) async {
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
        ResponseItem result = await AddCaseRepo.uploadCaseDcomFile(
          file: chunkFile,
          chunkIndex: '$i',
          extension: fileExtension,
          totalChunks: '$totalChunks',
          uploadId: uploadId,
          caseSelectionId: caseModel?.id.toString(),
          // forWhat: forWhat,
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
