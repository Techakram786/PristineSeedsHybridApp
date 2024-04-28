import 'dart:convert';

import 'package:get/get.dart';

import '../../local_database/DatabaseHelper.dart';
import '../../models/common_response/common_resp.dart';
import '../../models/location/LocationData.dart';
import '../../repository/background_service_repository/BackGroundServiceRepository.dart';
import '../session_management/session_management_controller.dart';
class BackgroundServiceVM extends GetxController{
  final _api = BackGroundServiceRepository();
  final SessionManagement sessionManagement = SessionManagement();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final RxString email = "".obs;
  RxBool loading = false.obs;
  String curretn_date = '';
  String created_by = '';
  RxString checkin_response = ''.obs;
  List<LocationData> locationDataList = [];
  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;


 /* Future<void> insertLocationCoordinates(List<LocationData> location_list, String type) async {
    loading.value = true;
    currentLat.value=location_list[0].latitude;
    currentLng.value=location_list[0].longitude;
    current_status.value='Fetched';
    print(currentLat);
    List<Map<String, String>> jsonList = [];
    for (var item in location_list) {
      Map<String, String> aa = {
        "start_date": curretn_date,
        "from_latitude": item.latitude.toString(),
        "from_longitude": item.longitude.toString(),
        "from_locality": item.locality!.toString() ?? '',
        "from_area": item.area!.toString() ?? '',
        "from_postal_code": item.postal_code!.toString() ?? '',
        "from_country": item.country!.toString() ?? '',
        "created_by": email.value
      };
      jsonList.add(aa);
    }

    _api.userLocationInsertApiHit(jsonList, sessionManagement)
        .then((value) async {
      try {
        loading.value = false;
        List<CommonResponse> common_response = (json.decode(value) as List)
            .map((i) => CommonResponse.fromJson(i))
            .toList();
        if (common_response[0].condition.toString() == "True") {
          //Utils.sanckBarSuccess('True Message!', common_response[0].message.toString());
          //todo delete the location table
          if (type == 'OfflineTable') {
            await _databaseHelper.deleteAllLocationData();
            print("deleted data from table :" + locationDataList.toString());
          }
        } else {
          Utils.sanckBarError('False Message!', common_response[0].message.toString());
        }
      } catch (e) {
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }*/

  Future<void> getLatLngFromBackGroundService(double latitude, double longitude) async {
    print('backgroundLatitude: $latitude, backgroundLongitude: $longitude');
  }
}