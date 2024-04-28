import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/repository/show_routes_repository/show_routes_repo.dart';
import '../../models/coordinates_response/coordinates_resp.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../utils/app_utils.dart';
import '../session_management/session_management_controller.dart';
//
class ShowRoutesVM extends GetxController{
  final _api = ShowRoutesRepository();
  RxBool loading = false.obs;
  RxBool isVisible = false.obs;
  SessionManagement sessionManagement = SessionManagement();
  String Email_id = "";
  RxList<String> interval_list = <String>['5','10','15','20','25','30','35','40','45','50','55'].obs;
  List<EmpMasterResponse> employess_List = [];
  var typeAheadControllerEmployee = TextEditingController();
  var typeAheadControllerInterval = TextEditingController();

  var filter_date_controller = TextEditingController();

  String selection_type = "";

  //todo for map...................

  late GoogleMapController googleMapController;
  Completer<GoogleMapController> completer = Completer();
  CameraPosition kGooglePlex=CameraPosition(
      target: LatLng(28.608407347885116, 77.37972005068892),
      zoom: 14);
  final Set<Marker> marker={};
  final Set<Polyline> polyline={};
  List<LatLng> latlng=[];

  @override
  Future<void> onInit() async {
    super.onInit();
    typeAheadControllerInterval.text=5.toString();
    Email_id = await sessionManagement.getEmail() ?? '';
    this.getEmployeeMasterApi('');
  }

  Future<void> markerPosionPrint(BuildContext context,List<CoordinatesReponse> coordinates_list_data) async{

    if(coordinates_list_data.length>0){
      latlng.clear();
      marker.clear();
      polyline.clear();
      for(var item in coordinates_list_data)
      {
        LatLng lang=  new LatLng(item.fromLatitude!, item.fromLongitude!);
        latlng.add(lang);
        marker.add(
            Marker(markerId: MarkerId(item.id.toString()),
                position: lang,
                infoWindow: InfoWindow(
                    title: 'Time',
                    snippet: item.createdOn,
                  onTap: (){
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            // Customize the bottom sheet content as needed
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Location Details',style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                ),
                                ListTile(
                                  title: Text('Latitude : ${item.fromLatitude.toString()}'),
                                  leading: Icon(Icons.location_searching,color: AllColors.primaryDark1,),
                                ),
                                ListTile(
                                  title: Text('Longitude : ${item.fromLongitude.toString()}'),
                                  leading: Icon(Icons.location_pin,color: AllColors.primaryDark1,),
                                ),
                                ListTile(
                                  title: Text('Area : ${item.fromArea.toString()}'),
                                  subtitle: Text('Locality : ${item.fromLocality.toString()}'),
                                  leading: Icon(Icons.area_chart,color: AllColors.primaryDark1,),
                                ),
                                ListTile(
                                  title: Text('Postal Code : ${item.fromPostalCode.toString()}'),
                                  subtitle: Text('Country : ${item.fromCountry.toString()}'),
                                  leading: Icon(Icons.local_post_office,color: AllColors.primaryDark1,),
                                ),
                                // Add more widgets as needed
                              ],
                            ),
                          );
                        },
                      );
                    },
                ),
                icon: BitmapDescriptor.defaultMarker
            )
        );
      }
    }
    if(latlng.length>0)
   this.kGooglePlex=CameraPosition(
       target: LatLng(latlng[0].latitude, latlng[0].longitude),
       zoom: 18);
    print(latlng);

    polyline.add(Polyline(
        polylineId: PolylineId('1'),
        points: latlng,
        color: AllColors.primaryDark1
    ));

  }
  //todo for get employee.............
  getEmployeeMasterApi(String filter_login) {
    this.loading.value = true;
    Map data = {'email_id': Email_id};
    _api.getEmployeeTeam(data, sessionManagement).then((value) {
      try {
        List<EmpMasterResponse> emp_masterResponse =
        (json.decode(value) as List)
            .map((i) => EmpMasterResponse.fromJson(i))
            .toList();
        if (emp_masterResponse[0]?.condition.toString() == "True") {
          employess_List = emp_masterResponse;
        } else {
          employess_List = [];
        }
      } catch (e) {
        employess_List = [];
      }
    }).onError((error, stackTrace) {
      employess_List = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() => {this.loading.value = false});
  }

  List<EmpMasterResponse> getSuggestions(String query) {
    List<EmpMasterResponse> matches = <EmpMasterResponse>[];
    matches.addAll(this.employess_List);
    matches.retainWhere(
            (s) => s.loginEmailId!.toLowerCase().contains(query.toLowerCase()));
    if (matches == null || matches.isEmpty) matches = [];
    print(matches);
    return matches;
  }

  List<CoordinatesReponse> coordinates_list_data = [];
  //todo for get coordinates list..........
  getCoordinatesList(BuildContext context) {
    this.loading.value = true;
    Map data = {
      'email_id':typeAheadControllerEmployee.text.toString(),
      'date': filter_date_controller.text.toString(),
      'created_by':Email_id,
      'interval_time':typeAheadControllerInterval.text.toString(),
    };
    _api.userWiseCoordinatesApiHit(data, sessionManagement).then((value) {
      try {
        List<CoordinatesReponse> coordinates_list =
        (json.decode(value) as List)
            .map((i) => CoordinatesReponse.fromJson(i))
            .toList();
        print(coordinates_list);
        if (coordinates_list[0].condition.toString() == "True") {
          this.loading.value = false;
          isVisible.value=true;
          coordinates_list_data=coordinates_list;
          markerPosionPrint(context,coordinates_list_data);
        } else {
          this.loading.value = false;
          isVisible.value=true;
          Utils.sanckBarError('False Message', coordinates_list[0].message!);
          coordinates_list_data = [];
        }
      } catch (e) {
        print(e);
        this.loading.value = false;
        Utils.sanckBarError('Exception!', e.toString());
        coordinates_list_data = [];
      }
    }).onError((error, stackTrace) {
      this.loading.value = false;
      coordinates_list_data = [];
      Utils.sanckBarError('Api Exception onError', error.toString());
    }).whenComplete(() => {});
  }
}