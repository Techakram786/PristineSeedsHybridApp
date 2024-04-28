import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/repository/dash_board_repo/dash_board_repo.dart';
import '../../current_location/background_task.dart';
import '../../firebase/firebase_api.dart';
import '../../local_database/DatabaseHelper.dart';
import '../../main.dart';
import '../../models/common_response/common_resp.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/location/LocationData.dart';
import '../../models/profile/profile_upload_model.dart';
import '../../resourse/appUrl/app_url.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

class DashboardVM extends GetxController with WidgetsBindingObserver {
  static BackgroundService? backgroundService;
  final _api = DashBoardRepository();
  SessionManagement sessionManagement = SessionManagement();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //RxString  pickedImage= ''.obs;

  RxString imageUrl = ''.obs;
  final RxString clusterId = "".obs;
  final RxString email = "".obs;
  final RxString profile_pic = "".obs;
  final RxString picked_pic = "".obs;
  RxBool loading = false.obs;
  String curretn_date = '';
  String created_by = '';
  RxString checkin_response = ''.obs;
  RxString shift_start_time = ''.obs;
  RxString shift_end_time = ''.obs;
  List<LocationData> locationDataList = [];
  static RxDouble currentLat = 0.0.obs;
  static RxDouble currentLng = 0.0.obs;
  RxString current_status = 'Fetching'.obs;
  StreamSubscription<Position>? positionStream = null;

  String phone = '';
  String emp_id = '';
  String designation = '';
  String department = '';
  String employee_id = '';
  String grade = '';
  String shift = '';
  String manager_id = '';
  String state = '';
  String country = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    backgroundService = BackgroundService(sessionManagement);
    backgroundService!.initializeService();

    curretn_date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    email.value = await sessionManagement.getEmail() ?? ''; // await getEmail
    imageUrl.value = await sessionManagement.getProfile() ?? '';
    //todo firebase token update
    String firebase_token =await FirebaseApi().initNotification();
    print(firebase_token);
    /*String session_firebase_token= await sessionManagement.getFirebaseToken();
    if(session_firebase_token!=firebase_token){
      await sendPushNotification(firebase_token);
    }*/
    WidgetsBinding.instance?.addObserver(this);
    // state resume -

    if (imageUrl.value.isNotEmpty) {
      imageUrl.value = AppUrl.BASE_URL + '/' + imageUrl.value.toString();
      print('sessionManagement image ' + imageUrl.value.toString());
    } else {
      imageUrl.value = '';
    }

