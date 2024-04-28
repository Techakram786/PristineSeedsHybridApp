import 'dart:convert';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';

import '../../constants/static_methods.dart';
import '../../local_database/inspection/OnlineInspectionDatabase.dart';
import '../../models/common_api_response.dart';
import '../../models/online_inspection_model/OfflineInspectionResponse.dart';
import '../../repository/online_inspection_repositry/OnlineInspectionrepository.dart';
import '../../utils/app_utils.dart';
import '../dash_board_vm/DashboardVM.dart';
class ProfileViewModel extends GetxController{
  final _api = OnlineOfflineInspectionRepository();
  final sessionManagement=SessionManagement();
  final OnlineInspectionDatabase _database = OnlineInspectionDatabase();
  RxBool loading = false.obs;
  String email='';
  String name='';
  String company_id='';
  String userRole='';
  String? version_name='';
  String? version_code='';


  @override
  void onInit()async {
    email=await sessionManagement.getEmail() ?? '';
    name=await sessionManagement.getName() ?? '';
    company_id=await sessionManagement.getCompanyId() ?? '';
    userRole=await sessionManagement.getRoleName() ?? '';
    super.onInit();
    //getEmployeeMasterDetailsApi();
    getVersionNameAndCode();
  }

  Future<void> getVersionNameAndCode()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version_name = packageInfo.version;
    version_code = packageInfo.buildNumber;
  }

  Future<void> logout()async {
    try{
      syncOfflineDataPushToApiAfterThatGetData();
    }
    catch(e){
      StaticMethod.stopBackgroundService();
      Utils.sanckBarError('Api Hitting Exception', e.toString());
      sessionManagement.clearSession();
      Get.offAllNamed(RoutesName.loginScreen);
    }
  }


  Future<void> syncOfflineDataPushToApiAfterThatGetData() async {

    bool isConnected = await StaticMethod.checkInternetConnectivity();
    if (isConnected) {
      loading.value = true;
      List<OfflineInspectionResponse> alloffline_lot_list = await _database.getAllOfflineInspectionCompleteData();
      List<Map<String, dynamic>> hit_payload = [];

      if(alloffline_lot_list.length>0){
        for (int i = 0; i < alloffline_lot_list.length; i++) {
          List<InspectionDetail>? inspectionDetail =alloffline_lot_list[i].inspectionDetail!.where((element) => element.isDone!>0).toList();
          for (int j = 0; j < inspectionDetail!.length; j++) {
            List<Map<String, String>> data_line = [];
            for (int k = 0; k < inspectionDetail![j].fields!.length;
            k++) {
              data_line.add({
                "inspection_type_id": (inspectionDetail![j].fields![k].inspectionTypeId ??
                    '')
                    .toString(),
                "inspection_type": inspectionDetail![j].fields![k].inspectionType ??
                    '',
                "inspection_field_id": (inspectionDetail![j].fields![k].inspectionFieldId ??
                    '')
                    .toString(),
                "field_name":inspectionDetail![j].fields![k].fieldName ??
                    '',
                "field_value": inspectionDetail![j].fields![k].fieldValue ??
                    ''
              });
            }

            hit_payload.add({
              "inspection_flag": "Offline",
              "planting_no":
              inspectionDetail![j]!.plantingNo ?? '',
              "line_no": (inspectionDetail![j]!.lineNo ?? '')
                  .toString(),
              "inspection_type_id":
              (inspectionDetail![j]!.inspectionTypeId ??
                  '')
                  .toString(),
              "inspection_type_name":
              inspectionDetail![j]!.inspectionTypeName ??
                  '',
              "production_lot_no":
              inspectionDetail![j]!.productionLotNo ?? '',
              "email_id": email,
              "fields": data_line
            });
          }
        }

        _api.inspectionComplete(hit_payload, sessionManagement).then((value) async {
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<CommaonApiModel> response = jsonResponse
                  .map((data) => CommaonApiModel.fromJson(data))
                  .toList();
              if (response != null && response.length > 0 && response[0].condition.toString() == "True") {

                loading.value = false;
                Utils.sanckBarSuccess('Message True!', response[0].message.toString());
                //todo stop background service
                StaticMethod.stopBackgroundService();

                //todo delete my local database....
                await _database.deleteMyLocalDatabase();
                sessionManagement.clearSession();
                Get.offAllNamed(RoutesName.loginScreen);
              }
              else {
                Utils.sanckBarError('Message False!', response[0].message.toString());
                loading.value = false;
              }
            }
          } catch (e) {
            Utils.sanckBarError('Message Exception!', e.toString());
            loading.value = false;
          }
        }).onError((error, stackTrace) {
          Utils.sanckBarError('Api Exception onError', error.toString());
          print(error);
        }).whenComplete(() {
          loading.value = false;
        });
      }
      else{
        await _database.deleteMyLocalDatabase();
        sessionManagement.clearSession();
        Get.offAllNamed(RoutesName.loginScreen);
      }
    }
    else{
      Utils.sanckBarError('Internet Connection!', 'Internet Not Available,Please Check Your Connection!');
    }
  }
}