import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/font_weight.dart';
import '../../view_model/planting_vm/planting_vm.dart';
class AddGeoLocationWithMapScreen extends StatelessWidget {
  AddGeoLocationWithMapScreen({super.key});
  final PlantingVM addGeoLocationpageController = Get.put(PlantingVM());

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding:
              EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 25),
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
                          Get.back();
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Geo Location",
                      style: TextStyle(
                        color: AllColors.primaryDark1,
                        fontWeight: AllFontWeight.title_weight,
                        fontSize: AllFontSize.titleSize,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: false,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Column(
                      children: [
                        Obx((){
                          return addGeoLocationpageController.planting_header_list[0].status!<=0?Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx((){
                                    return ActionChip(
                                      elevation: 1,
                                      tooltip: "Start Location",
                                      backgroundColor: AllColors.grayColor,
                                      avatar: Icon(Icons.location_pin, color: addGeoLocationpageController.button.value=='Start'?
                                      AllColors.primaryDark1:AllColors.primaryliteColor),
                                      shape: StadiumBorder(
                                          side: BorderSide(color: addGeoLocationpageController.button.value=='Start'?
                                          AllColors.primaryDark1:AllColors.primaryliteColor)),
                                      label: Text(addGeoLocationpageController.button.toString(),
                                          style: GoogleFonts.poppins(
                                            color: addGeoLocationpageController.button.value=='Start'?
                                            AllColors.primaryDark1:AllColors.primaryliteColor,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      onPressed: () {
                                        addGeoLocationpageController.getCurrentLocation(addGeoLocationpageController.button.value,context);
                                      },
                                    );
                                  }),
                                  Obx((){
                                    return Visibility(
                                      visible: addGeoLocationpageController.isEndButtons.value,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ActionChip(
                                              elevation: 1,
                                              tooltip: "Mark Location",
                                              backgroundColor: AllColors.grayColor,
                                              avatar: Icon(Icons.location_pin, color: AllColors.primaryDark1),
                                              shape: StadiumBorder(
                                                  side: BorderSide(color: AllColors.primaryliteColor)),
                                              label: Text('Mark',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              onPressed: () {
                                                addGeoLocationpageController.getCurrentLocation('Mark',context);
                                              },
                                            ),
                                            SizedBox(width: size.width*.04,),
                                            ActionChip(
                                              elevation: 1,
                                              tooltip: "End Location",
                                              backgroundColor: AllColors.grayColor,
                                              avatar: Icon(Icons.location_pin,
                                                  color: AllColors.primaryDark1),
                                              shape: StadiumBorder(
                                                  side: BorderSide(
                                                      color: AllColors.primaryliteColor)),
                                              label: Text('End',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              onPressed: () {
                                                addGeoLocationpageController.isSendButtons.value=true;
                                                addGeoLocationpageController.isEndButtons.value=false;
                                                addGeoLocationpageController.getCurrentLocation('End',context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                  Obx((){
                                    return Visibility(
                                      visible: addGeoLocationpageController.isSendButtons.value,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Area= '+ addGeoLocationpageController.AreaInAcres.value,style: GoogleFonts.poppins(
                                                color: AllColors.primaryDark1,
                                                fontSize: AllFontSize.sisxteen,
                                                fontWeight: FontWeight.w700
                                            ),),
                                            SizedBox(width: size.width*.04,),
                                            ActionChip(
                                              elevation: 1,
                                              tooltip: "Send",
                                              backgroundColor: AllColors.grayColor,
                                              avatar: Icon(Icons.interests,
                                                  color: AllColors.primaryDark1),
                                              shape: StadiumBorder(
                                                  side: BorderSide(
                                                      color: AllColors.primaryliteColor)),
                                              label: Text('Submit',
                                                  style: GoogleFonts.poppins(
                                                    color: AllColors.primaryDark1,
                                                    fontSize: AllFontSize.fourtine,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              onPressed: () {
                                                addGeoLocationpageController.plantingLineGPSTag(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ):
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx((){
                                    return Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Area In Acres= '+ addGeoLocationpageController.mapShowingAreaInAcres.value,style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.sisxteen,
                                              fontWeight: FontWeight.w700
                                          ),),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: size.height*0.01,),
                        //todo like dislike button section
                        Obx(() {
                          return  Visibility(
                            visible: addGeoLocationpageController.isRefreshMap.value,
                            child: Container(
                              width: double.infinity,
                              height: size.height*.8,
                              child:(addGeoLocationpageController.planting_header_list[0].status!=null
                                  && addGeoLocationpageController.planting_header_list[0].status!<=0) ?
                                 drawLineOnGoogleMap(context):showFieldAreaOnGoogleMap(context),
                            ),
                          );
                        }),
                        // bindListLayout(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //todo show map..............
  Widget showFieldAreaOnGoogleMap(context){

    addGeoLocationpageController.markerPosionPrintFieldArea(addGeoLocationpageController.mapAllCoordinates.value);
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
        ..add(
            Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),

      initialCameraPosition: addGeoLocationpageController.kGooglePlex,
      mapType: MapType.normal,
      //polylines: addGeoLocationpageController.polyline,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      // on below line we have added polygon
      polygons: addGeoLocationpageController.polygon,

      // displayed google map
      onMapCreated: (GoogleMapController controller){
        addGeoLocationpageController.completer.complete(controller);
      },

    );
  }

  //todo show map..............
  Widget drawLineOnGoogleMap(context){

    print(addGeoLocationpageController.planting_header_list[0].status);
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
        ..add(
            Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
        ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
        ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),

      markers: addGeoLocationpageController.marker,
      onMapCreated: (GoogleMapController controller){
        addGeoLocationpageController.completer.complete(controller);
      },
      polylines: addGeoLocationpageController.polyline,

      // Use Polyline instead of markers
      /*polylines: {
        Polyline(
          polylineId: PolylineId('dottedLine'),
          color: Colors.blue, // Choose the color of the dotted line
          width: 3, // Adjust width as needed
          patterns: [PatternItem.dot], // Set the pattern to create the dotted effect
          points: addGeoLocationpageController.points, // Your polyline points
        ),
      },*/
      //markers: addGeoLocationpageController.marker,
      //polylines: addGeoLocationpageController.polyline,
      myLocationEnabled: true,
      initialCameraPosition: addGeoLocationpageController.kGooglePlex,
      mapType: MapType.normal,
    );
  }
}