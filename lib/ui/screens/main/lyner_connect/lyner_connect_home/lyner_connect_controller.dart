import 'package:get/get.dart';
import 'package:lynerdoctor/api/patients_repo/patients_repo.dart';
import 'package:lynerdoctor/api/response_item_model.dart';
import 'package:lynerdoctor/model/lyner_connect_list_model.dart';

class LynerConnectController extends GetxController {
  bool isLoading = false;
  List<LynerConnectList?> lynerConnectList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLynerConnectList();
  }

  void getLynerConnectList() async {
    ResponseItem result = await PatientsRepo.getLynerConnectList();
    isLoading = false;
    try {
      if (result.status) {
        if (result.data != null) {
          LynerConnectListModel lynerConnectListModel =
              LynerConnectListModel.fromJson(result.toJson());
          lynerConnectList.addAll(lynerConnectListModel.data!);
          print(lynerConnectList);
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
}
