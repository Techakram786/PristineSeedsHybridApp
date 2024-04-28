import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pristine_seeds/models/customer/customer_list_model.dart';
import 'package:pristine_seeds/utils/app_utils.dart';
import 'package:pristine_seeds/view_model/session_management/session_management_controller.dart';
import '../../current_location/current_location.dart';
import '../../models/customer/customer_details_model.dart';
import '../../repository/customer_repository/customer_list.dart';
import '../../resourse/routes/routes_name.dart';

class CustomerListViewModel extends GetxController{
 final _api=CustomerRepository();
 SessionManagement sessionManagement= SessionManagement();
 LocationData locationData = LocationData();
 RxBool loading = false.obs;
 ScrollController scrollController = ScrollController();

 int pageNumber=0;
 int rowsPerPage=10;
 int total_rows=0;


 RxDouble currentLat = 0.0.obs;
 RxDouble currentLng = 0.0.obs;

 final Set<Polyline> polyline = {};
 List<LatLng> latlng = [];

 final Set<Marker> marker = {};

 RxString postal_code="".obs;
 RxString city="".obs;
 RxString addresses="".obs;


 double latitude=0.0;
 double  longitude=0.0;

int indexes=0;
String customer_no='';


 RxList<CustomerResponse> customer_list=<CustomerResponse>[].obs;
 RxList<CustomerDetailResponse> customer_detail_list=<CustomerDetailResponse>[].obs;

 var customer_no_Controller =TextEditingController();
 var customer_name_Controller =TextEditingController();

