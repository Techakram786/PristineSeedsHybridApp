import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/constants/static_methods.dart';
import 'package:pristine_seeds/models/orders/customers_model.dart';
import 'package:pristine_seeds/models/planting/planting_header_get_model.dart';
import 'package:pristine_seeds/models/planting/planting_header_model.dart';
import 'package:pristine_seeds/models/planting/production_location_model.dart';
import 'package:pristine_seeds/models/planting/season_model.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../current_location/current_location.dart';
import '../../find_area/AreaControler.dart';
import '../../models/planting/document_detail_get.dart';
import '../../models/planting/fsio_bsio_doc_get_model.dart';
import '../../models/planting/fsio_bsio_lot_details_get_model.dart';
import '../../models/planting/geo_coordinates.dart';
import '../../models/planting/supervisor_modal.dart';
import '../../repository/planting_repository/planting_creation_repo.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';

class PlantingVM extends GetxController {

  final _api = plantingCreationRepository();
  SessionManagement sessionManagement = SessionManagement();
  RxBool loading = false.obs;
  RxBool isEndButtons = false.obs;
  RxBool isSendButtons = false.obs;
  RxBool isRefreshMap = true.obs;
  RxBool isAddLine = false.obs;
  RxBool reset_field_ui=false.obs;
  RxList<ProductionLocationModel> production_location_list = <ProductionLocationModel>[].obs;
  RxList<SeasonGetModel> season_list = <SeasonGetModel>[].obs;
  RxList<CustomersModel> organizer_list = <CustomersModel>[].obs;
  RxList<PlantingHeaderGetModel> planting_header_get_list = <PlantingHeaderGetModel>[].obs;
  RxList<PlantingHeaderModel> planting_header_list = <PlantingHeaderModel>[].obs;
  RxList<SuperVisorModal> supervisor_list = <SuperVisorModal>[].obs;

  Rx<ProductionLocationModel> selected_location=new ProductionLocationModel().obs;
  Rx<SeasonGetModel> selected_season=new SeasonGetModel().obs;
  Rx<CustomersModel> selected_organizer=new CustomersModel().obs;
  Rx<SuperVisorModal> selected_supervisor=new SuperVisorModal().obs;
  String email_id = "";
  RxString planting_line_no = "".obs;
  RxString mapAllCoordinates = "".obs;
  RxString mapShowingAreaInAcres = "".obs;
  RxString planting_no = "".obs;
  RxString current_date = "".obs;
  RxString button = "Start".obs;
  RxString status = "0".obs;
  RxBool is_show_table=false.obs;

  //todo for header..............
  var production_location_controller = TextEditingController();
  var total_land_in_acres_controller = TextEditingController();
  var season_controller = TextEditingController();
  var organizer_controller = TextEditingController();
  var total_sowing_in_acres_controller = TextEditingController();
  var planting_date_controller = TextEditingController();
  var harvesting_date_controller = TextEditingController();

  //todo for line.....................
  RxBool isShowDocDropDown=false.obs;
  RxBool isShowDocDetails=false.obs;
  RxBool isShowGrowerDetails=false.obs;
  RxBool isShowMaleDetails=false.obs;
  RxBool isShowFemaleDetails=false.obs;
  RxBool isShowOtherDetails=false.obs;
  RxInt selectedOption=0.obs;

  var document_type_controller = TextEditingController();
  var document_code_controller = TextEditingController();
  var expected_yield_controller = TextEditingController();
  var sowing_area_controller = TextEditingController();
  var grower_name_controller = TextEditingController();
  var superviser_controller = TextEditingController();
  var sowing_male_date_controller = TextEditingController();
  var sowing_female_date_controller = TextEditingController();
  var sowing_other_date_controller = TextEditingController();
  var male_lot_dropdown_controller = TextEditingController();
  var female_lot_dropdown_controller = TextEditingController();
  var other_lot_dropdown_controller = TextEditingController();
  var revised_yield_controller = TextEditingController();

  RxList<String> document_type_list = <String>['FSIO','BSIO'].obs;
  Rx<String> selected_type=''.obs;
  Rx<FSIOBSIODocGetModel> selected_document=new FSIOBSIODocGetModel().obs;
  Rx<CustomersModel> selected_grower=new CustomersModel().obs;
  Rx<FSIOBSIOLotDetailsGetModel> selected_male_lot=new FSIOBSIOLotDetailsGetModel().obs;
  Rx<FSIOBSIOLotDetailsGetModel> selected_female_lot=new FSIOBSIOLotDetailsGetModel().obs;
  Rx<FSIOBSIOLotDetailsGetModel> selected_other_lot=new FSIOBSIOLotDetailsGetModel().obs;

  RxList<FSIOBSIODocGetModel> document_list = <FSIOBSIODocGetModel>[].obs;
  RxList<DocumentDetailGet> document_details_get_list = <DocumentDetailGet>[].obs;
  RxList<CustomersModel> grower_list = <CustomersModel>[].obs;
  RxList<FSIOBSIOLotDetailsGetModel> male_lot_list = <FSIOBSIOLotDetailsGetModel>[].obs;
  RxList<FSIOBSIOLotDetailsGetModel> female_lot_list = <FSIOBSIOLotDetailsGetModel>[].obs;
  RxList<FSIOBSIOLotDetailsGetModel> other_lot_list = <FSIOBSIOLotDetailsGetModel>[].obs;