    // Add this line to register the observer for app lifecycle events
    //_handlegps();
    checkClusterId();
    print("email id is:: $email");
    print("profile picture is:: $profile_pic");
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      fetchLocation();
      try{
        var checkin_session=await sessionManagement.getCheckIn()??'';
        print('LocationBg : init Session =>'+checkin_session.toString());
        if(checkin_session=="CHECKIN"){
          if (backgroundService == null){
            backgroundService = BackgroundService(sessionManagement);
            backgroundService!.initializeService();
          }

          // Call the onStart method on the instance.
          if (backgroundService!.getServiceInstance() != null &&
              !await backgroundService!.getServiceInstance()!.isRunning()) {
            backgroundService!.getServiceInstance()!.startService();
          }
        }

      }catch(e){}

    } else {
      getEmployeeMasterDetailsApi();
    }

    // thread
    //todo all offline data send to server
    locationDataList = await _databaseHelper.getAllLocationData();
    if (locationDataList != null && locationDataList.length > 0) {
      // insertLocationCoordinates(locationDataList, 'OfflineTable');
    }
    //todo user is online the start hitting api   -- checkin session and fetch location if true

    checkGps();
  }

  Future<void> checkGps() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      try {
        await Geolocator.getCurrentPosition();
        enabled = true;
      } catch (e) {
        _handlegps();
      }
    }


  }









  @override
  void dispose() {
    // Todo Remove the observer when your widget is disposed
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        MyApp.app_CurrentStatus = "Stop";
        print('application is inactive');
        break;
      case AppLifecycleState.detached:
        MyApp.app_CurrentStatus = "Stop";
        print('application is detached');
        break;
      case AppLifecycleState.resumed:
        print('application is resumed');
        MyApp.app_CurrentStatus = "Running";
        break;
      case AppLifecycleState.hidden:
        MyApp.app_CurrentStatus = "Stop";
        print('application is hidden');
        break;
      case AppLifecycleState.paused:
        MyApp.app_CurrentStatus = "Stop";
        print('application is paused');
        break;
    }
  }

  Future<void> checkClusterId() async {
    final companyId = await sessionManagement.getCompanyId();
    if (companyId != null) {
      clusterId.value = companyId;
    }
  }

  getEmployeeMasterDetailsApi() {
    loading.value = true;
    Map data = {
      'email_id': email.value,
    };
    _api
        .getEmployeeMasterDetailsApiHit(data, sessionManagement)
        .then((value) async {
      try {
        print(value);
        loading.value = false;
        List<EmpMasterResponse> emp_masterResponse =
            (json.decode(value) as List)
                .map((i) => EmpMasterResponse.fromJson(i))
                .toList();
        if (emp_masterResponse[0].condition.toString() == "True") {
          print('LocationBg : ' + emp_masterResponse[0].checkIn.toString());
          if (emp_masterResponse[0].checkIn! > 0) {
            sessionManagement.setCheckIn('CHECKIN');
            sessionManagement
                .setStartTime(emp_masterResponse[0].shiftStartTime ?? '');
            sessionManagement
                .setEndTime(emp_masterResponse[0].shiftEndTime ?? '');
          } else {
            sessionManagement.setCheckIn('');
          }

          sessionManagement.setEmpId(emp_masterResponse[0].empId ?? '');
          sessionManagement
              .setDepartment(emp_masterResponse[0].department ?? '');
          sessionManagement
              .setDesignation(emp_masterResponse[0].designation ?? '');
          sessionManagement.setGrade(emp_masterResponse[0].grade ?? '');
          sessionManagement
              .setLocationId(emp_masterResponse[0].locationId ?? '');
          sessionManagement.setManagerId(emp_masterResponse[0].managerId ?? '');
          sessionManagement.setShiftCode(emp_masterResponse[0].shiftCode ?? '');
          sessionManagement.setState(emp_masterResponse[0].state ?? '');
          sessionManagement.setCountry(emp_masterResponse[0].country ?? '');
          getDataFromSession();

          var checkin_session=await sessionManagement.getCheckIn()??'';
          print('LocationBg : after empdetail Session =>'+checkin_session.toString());
          if(checkin_session=="CHECKIN"){
            try {
              fetchLocation();
              //todo for avoid crash application due to start foreground service initialize after 10 second instead of at a time
             // Future.delayed(Duration(seconds: 10), () async {
                if (backgroundService == null){
                  backgroundService = BackgroundService(sessionManagement);
                  await backgroundService!.initializeService();
                }
                if (backgroundService!.getServiceInstance() != null &&
                    !await backgroundService!.getServiceInstance()!.isRunning()) {
                  backgroundService!.getServiceInstance()!.startService();
                  print('service is started');
                } else {
                  print('after 5 second still null service is null');
                }

             // });
            } catch (e) {
            }
          }
        } else {
          sessionManagement.clearSession();
          Get.toNamed(RoutesName.loginScreen);
          Utils.sanckBarError(
              'Message', "Employee Details Not Found Of This User!");
        }
      } catch (e) {
        Utils.sanckBarException('Exception Message!', e.toString());
        print(e);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      // Utils.sanckBarError('Api Exception onError', error.toString());
      sessionManagement.clearSession();
      Get.toNamed(RoutesName.loginScreen);
      Utils.sanckBarError(
          'Message', "Employee Details Not Found Of This User!");
    });
  }

  Future<void> insertLocationCoordinates(
      List<LocationData> location_list, String type) async {
    loading.value = true;
    currentLat.value = location_list[0].latitude;
    currentLng.value = location_list[0].longitude;
    current_status.value = 'Fetched';
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

    _api
        .userLocationInsertApiHit(jsonList, sessionManagement)
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
          Utils.sanckBarError(
              'False Message!', common_response[0].message.toString());
        }
      } catch (e) {
        Utils.sanckBarException('Exception', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.sanckBarError('Api Exception onError', error.toString());
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled || permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return true;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.sanckBarError("Location", 'Location permission are  denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.sanckBarError("Location",
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> fetchLocation() async {
    checkin_response.value = await sessionManagement.getCheckIn() ?? '';
    if (checkin_response.value != null && checkin_response.value == 'CHECKIN') {
      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) return;
      final LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.high,
          //distanceFilter: 10,
          timeLimit: Duration(seconds: 10));
      if (positionStream == null) {
        positionStream =
            Geolocator.getPositionStream(locationSettings: locationSettings)
                .listen((Position position) async {
          print(position == null
              ? 'Unknown'
              : '${position.latitude.toString()}, ${position.longitude.toString()}');

          //Utils.sanckBarSuccess('Location Updates :', position!.latitude.toString() + position.longitude.toString());

          //todo hit api for send gps cordinate
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );
          LocationData? locationData = null;
          if (placemarks != null && placemarks.length > 0) {
            Placemark placemark = placemarks[0];
            locationData = LocationData(
              latitude: position.latitude,
              longitude: position.longitude,
              area: placemark.street ?? "",
              locality: placemark.subLocality ?? "",
              postal_code: placemark.postalCode ?? "",
              country: placemark.country ?? "",
            );
          } else {
            locationData = LocationData(
              latitude: position.latitude,
              longitude: position.longitude,
              area: "",
              locality: "",
              postal_code: "",
              country: "",
            );
          }
          currentLat.value = locationData.latitude;
          currentLng.value = locationData.longitude;
          current_status.value = 'Fetched';
          print('currentlat' + currentLat.value.toString());
          print('currentlat' + currentLng.value.toString());
          // insertLocationCoordinates([locationData], '');
        });
      }
    }
  }

  Future<bool> _handlegps() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();
      Utils.sanckBarError(
          "Location",
          'Location permission are  denied.'
              'Location services are disabled. Please enable the services');
      checkGps();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.sanckBarError("Location", 'Location permission are  denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.sanckBarError("Location",
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getDataFromSession() async {
    phone = await sessionManagement.getPhoneNo() ?? '';
    emp_id = await sessionManagement.getEmpId() ?? '';
    designation = await sessionManagement.getDesignation() ?? '';
    department = await sessionManagement.getDepartment() ?? '';
    grade = await sessionManagement.getGrade() ?? '';
    shift = await sessionManagement.getShiftCode() ?? '';
    employee_id = await sessionManagement.getEmployeeId() ?? '';
    manager_id = await sessionManagement.getManagerId() ?? '';
    state = await sessionManagement.getState() ?? '';
    country = await sessionManagement.getCountry() ?? '';
  }

  Rx<File?> pickedImagef = Rx<File?>(null);
  Rx<Uint8List> webImagef = Rx<Uint8List>(Uint8List(8));

  Future<void> openImageSource(ImageSource source) async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        var selected = File(image.path);
        pickedImagef.value = selected;
        print('moblie image path' + pickedImagef.value.toString());
        uploadImageToServer();
      } else {
        Utils.sanckBarError('Image!', 'no image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source, imageQuality: 80);
      if (image != null) {
        var selected = File(image.path);
        pickedImagef.value = selected;
        var f = await image.readAsBytes();
        webImagef.value = f;
        uploadImageToServer();
      } else {
        Utils.sanckBarError('Image!', 'no image has been picked');
      }
    } else {
      Utils.sanckBarError('Image!', 'something went wrong');
    }
  }

  List<ProfileUploadModel> profile_list = [];

  Future<void> uploadImageToServer() async {
    final server_uri = Uri.parse(AppUrl.profile_upload);
    final clint_request = http.MultipartRequest('POST', server_uri);
    var fields = <String, String>{"email_id": email.value};

    try {
      if (kIsWeb) {
        // Web platform image handling
        if (webImagef.value.isNotEmpty) {
          clint_request.files.add(http.MultipartFile.fromBytes(
              'image_url', webImagef.value,
              filename: 'web_image.jpg'));
        }
      } else {
        // mobile platform image handling
        if (pickedImagef.value != null) {
          clint_request.files.add(await http.MultipartFile.fromPath(
              'image_url', pickedImagef.value!.path));
        }
      }
      clint_request.fields.addAll(fields);

      _api.uploadImage(clint_request, sessionManagement).then((value) {
        loading.value = true;
        //print(value);
        final jsonResponse = json.decode(value);
        try {
          if (jsonResponse is List) {
            List<ProfileUploadModel> response_list = jsonResponse
                .map((data) => ProfileUploadModel.fromJson(data))
                .toList();
            if (response_list[0].condition == 'True') {
              loading.value = false;
              profile_list = response_list;
              //pickedImagef.value='';
              imageUrl.value =
                  AppUrl.BASE_URL + '/' + response_list[0].imageUrl!;
              sessionManagement.setProfile(response_list[0].imageUrl!);
              print(imageUrl.value);

              Utils.sanckBarSuccess(
                  'True Message', response_list[0].message.toString());
            } else {
              profile_list = [];
              loading.value = false;
              Utils.sanckBarError(
                  'False Message!', response_list[0].message.toString());
            }
          } else {
            loading.value = false;
            profile_list = [];
            Utils.sanckBarError(
                'API Error',
                jsonResponse["message"] == null
                    ? 'Invalid response format'
                    : jsonResponse["message"]);
          }
        } catch (e) {
          print(e);
          Utils.sanckBarError('Error!', "Api Response Error :" + e.toString());
        }
      }).onError((error, stackTrace) {
        profile_list = [];
        print(error);
        loading.value = false;
        Utils.sanckBarError('Error!', "Api Response Error");
      });
    } catch (e) {
      print(e);
      loading.value = false;
    }
  }
  Future<void> sendPushNotification(String firebase_token_id)async {
    loading.value = true;
    Map data = {
      "email_id": email.value,
      "user_token": firebase_token_id,
    };
    await _api.sendPushNotificationToServer(data, sessionManagement).then((value) async {
      try {
        loading.value = false;
        List<CommonResponse> response =
        (json.decode(value) as List).map((i) => CommonResponse.fromJson(i)).toList();
        if (response.isNotEmpty && response[0].condition.toString() == "True") {
          await sessionManagement.setFirebaseToken(firebase_token_id);
        }
        else {
          Utils.sanckBarError('False Message!', response[0].message.toString());
        }
      } catch (e) {
        Utils.sanckBarException('Exception Message!', e.toString());
      }
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }


  Future<void> checkLocation(context) async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Disabled"),
            content: Text("Please Enable Location in Settings.\nSetting -> Location -> Enable "),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Geolocator.openAppSettings();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
