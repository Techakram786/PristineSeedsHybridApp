import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../view_model/customer_vm/customer_list_vm.dart';

class CustomerListDetail extends StatelessWidget {
  CustomerListDetail({super.key});

  final customer_list_pageController = Get.put(CustomerListViewModel());
  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(RoutesName.customerList);
        return true;
      },
      child: Scaffold(
        body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 25),
              decoration: BoxDecoration(boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 0.55))
              ], color: Colors.white),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: size.height * 0.09,
                      child: CircleBackButton(
                        press: () {
                          Get.toNamed(RoutesName.customerList);
                          customer_list_pageController
                              .customer_no_Controller
                              .clear();
                          customer_list_pageController
                              .customer_name_Controller
                              .clear();

                          customer_list_pageController.getCustomerList(
                              customer_list_pageController.pageNumber);


                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Customer List Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ],
              ),
            ),
            Obx(() {
              return Visibility(
                visible: customer_list_pageController.loading.value,
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.primaryDark1,
                  color: AllColors.primaryliteColor,
                ),
              );
            }),
            Container(
              height: 60,
              //margin: EdgeInsets.only(bottom: ),
              child: ActionChip(
                elevation: 1,
                tooltip: "Start Location",
                backgroundColor: AllColors.grayColor,
                avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                shape: StadiumBorder(
                    side: BorderSide(color: AllColors.primaryliteColor)),
                label: Text("Update Geo Tag",
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.fourtine,
                      fontWeight: FontWeight.w600,
                    )),
                onPressed: () {
                  customer_list_pageController.getCustomerListGeoLocation(customer_list_pageController.indexes);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return  Text(
                    'Address :  ${customer_list_pageController.addresses.value==""?"":customer_list_pageController.addresses.value}',
                    style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1),
                  );
                },
                ),

                Obx(() {
                  return Text(
                    'Postal Code :  ${customer_list_pageController.postal_code.value==""?" ":customer_list_pageController.postal_code.value}',
                    style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1),
                  );
                },
                ),
                Obx(() {
                  return Text(
                    'City :  ${customer_list_pageController.city.value==""?"":customer_list_pageController.city.value}',
                    style: GoogleFonts.poppins(
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1),
                  );
                },
                ),


              ],
            ),

            Expanded(
                child:  showGoogleMap(),
            ),
          ]),
        ),
      ),
    );
  }

  Widget showGoogleMap() {
    //  print("MAp All Coordinate............"+addGeoLocationpageController.mapAllCoordinates.toString());
    //  print("sssssttttttttttttt......."+(addGeoLocationpageController.planting_header_list[0].status.toString()));
    //  addGeoLocationpageController.markerPosionPrint1(addGeoLocationpageController.mapAllCoordinates.toString());
    return GoogleMap(
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      mapToolbarEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,
      gestureRecognizers: Set()
        ..add(Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer()))
        ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
        ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer())),

      initialCameraPosition: customer_list_pageController.kGooglePlex,
      mapType: MapType.normal,

      markers: customer_list_pageController.marker,
      polylines: customer_list_pageController.polyline,
      myLocationEnabled: true,
      //myLocationButtonEnabled: true,
      compassEnabled: true,
      // on below line we have added polygon
      //polygons: addGeoLocationpageController.polygon,
      // displayed google map

      onMapCreated: (GoogleMapController controller) {
        customer_list_pageController.completer.complete(controller);
      },
    );
  }


}