  Size size = Get.size;
  //todo for google map...........................
  final Set<Marker> marker = {};
  final Set<Polyline> polyline = {};
  List<LatLng> latlng = [];
  List<GeoCoordinates> coordinates_list_data = [];
  RxDouble currentLat = 0.0.obs;
  RxDouble currentLng = 0.0.obs;
  RxDouble previousLat = 0.0.obs;
  RxDouble previousLng = 0.0.obs;
  RxString current_postal_code=''.obs;
  RxString current_country=''.obs;
  RxString current_area=''.obs;
  RxString previous_country=''.obs;
  RxString previous_area=''.obs;
  RxString previous_postal_code=''.obs;

  RxString AreaInAcres='0.0'.obs;
  StreamSubscription<Position>? positionStream = null;
  LocationData currentLocation = LocationData();
  List<Placemark>? placemarks,previous_placemarks;

  initCurrentLocationLatLant() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled &&
        (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse)) {
      Position userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLat.value = userLocation.latitude;
      currentLng.value = userLocation.longitude;

      placemarks = await placemarkFromCoordinates(
          currentLat.value, currentLng.value);

      if (placemarks != null && placemarks!.isNotEmpty) {
        Placemark placemark = placemarks![0]; // Assuming first placemark is desired
        current_country.value = placemark.country!;
        current_area.value = placemark.administrativeArea ?? "";
        current_postal_code.value = placemark.postalCode ?? "";
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

  late GoogleMapController googleMapController;
  Completer<GoogleMapController> completer = Completer();
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(28.6134365, 77.3880032),
    zoom: 14,
  );

  //todo for pagination....................

  int pageNumber=0;
  int rowsPerPage=50;
  int total_rows=0;
  @override
  void onInit() async {
    super.onInit();
    current_date.value=await StaticMethod.getCurrentData();
    email_id = await sessionManagement.getEmail() ?? '';
    planting_date_controller.text=current_date.value;
    plantingHeaderGetRefressUi('');
    initCurrentLocationLatLant();
  }

  getSupervisor(){
    Map<String, String> data = {
      "email_id": email_id,
    };
    loading.value=true;
    _api.getSupervisor(data, sessionManagement).then((value){
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SuperVisorModal> response =
          jsonResponse.map((data) => SuperVisorModal.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            print('response of supervisor list $response');
            supervisor_list.value = response;

          } else {
            loading.value=false;
            supervisor_list.value = [];
            Utils.sanckBarError('False Message!','supervisor not found');
          }
        } else {
          loading.value=false;
          supervisor_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        supervisor_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future plantingHeaderGetRefressUi(String flag) async{
    pageNumber=0;
    total_rows=0;
    planting_header_get_list.value=[];
    plantingHeaderGet(pageNumber,flag);
  }
  List<PlantingHeaderGetModel> my_current_list=[];
  plantingHeaderGet(pageNumber,String flag){

    Map data = {
      "code": "",
      "production_center_loc": "",
      "status": status.value,
      "planting_date": "",
      "date_of_harvest": "",
      "season": "",
      "organizer": "",
      "email_id": email_id,
      "rowsPerPage": rowsPerPage,
      "pageNumber": pageNumber

    };
    loading.value=true;
    _api.plantingHeaderGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<PlantingHeaderGetModel> response =
          jsonResponse.map((data) => PlantingHeaderGetModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
           /* List<PlantingHeaderGetModel> my_current_list=[];
            my_current_list.addAll(planting_header_get_list.value);
            my_current_list.addAll(response);
            planting_header_get_list.value=[];
            planting_header_get_list.value=my_current_list;
            total_rows=int.parse(response[0].totalRows!);*/
            if(pageNumber==0){
              planting_header_get_list.clear();
            }
            planting_header_get_list.addAll(response);
            total_rows=int.parse(response[0].totalRows!);
            if(flag!=null && flag.isNotEmpty && flag=='GO_TO_LIST_PAGE'){
              Get.offAllNamed(RoutesName.planting_list);
            }
          } else {
            loading.value=false;
            planting_header_get_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          planting_header_get_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);

        }
      } catch (e) {
        loading.value=false;
        planting_header_get_list.value = [];
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      planting_header_get_list.value = [];
    });
  }

  plantingHeaderGetDetails(String code){
   // planting_header_list.value = [];
    Map data = {
      "planting_no": code,
      "created_by": email_id
    };
    loading.value=true;
    _api.plantingHeaderCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<PlantingHeaderModel> response =
          jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            loading.value=false;
            planting_header_list.value = response;
            Get.toNamed(RoutesName.planting_line_detaile);

          } else {
            loading.value=false;
            planting_header_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          planting_header_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        planting_header_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      planting_header_list.value = [];
    });
  }

  //todo for planting header creation............
  productionLocationGet(){
    Map data = {
      'location_code':'',
      'location_name': ''
    };
    _api.productionLocationGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<ProductionLocationModel> response =
          jsonResponse.map((data) => ProductionLocationModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            production_location_list.value = response;
            seasonMstGet();
            Get.toNamed(RoutesName.create_planting_header);

          } else {
            production_location_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          production_location_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        production_location_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
      production_location_list.value = [];
    });
  }
  seasonMstGet(){
    Map data = {
      'season_code':'',
      'season_name': ''
    };
    _api.seasonMstGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<SeasonGetModel> response =
          jsonResponse.map((data) => SeasonGetModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            season_list.value = response;
           // getOrganizers();

          } else {
            season_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          season_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        season_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print(error);
      season_list.value = [];
    });
  }


  //todo planting header create
  plantingHeaderCreate(){
    if(production_location_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Location.');
      return;
    }
    if(selected_location.value.locationName!=production_location_controller.text){
      Utils.sanckBarError('Error : ', 'Please Select Valid Production Location.');
      return;
    }
    if(season_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Season.');
      return;
    }
    if(organizer_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Organizer.');
      return;
    }

    if(planting_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Planting Date.');
      return;
    }
    if(harvesting_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Harvesting Date.');
      return;
    }
    Map data = {
      "planting_no": "",
      "production_center_loc": selected_location.value.locationCode,
      "planting_date": planting_date_controller.text,
      "date_of_harvest": harvesting_date_controller.text,
      "season_code": selected_season.value.seasonCode,
      "season_name": season_controller.text,
      "organizer_code": selected_organizer.value.customerNo,
      "organizer_name": organizer_controller.text,
     // "total_land_in_acres":total_land_in_acres_controller.text,
     // "total_sowing_area_in_acres": total_sowing_in_acres_controller.text,
      "created_by": email_id

    };
    loading.value=true;
    _api.plantingHeaderCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<PlantingHeaderModel> response =
          jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            loading.value=false;
            planting_header_list.value = response;
            resetAllHeaderFields();
            this.plantingHeaderGetRefressUi('');
            Get.toNamed(RoutesName.planting_line_detaile);
          } else {
            loading.value=false;
            planting_header_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          planting_header_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
          print(jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        planting_header_list.value = [];
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
      planting_header_list.value = [];
    });
  }