 late GoogleMapController googleMapController;
 Completer<GoogleMapController> completer = Completer();
 CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(28.6134365, 77.3880032),
   zoom: 16,
   //target: LatLng(0.0, 0.0),
   //target:initialLocation,
   // zoom: 14,
   //zoom: 12.0,
 );


 @override
 void onInit()  {
   super.onInit();
   customer_list.value=[];
     getCustomerList(pageNumber);
 }

 void updateLocation(int index) async {
   indexes=index;
   customer_no=customer_list[indexes].customerno.toString();
   print("Customer_no.........${customer_no.toString()}");
   print("indexexxx.........${indexes.toString()}");
   initCurrentLocationLatLant();
   try{
     List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
     if(placemarks!=null && placemarks.isNotEmpty){
       print("placemaer.3..else..");
       Placemark placemark = placemarks[0];
       String address = "${placemark.street}, ${placemark.locality}, ${placemark
           .postalCode}";

       print("placemaer.....else");
       print("Address: $address");
       print("Postal Code: ${placemark.postalCode}");
       print("Postal Code: ${placemark.locality}");
       postal_code.value = placemark.postalCode!;
       city.value = placemark.locality!;
       addresses.value = placemark.street!;
     }

     else{

       print("No placemarks found");

     }

   }catch(e){

   }

 }

  getCustomerList(pageNumber){
    try{
      loading.value = true;
      Map<String, String> data={
        "customer_no":customer_no_Controller.text.isNotEmpty?customer_no_Controller.text:"",
        "customer_name":customer_name_Controller.text.isNotEmpty?customer_name_Controller.text:"",
        "customer_type":"Customer",
        "row_per_page":rowsPerPage.toString(),
        "page_number": pageNumber.toString()
      };

      _api.getCustomerApiHit(data, sessionManagement).then((value) {
        print(value);
        print("custom........${customer_no_Controller.text}");
        // loading.value = true;
        final jsonResponse=json.decode(value);

        if(jsonResponse is List){
          List<CustomerResponse> response=jsonResponse.map((data) => CustomerResponse.fromJson(data) ).toList();
          if(response!=null && response.length>0 && response[0].condition == 'True'){
             List<CustomerResponse> current_list=[];
             loading.value = false;

             if(pageNumber==0){
               customer_list.clear();
             }
             customer_list.addAll(response);
             total_rows=customer_list[0].totalcount!.toInt();


         /*  current_list.addAll(customer_list.value);
            current_list.addAll(response);
          customer_list.value=[];
          customer_list.value=current_list;
             print('listlength123...'+customer_list.value.length.toString());*/
         // total_rows=customer_list[0].totalcount!.toInt();

          }
          else{
            loading.value = false;
            customer_list.value=[];
            print("else");
          }

        }else {
          customer_list.value=[];
          loading.value = false;
          Utils.sanckBarError('API Response Error!', jsonResponse.toString());
        }

      },).onError((error, stackTrace) {
        print("errorrrrrrr${error}");
        loading.value = false;
      });
    }catch(e){

    }

  }

  getCustomerListGeoLocation(int index){
    try{
      loading.value=true;
      Map<String,String> data={
        "customer_no":customer_no.toString(),
        "latitude":currentLat.toString(),
        "longitude":currentLng.toString()
      };
      print(data);
      _api.getCustomerGeoTagApi(data, sessionManagement).then((value) {
        final jsonResponse=json.decode(value);
        if(jsonResponse is List){
          List<CustomerDetailResponse> responese=jsonResponse.map((data) => CustomerDetailResponse.fromJson(data)).toList();
          if(responese!=null && responese.length>0 && responese[0].condition=='True'){
            loading.value = false;
            customer_detail_list.value=responese;
            print("Success");
            customer_no_Controller.clear();
            customer_name_Controller.clear();
            getCustomerList(pageNumber);
           Get.toNamed(RoutesName.customerList);
            print("ListSize Details...... ${customer_detail_list.length}");
            Utils.sanckBarSuccess('Success Message', customer_detail_list[0].message.toString());
          }else{
            loading.value=false;
            customer_detail_list.value=[];
            print("else");
            Utils.sanckBarError("Api Error", customer_detail_list[0].message.toString());

          }
        }else{
          customer_detail_list.value=[];
          loading.value = false;
          Utils.sanckBarError('API Response Error!', jsonResponse.toString());
        }
      } ).onError((error, stackTrace) {
        loading.value=false;
      },);

    }catch(e){
    }
  }
 initCurrentLocationLatLant()async {
   bool serviceEnabled;
   LocationPermission permission;
   permission = await Geolocator.checkPermission();
   serviceEnabled = await Geolocator.isLocationServiceEnabled();
   if (serviceEnabled && (permission == LocationPermission.always ||
       permission == LocationPermission.whileInUse)) {
     Position userLocation = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
     currentLat.value=userLocation.latitude;
     currentLng.value=userLocation.longitude;
   }

 }
 showGooglemapPointer1(int index ) async {
    try{
      if(customer_list[index].latitude!=null || customer_list[index].latitude!=0.0 && customer_list[index].longitude!=null ||  customer_list[index].longitude!=0.0){
        Get.toNamed(RoutesName.customerListDetails);

         latitude= double.tryParse(customer_list[index].latitude.toString()) ?? 0.0;
         longitude= double.tryParse(customer_list[index].longitude.toString()) ?? 0.0;
        latlng.clear();
        marker.clear();
        LatLng lang=  new LatLng(latitude, longitude);
        latlng.add(lang);
        marker.add(
            Marker(markerId: MarkerId(customer_list[index].customerno.toString()),
              position: lang,
              infoWindow: InfoWindow(
                title: customer_list[index].customerno.toString(),
                //snippet: item.createdOn,
              ),
              // anchor: Offset(100,160),
              icon: BitmapDescriptor.defaultMarker,
            )
        );
        googleMapController.animateCamera(
          CameraUpdate.newLatLng(lang),
        );
        if (latlng.length >0) {
          // Only update the camera position if it hasn't been set yet
          kGooglePlex = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 16,
          );
        }
      }else{
        Get.toNamed(RoutesName.customerListDetails);
         double latitude= double.tryParse(customer_list[index].latitude.toString()) ?? 0.0;
       double   longitude= double.tryParse(customer_list[index].longitude.toString()) ?? 0.0;
         latlng.clear();
         marker.clear();
        LatLng lang=  new LatLng(latitude, longitude);
        latlng.add(lang);

        marker.add(
            Marker(markerId: MarkerId(customer_list[index].customerno.toString()),
              position: lang,
              infoWindow: InfoWindow(
                title: customer_list[index].customerno.toString(),
                //snippet: item.createdOn,
              ),
              // anchor: Offset(100,160),
              icon: BitmapDescriptor.defaultMarker,
            )
        );
        googleMapController.animateCamera(
          CameraUpdate.newLatLng(lang),
        );

        if (latlng.length >=0) {
          // Only update the camera position if it hasn't been set yet
          kGooglePlex = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 16,
          );

        }
        if(latitude!=0.0 && longitude !=0.0){
           try{
       List<Placemark> placemarks = await placemarkFromCoordinates(
           latitude, longitude);
       if(placemarks!=null && placemarks.isNotEmpty){

         Placemark placemark = placemarks[0];
         String address = "${placemark.street}, ${placemark.locality}, ${placemark
             .postalCode}";

         print("Address: $address");
         print("Postal Code: ${placemark.postalCode}");
         print("Postal Code: ${placemark.locality}");
         postal_code.value = placemark.postalCode!;
         city.value = placemark.locality!;
         addresses.value = placemark.street!;
       }
       else{
         print("No placemarks found");
       }
     }catch(e){
     }
        }else{
          print("placemaer...else..");
          postal_code.value='';
          postal_code.value='';
          addresses.value='';
        }
      }
    }catch(e){
    }
     }
 }