//todo Discard Planting Header Line
  plantingHeaderLineDiscard(String flag,String? planting_no,String? line_no,BuildContext context){
    //Header Discard Line Discard
    Map data = {};

    if(flag=="Header Discard"){
      data = {
        "flag": flag,
        "planting_no": planting_no,
        "created_by": email_id

      };
    }
    else if(flag=="Line Discard"){
      data = {
        "flag": flag,
        "planting_no": planting_no,
        "line_no": line_no,
        "created_by": email_id

      };
    }
    if(!loading.value){
      loading.value=true;
      _api.plantingHeaderLineDiscard(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<PlantingHeaderModel> response =
            jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
            if (response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
              loading.value=false;
              if(flag=="Header Discard"){
                Get.toNamed(RoutesName.planting_list);
                plantingHeaderGetRefressUi('');
                //planting_header_list.value=[];
              }
              else if(flag=="Line Discard"){
                planting_header_list.value = response;
                Navigator.pop(context);
              }
              resetAllHeaderFields();
            } else {
              loading.value=false;
              Utils.sanckBarError('False Message!', response[0].message.toString());
            }
          } else {
            loading.value=false;
            Utils.sanckBarError('API Response', jsonResponse);
            print(jsonResponse);
          }
        } catch (e) {
          loading.value=false;
          print(e);
          Utils.sanckBarError('Exception!',e.toString() );
        }
      }).onError((error, stackTrace) {
        loading.value=false;
        Utils.sanckBarError('API Error Exception',error.toString() );
      });
    }

  }

  PlantingHeaderComplete(String? planting_no){
    Map data = {
        "code": planting_no,
        "email_id": email_id
      };

    if(!loading.value){
      loading.value=true;
      _api.PlantingHeaderComplete(data, sessionManagement).then((value) {
        try {
          final jsonResponse = json.decode(value);
          if (jsonResponse is List) {
            List<PlantingHeaderModel> response =
            jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
            if (response[0].condition == 'True') {
              Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
              loading.value=false;
              plantingHeaderGetRefressUi('GO_TO_LIST_PAGE');
            } else {
              loading.value=false;
              Utils.sanckBarError('False Message!', response[0].message.toString());
            }
          } else {
            loading.value=false;
            Utils.sanckBarError('API Response', jsonResponse);
            print(jsonResponse);
          }
        } catch (e) {
          loading.value=false;
          print(e);
          Utils.sanckBarError('Exception!',e.toString());
        }
      }).onError((error, stackTrace) {
        loading.value=false;
        Utils.sanckBarError('API Error Exception',error.toString() );
      });
    }

  }

  void resetAllHeaderFields(){
    this.reset_field_ui.value=true;
    production_location_controller.clear();
    season_controller.clear();
    organizer_controller.clear();
    total_land_in_acres_controller.clear();
    total_sowing_in_acres_controller.clear();
    harvesting_date_controller.clear();
    this.reset_field_ui.value=false;
  }

  void resetAllLineFields(){
    isShowDocDetails.value=false;
    isShowGrowerDetails.value=false;
    isShowMaleDetails.value=false;
    isShowFemaleDetails.value=false;
    isShowOtherDetails.value=false;
    document_type_controller.clear();
    document_code_controller.clear();
    grower_name_controller.clear();
    expected_yield_controller.clear();
    sowing_area_controller.clear();
    superviser_controller.clear();
    sowing_male_date_controller.clear();
    sowing_female_date_controller.clear();
    sowing_other_date_controller.clear();
    male_lot_dropdown_controller.clear();
    female_lot_dropdown_controller.clear();
    other_lot_dropdown_controller.clear();
    revised_yield_controller.clear();

  }

  //todo for add line section..............
  plantingFsioBsioDocumentGet(String type){
    Map data = {
      "document_type": type,
      "document_no": ""
    };
    _api.plantingFsioBsioDocumentGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<FSIOBSIODocGetModel> response =
          jsonResponse.map((data) => FSIOBSIODocGetModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            document_list.value = response;
          } else {
            document_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          document_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        document_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      document_list.value = [];
    });
  }

  //todo for get ducument details............
  plantingFsioBsioLotDetailsGet(String doc_no){
    Map data = {
      "document_no": doc_no,
      "item_type": '',
    };
    _api.plantingFsioBsioDocumentDetailsGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<DocumentDetailGet> response =
          jsonResponse.map((data) => DocumentDetailGet.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            document_details_get_list.value = response;
            isShowDocDetails.value=true;
          } else {
            document_details_get_list.value = [];
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          document_details_get_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        document_details_get_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      document_details_get_list.value = [];
    });
  }

  //todo for get male lot details............

  maleLotDetailsGet(String doc_no){
    Map data = {
      "document_no": doc_no,
      "item_type": 'Male',
      "item_no": '',
    };
    _api.plantingFsioBsioDocumentDetailsGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<FSIOBSIOLotDetailsGetModel> response =
          jsonResponse.map((data) => FSIOBSIOLotDetailsGetModel.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            male_lot_list.value = response;
          } else {
            male_lot_list.value = [];
          }
        } else {
          male_lot_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        male_lot_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      male_lot_list.value = [];
    });
  }

  //todo for get female lot details............
  feMaleLotDetailsGet(String doc_no,String item_no){
    Map data = {
      "document_no": doc_no,
      "item_type": 'Female',
      "item_no": item_no,
    };
    _api.plantingFsioBsioDocumentDetailsGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<FSIOBSIOLotDetailsGetModel> response =
          jsonResponse.map((data) => FSIOBSIOLotDetailsGetModel.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            female_lot_list.value = response;
          } else {
            female_lot_list.value = [];
          }
        } else {
          female_lot_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        female_lot_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      print('dddddd'+error.toString());
      female_lot_list.value = [];
    });
  }

  //todo for get male lot details............
  otherLotDetailsGet(String doc_no){
    Map data = {
      "document_no": doc_no,
      "item_type": 'Other',
    };
    _api.plantingFsioBsioDocumentDetailsGet(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<FSIOBSIOLotDetailsGetModel> response =
          jsonResponse.map((data) => FSIOBSIOLotDetailsGetModel.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            other_lot_list.value = response;
          } else {
            other_lot_list.value = [];
          }
        } else {
          other_lot_list.value = [];
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        other_lot_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      Utils.sanckBarError('API Error',error.toString() );
      other_lot_list.value = [];
    });
  }

  //todo for grower get.......................


  plantingLineCreate(){
    if(document_type_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Document Type.');
      return;
    }
    if(document_code_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Document Code.');
      return;
    }


    //todo come comment.....
   /* if(expected_yield_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Expected Yield.');
      return;
    }*/
    if(sowing_area_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Enter Sowing Area.');
      return;
    }
    if(grower_name_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Grower');
      return;
    }

    if(isShowMaleDetails.value && sowing_female_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Sowing Female Date.');
      return;
    }
    if(isShowMaleDetails.value && female_lot_dropdown_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Female Lot.');
      return;
    }

    /* if(sowing_male_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Sowing Male Date.');
      return;
    }
    if(male_lot_dropdown_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Male Lot.');
      return;
    }

    if(sowing_female_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Sowing Female Date.');
      return;
    }
    if(female_lot_dropdown_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Female Lot.');
      return;
    }

    if(sowing_other_date_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Sowing Other Date.');
      return;
    }
    if(other_lot_dropdown_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Select Other Lot.');
      return;
    }
    if(revised_yield_controller.text.isEmpty){
      Utils.sanckBarError('Error : ', 'Please Revised Yield.');
      return;
    }*/
    Map data = {
      "code": planting_header_list[0].code ?? '',
      "document_type": document_type_controller.text,
      "document_no": document_code_controller.text,
      "parent_male_lot": selected_male_lot.value.lotNo?? '',
      "parent_female_lot": selected_female_lot.value.lotNo?? '',
      "parent_other_lot": (selected_male_lot.value.lotNo==null || selected_male_lot.value.lotNo!.isEmpty)?(selected_other_lot.value.lotNo?? ''):'',
      "grower_owner_code": selected_grower.value.customerNo ?? '',
      "grower_land_owner_name": selected_grower.value.name ?? '',
      "supervisor_name": superviser_controller.text,
      "crop_code": (selected_male_lot.value.cropCode!=null && selected_male_lot.value.cropCode!.isNotEmpty)?
                    selected_male_lot.value.cropCode?? '':selected_other_lot.value.cropCode?? '',

      "variety_code":(selected_male_lot.value.varietyCode!=null && selected_male_lot.value.varietyCode!.isNotEmpty)?
                      selected_male_lot.value.varietyCode?? '':selected_other_lot.value.varietyCode?? '',

      "item_product_group_code": (selected_male_lot.value.itemProductGroupCode!=null && selected_male_lot.value.itemProductGroupCode!.isNotEmpty)?
                                  selected_male_lot.value.itemProductGroupCode?? '': selected_other_lot.value.itemProductGroupCode?? '',
      "item_class_of_seeds": (selected_male_lot.value.itemClassOfSeeds!=null && selected_male_lot.value.itemClassOfSeeds!.isNotEmpty)?
                              selected_male_lot.value.itemClassOfSeeds ?? '':selected_other_lot.value.itemClassOfSeeds,
      "item_crop_type": (selected_male_lot.value.itemCropType!=null && selected_male_lot.value.itemCropType!.isNotEmpty)?
                         selected_male_lot.value.itemCropType?? '':selected_other_lot.value.itemCropType?? '',
      "item_no": (selected_male_lot.value.itemNo!=null && selected_male_lot.value.itemNo!.isNotEmpty)?
                  selected_male_lot.value.itemNo?? '':selected_other_lot.value.itemNo?? '',
      "item_name": (selected_male_lot.value.itemName!=null && selected_male_lot.value.itemName!.isNotEmpty)?
                    selected_male_lot.value.itemName?? '':selected_other_lot.value.itemName?? '',
      "expected_yield": expected_yield_controller.text.isNotEmpty?expected_yield_controller.text:'0',
      "revised_yield_raw": revised_yield_controller.text.isNotEmpty?revised_yield_controller.text:'0' ,
      "land_lease": selectedOption.value,
      "unit_of_measure_code": document_details_get_list[0].baseUnitOfMeasure?? '',
      "sowing_date_male": sowing_male_date_controller.text.isNotEmpty?sowing_male_date_controller.text:'',
      "sowing_date_female": sowing_female_date_controller.text.isNotEmpty?sowing_female_date_controller.text:'',
      "sowing_date_other": sowing_male_date_controller.text.isEmpty?(sowing_other_date_controller.text.isNotEmpty?sowing_other_date_controller.text:''):'',
      "sowing_area_In_acres": sowing_area_controller.text.isNotEmpty?sowing_area_controller.text:'',
      "quantity_male": selected_male_lot.value.qty!=null?selected_male_lot.value.qty.toString():'0',
      "quantity_female": selected_female_lot.value.qty!=null?selected_male_lot.value.qty.toString():'0',
      "quantity_other": (selected_male_lot.value.qty==null || selected_male_lot.value.qty=='' || selected_male_lot.value.qty==0)?(selected_other_lot.value.qty.toString()):'0',
      "created_by": email_id
    };
    loading.value=true;
    _api.plantingLineCreate(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        print(value);
        if (jsonResponse is List) {
          List<PlantingHeaderModel> response =
          jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
          if (response.length>0 && response!=null &&  response[0].condition == 'True') {
            Utils.sanckBarSuccess('Success Message!', response[0].message.toString());
            loading.value=false;
            planting_header_list.value = response;
            plantingHeaderGetDetails(planting_header_list[0].code!);
          } else {
            loading.value=false;
            Utils.sanckBarError('False Message!', response[0].message.toString());
          }
        } else {
          loading.value=false;
          Utils.sanckBarError('API Response', jsonResponse);
        }
      } catch (e) {
        loading.value=false;
        print(e);
        Utils.sanckBarError('Exception!',e.toString() );
      }
    }).onError((error, stackTrace) {
      loading.value=false;
      Utils.sanckBarError('API Error Exception',error.toString() );
      print(error);
    });
  }

  openBottomSheetDialog(BuildContext context,int position){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(child: Icon(Icons.cancel,color: AllColors.primaryliteColor,),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 87.0),
                      child: Text('Line Details',style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700),
                        //textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),
            ) ,
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionChip(
                    elevation: 1,
                    tooltip: "Geo Location",
                    backgroundColor: AllColors.grayColor,
                   // avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                    shape: StadiumBorder(
                        side: BorderSide(color: AllColors.primaryDark1)),
                    label: Text('Geo Location',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    onPressed: () {
                      print('prevslat1232 '+planting_header_list[0].lines![position].mapCordinateLatitude.toString());
                      print('prevoiuslng123 '+planting_header_list[0].lines![position].mapCordinateLongitude.toString());
                      Get.back();
                      plantingLineGpsPreviousLatLng(position);
                      //initCurrentLocationLatLant();
                      openBottomSheetPlantingLineGPSCurrentLatLng(context, position);
                    },
                  ),
                  Obx(() {
                    return  Visibility(
                      visible:planting_header_list[0].status!<=0 ? true : false,
                      child: ActionChip(
                        elevation: 1,
                        tooltip: "Delete",
                        backgroundColor: AllColors.grayColor,
                        //avatar: Icon(Icons.delete, color: AllColors.primaryDark1),
                        shape: StadiumBorder(
                            side: BorderSide(color: AllColors.redColor)),
                        label: Text('Delete',
                            style: GoogleFonts.poppins(
                              color: AllColors.redColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            )
                        ),
                        onPressed: () {
                          plantingHeaderLineDiscard('Line Discard',planting_header_list[0].code,planting_header_list[0].lines![position].lineNo.toString(),context);
                        },
                      ),
                    );
                  }),
                  ActionChip(
                    elevation: 1,
                    tooltip: "Location",
                    backgroundColor: AllColors.grayColor,
                   // avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                    shape: StadiumBorder(
                        side: BorderSide(color: AllColors.primaryDark1)),
                    label: Text('Location',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w600,
                        )
                    ),
                    onPressed: () {
                      planting_no.value=planting_header_list[0].code!;
                      planting_line_no.value=planting_header_list[0].lines![position].lineNo.toString();
                      mapAllCoordinates.value=planting_header_list[0].lines![position].mapAllCordinate!=null?
                      planting_header_list[0].lines![position].mapAllCordinate!:"";
                      mapShowingAreaInAcres.value=planting_header_list[0].lines![position].mapSowingAreaInAcres.toString();
                      Get.toNamed(RoutesName.add_geo_location_with_map);
                    },
                  ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),
            ) ,

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Line No:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].lineNo.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Document Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].documentType.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Document Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].documentNo.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Crop Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].cropCode?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Name:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].itemName.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Cls.Of Seed:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].itemClassOfSeeds?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Crop Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].itemCropType?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Item Crop Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].cropCode?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Variety Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].varietyCode?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Unit Of Measure:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].unitOfMeasureCode?? '',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Expected Yield:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].expectedYield.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sowing Acres:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].sowingAreaInAcres.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Land Lease:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].landLease!>0?'Yes':'No',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Grower Name:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].growerLandOwnerName.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Superviser Name:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].supervisorName.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Revised Yield',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(planting_header_list[0].lines![position].revisedYieldRaw.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Visibility(
                          visible: planting_header_list[0].lines![position].sowingDateMale!=null?true:false,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sowing Date Male:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].sowingDateMale.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Parent Male Lot:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].parentMaleLot.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Male Qty:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].quantityMale.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      Obx(() {
                        return Visibility(
                          visible: planting_header_list[0].lines![position].sowingDateFemale!=null?true:false,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sowing Date Female:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].sowingDateFemale.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Parent Female Lot:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].parentFemaleLot.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Female Qty:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].quantityFemale.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      Obx(() {
                        return Visibility(
                          visible:planting_header_list[0].lines![position].sowingDateOther!=null?true:false,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sowing Other Date:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].sowingDateOther.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Parent Other Lot',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].parentOtherLot.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Other Qty:',style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w700),),
                                    Text(planting_header_list[0].lines![position].quantityOther.toString(),
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            // Add more ListTile widgets for additional options if needed
          ],
        );
      },
    );
  }

  Future<void> getCurrentLocation(String flag,context) async {
    if(flag=='End' && coordinates_list_data.length+1<3){
      Utils.sanckBarError('Raised Error!', 'Need Minimum 3 Mark Points');
    }
    try {
      bool serviceEnabled;
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (serviceEnabled && (permission == LocationPermission.always || permission == LocationPermission.whileInUse)) {
        Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if(flag=='Reset'){
          isRefreshMap.value=false;
          coordinates_list_data.clear();
          points.clear();
          latlng.clear();
          marker.clear();
          button.value='Start';
          isSendButtons.value=false;
          isEndButtons.value=false;
          isRefreshMap.value=true;
          Utils.sanckBarSuccess('Reset!', 'All Mark Points Cleared.');
        }
        if(flag=='Start'){
          isEndButtons.value=true;
          button.value='Reset';
          Utils.sanckBarSuccess('Start!', 'Location Fetch Start.');
          //coordinates_list_data.clear();
        }

        if(flag=='Start' || flag=='Mark'|| flag=='End'){
          isRefreshMap.value=false;
          GeoCoordinates model=new GeoCoordinates();
          model.id=coordinates_list_data.length+1;
          model.fromLatitude=userLocation.latitude;
          model.fromLongitude=userLocation.longitude;
          coordinates_list_data.add(model);
          isRefreshMap.value=true;
          if(flag=='End'){
            isRefreshMap.value=false;
            isSendButtons.value=true;
            isEndButtons.value=false;
            GeoCoordinates model=new GeoCoordinates();
            model.id=coordinates_list_data.length+1;
            model.fromLatitude=coordinates_list_data[0].fromLatitude;
            model.fromLongitude=coordinates_list_data[0].fromLongitude;
            coordinates_list_data.add(model);
            Utils.sanckBarSuccess('End!','All Points Mrked');
            isRefreshMap.value=true;
            convertCoordinatesToOffset1(coordinates_list_data);
          }
        }
      }
      else {
        _handlegps();
      }
    } catch (e) {
      print(e);
    }finally{
      if(coordinates_list_data.length>0){
           points.clear();
           coordinates_list_data.forEach((element) {
            points.add( LatLng(element.fromLatitude!, element.fromLongitude!));
          });
          markerPosionPrintDrawLine(context,coordinates_list_data);
      }
    }
  }

  Set<Polygon> polygon = HashSet<Polygon>();
  List<LatLng> points = [];

  Future<void> markerPosionPrintDrawLine(BuildContext context, List<GeoCoordinates> coordinates_list_data) async {
    if (coordinates_list_data.length > 0) {
      for (var item in coordinates_list_data) {
        LatLng lang = LatLng(item.fromLatitude!, item.fromLongitude!);
        latlng.add(lang);
      }
    }

    if (latlng!=null && latlng.length > 0) {
      this.kGooglePlex = CameraPosition(
        target: LatLng(latlng[0].latitude, latlng[0].longitude),
        zoom: 14,
      );
    }

    // todo Add markers for every starting and ending point of each line segment
    for (int i = 0; i < latlng.length - 1; i++) {
      marker.add(
        Marker(
          markerId: MarkerId('Start$i'),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: 'Start $i',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
      marker.add(
        Marker(
          markerId: MarkerId('End$i'),
          position: latlng[i + 1],
          infoWindow: InfoWindow(
            title: 'End $i',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    polyline.add(
      Polyline(
        polylineId: PolylineId('1'),
        points: latlng,
        width: 4,
        color: AllColors.redColor,
      ),
    );

    // Add markers for the starting and ending points

  }
  AreaCalculator areaCalculator=AreaCalculator();
  List<Offset> convertCoordinatesToOffset1(List<GeoCoordinates> coordinatesList){
    double area_in_meter=0.0;
    double area_in_acre=0.0;
    List<Offset> polygonCoordinate=[];
    for (var item in coordinatesList) {
      polygonCoordinate.add(Offset(item.fromLatitude!, item.fromLongitude!));
    }
    area_in_meter = areaCalculator.calculatePolygonArea(polygonCoordinate);
    area_in_acre=area_in_meter*0.00025;
    AreaInAcres.value=area_in_acre.toStringAsPrecision(3);
    if (AreaInAcres.value.contains('e')) {
        List<String> parts = AreaInAcres.value.split('e');
      AreaInAcres.value = double.parse(parts[0]).toString();
    }
    return polygonCoordinate;
  }

  plantingLineGPSTag(BuildContext context){
    if(coordinates_list_data!=null && coordinates_list_data.length>0 ){

      List<Map<String, dynamic>> encodableList = coordinates_list_data
          .where((item) => item is GeoCoordinates) // Filter out unwanted types
          .map((location) => (location as GeoCoordinates).toJson()).toList();
      String jsonString = jsonEncode(encodableList);
      Map data = {
        "planting_no": planting_no.toString(),
        "line_no": planting_line_no.toString(),
        "map_sowing_area_In_acres":AreaInAcres.toString(),
        "map_cordinate_latitude": '',
        "map_cordinate_longitude": '',
        "created_by": email_id,
        "map_all_cordinate":jsonEncode(jsonString),
      };

      if(!loading.value){
        loading.value=true;
        _api.plantingLineGPSTag(data, sessionManagement).then((value) {
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<PlantingHeaderModel> response =
              jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
              if (response[0].condition == 'True') {
                isRefreshMap.value=false;
                loading.value=false;
                isRefreshMap.value=true;
                coordinates_list_data.clear();
                planting_header_list.value = response;
                //Get.back();
                //Get.offNamed(RoutesName.planting_line_detaile);
               // Navigator.of(context).pop();
                print(jsonResponse);
              } else {
                loading.value=false;
                Utils.sanckBarError('False Message!', response[0].message.toString());
                print(response[0].message);
              }
            } else {
              loading.value=false;
              Utils.sanckBarError('API Response', jsonResponse);
              print(jsonResponse);
            }
          } catch (e) {
            loading.value=false;
            print(e);
            Utils.sanckBarError('Exception!',e.toString());
          }
        }).onError((error, stackTrace) {
          loading.value=false;
          Utils.sanckBarError('API Error Exception',error.toString());
          print(error);
        });
      }
    }
    else{
      Utils.sanckBarError('Coordinates List Blank!', 'We can not send data to server');
    }
  }

  plantingLineGPSCurrentLatLng(){
      Map data = {
        "planting_no": planting_no.toString(),
        "line_no": planting_line_no.toString(),
        "map_sowing_area_In_acres":AreaInAcres.toString(),
        "map_cordinate_latitude": currentLat.value,
        "map_cordinate_longitude": currentLng.value,
        "created_by": email_id,
        "map_all_cordinate":'',
      };

      if(!loading.value){
        loading.value=true;
        _api.plantingLineGPSTag(data, sessionManagement).then((value) {
          try {
            final jsonResponse = json.decode(value);
            if (jsonResponse is List) {
              List<PlantingHeaderModel> response =
              jsonResponse.map((data) => PlantingHeaderModel.fromJson(data)).toList();
              if (response!=null && response.length>0 && response[0].condition == 'True') {
                loading.value=false;
                Get.back();
                print(jsonResponse);
              } else {
                loading.value=false;
                Utils.sanckBarError('False Message!', response[0].message.toString());
                print(response[0].message);
              }
            } else {
              loading.value=false;
              Utils.sanckBarError('API Response', jsonResponse);
              print(jsonResponse);
            }
          } catch (e) {
            loading.value=false;
            print(e);
            Utils.sanckBarError('Exception!',e.toString());
          }
        }).onError((error, stackTrace) {
          loading.value=false;
          Utils.sanckBarError('API Error Exception',error.toString());
          print(error);
        });
      }

    else{
      Utils.sanckBarError('Coordinates List Blank!', 'We can not send data to server');
    }
  }

  openBottomSheetPlantingLineGPSCurrentLatLng(BuildContext context,int position){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(child: Icon(Icons.cancel,color: AllColors.primaryliteColor,),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 47.0),
                      child: Text('Line Address',style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700),
                        //textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible:planting_header_list[0].status!>0 ? false : true,
                    child: ActionChip(
                      elevation: 1,
                      tooltip: "Send Location",
                      backgroundColor: AllColors.grayColor,
                      // avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                      shape: StadiumBorder(
                          side: BorderSide(color: AllColors.primaryDark1)),
                      label: Text('Send',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          )
                      ),
                      onPressed: () {
                        planting_no.value=planting_header_list[0].code!;
                        planting_line_no.value=planting_header_list[0].lines![position].lineNo.toString();
                        plantingLineGPSCurrentLatLng();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              color: AllColors.primaryliteColor,
            ) ,
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Obx((){
                    return Column(
                      children: [
                        Visibility(
                          visible:planting_header_list[0].status!>0 ? false : true,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 16.0),
                            child: SizedBox(
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Current Location',
                                  labelStyle: GoogleFonts.poppins(
                                      color: AllColors.blackColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.twentee
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                                  ),
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    placemarks!= null && placemarks!.length>0?
                                    Table(
                                      children: [
                                        TableRow(
                                          children: [
                                            Text(
                                              'Latitude:',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              width: size.width * .5,
                                              child: Tooltip(
                                                message: 'Current Latitude',

                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  '${currentLat.value}',
                                                  style: GoogleFonts.poppins(
                                                      color: AllColors.primaryDark1,
                                                      fontSize: AllFontSize.fourtine,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              'Longitude:',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              '${currentLng.value}',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              'State Name:',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Container(
                                              width: size.width * .5,
                                              child: Tooltip(
                                                message: 'Area Name',
                                                child: Text(
                                                  overflow: TextOverflow.ellipsis,
                                                  '${current_area.value}',
                                                  style: GoogleFonts.poppins(
                                                      color: AllColors.primaryDark1,
                                                      fontSize: AllFontSize.fourtine,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              'Postal Code:',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              '${current_postal_code.value}',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            Text(
                                              'Country:',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              '${current_country.value}',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.fourtine,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ):CircularProgressIndicator(
                                      color: AllColors.primaryDark1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 16.0),
                          child: SizedBox(
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Previous Location',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.twentee
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                                ),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  planting_header_list[0].lines![position].mapCordinateLatitude!=null
                                      && planting_header_list[0].lines![position].mapCordinateLatitude!=''?
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          Text(
                                            'Latitude:',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                            width: size.width * .5,
                                            child: Tooltip(
                                              message: 'Current Latitude',

                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                '${previousLat.value}',
                                                style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text(
                                            'Longitude:',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${previousLng.value}',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text(
                                            'State Name:',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                            width: size.width * .5,
                                            child: Tooltip(
                                              message: 'Area Name',
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                '${previous_area.value}',
                                                style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text(
                                            'Postal Code:',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${previous_postal_code.value}',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          Text(
                                            'Country:',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            '${previous_country.value}',
                                            style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.fourtine,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ):Text('No Previous Address',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> markerPosionPrintFieldArea(String all_coordinates) async {
    isRefreshMap.value=false;
    RxList<LatLng> points = <LatLng>[].obs;
    if(all_coordinates!=null && all_coordinates.isNotEmpty){
      var data1=json.decode(all_coordinates);
      var json_data=json.decode(data1);
      if (json_data is List) {
        isRefreshMap.value=true;
        List<GeoCoordinates> response =
        json_data.map((data) => GeoCoordinates.fromJson(data)).toList();
        for(int i=0;i<response.length;i++){
          LatLng cordinate_data=new LatLng(response[i].fromLatitude!, response[i].fromLongitude!);
          points.add(cordinate_data);
        }
      }
    }

    if (points.length>0) {
      polygon.add(
          Polygon(
            polygonId: PolygonId('1'),
            points: points.value,
            // given color to polygon
            fillColor: Colors.green.withOpacity(0.3),
            // given border color to polygon
            strokeColor: AllColors.redColor,
            geodesic: true,
            // given width of border
            strokeWidth: 4,
          )
      );

    }
  }

  void plantingLineGpsPreviousLatLng(int position)async {
      previousLat.value=double.parse(planting_header_list[0].lines![position].mapCordinateLatitude!);
      previousLng.value=double.parse(planting_header_list[0].lines![position].mapCordinateLongitude!);
      previous_placemarks = await placemarkFromCoordinates(previousLat.value, previousLng.value);
      if (previous_placemarks!= null && previous_placemarks!.length > 0) {
        Placemark placemark = previous_placemarks![0];
        previous_country.value= placemark.country ?? "";
        previous_area.value= placemark.administrativeArea ?? "";
        previous_postal_code.value= placemark.postalCode ?? "";
      }

  }

  getOrganizers(){
    Map data = {
      "customer_no": "",
      'email_id': email_id,
      "customer_name": "",
      "customer_type": "organizer",
      "row_per_page": 10,
      "page_number": 0
    };
    _api.getCustomersApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CustomersModel> response =
          jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
          if (response[0].condition == 'True') {
            organizer_list.value = response;
          } else {
            organizer_list.value = [];
            Utils.sanckBarError('Consignee!', response[0].message.toString());
          }
        } else {
          organizer_list.value = [];
          Utils.sanckBarError('API Error', jsonResponse);
        }
      } catch (e) {
        organizer_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      organizer_list.value = [];
    });
  }

 /* getGrowers(){
    Map data = {
      "customer_no": "",
      'email_id': email_id,
      "customer_name": "",
      "customer_type": "grower",
      "row_per_page": 10,
      "page_number": 0
    };
    _api.getCustomersApiHit(data, sessionManagement).then((value) {
      try {
        final jsonResponse = json.decode(value);
        if (jsonResponse is List) {
          List<CustomersModel> response =
          jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
          if (response.length>0 && response[0].condition == 'True') {
            grower_list.value = response;
          } else {
            grower_list.value = [];
            Utils.sanckBarError('Consignee!', response[0].message.toString());
          }
        } else {
          grower_list.value = [];
          Utils.sanckBarError('API Error', jsonResponse);
        }
      } catch (e) {
        grower_list.value = [];
        printError();
      }
    }).onError((error, stackTrace) {
      print(error);
      grower_list.value = [];
    });
  }*/




  Future<Iterable<CustomersModel>> searchGrower(String text) async {

    if (text == '') {
      return const Iterable<CustomersModel>.empty();
    }
    Map data = {
      "customer_no": text,
      'email_id': email_id,
      "customer_name": '',
      "customer_type": "grower",
      "row_per_page": 10,
      "page_number": 0
    };


    String customer_response =await  _api.getCustomersApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomersModel> response =
        jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          grower_list.value = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          grower_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        grower_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      grower_list.value = [];
    }
    return  grower_list.value;
  }

  Future<Iterable<CustomersModel>> searchOrganizer(String text) async {

    if (text == '') {
      return const Iterable<CustomersModel>.empty();
    }
    Map data = {
      "customer_no": text,
      'email_id': email_id,
      "customer_name": '',
      "customer_type": "organizer",
      "row_per_page": 10,
      "page_number": 0
    };


    String customer_response =await  _api.getCustomersApiHit(data, sessionManagement);
    try {
      final jsonResponse = json.decode(customer_response);

      if (jsonResponse is List) {
        print(jsonResponse);
        List<CustomersModel> response =
        jsonResponse.map((data) => CustomersModel.fromJson(data)).toList();
        print('condition..'+response[0].condition.toString());
        if (response[0].condition == 'True') {
          print(jsonResponse);
          organizer_list.value = response;

        } else {
          Utils.sanckBarException('False!', response[0].message!);
          organizer_list.value= [];
        }
      } else {
        Utils.sanckBarException('False!', jsonResponse.message);
        organizer_list.value = [];
      }
    } catch (e) {
      Utils.sanckBarException('Exception!', e.toString());
      organizer_list.value = [];
    }
    return  organizer_list.value;
  }




}

