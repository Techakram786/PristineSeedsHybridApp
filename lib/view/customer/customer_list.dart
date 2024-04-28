import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/view_model/customer_vm/customer_list_vm.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';

class CustomerList extends StatelessWidget {
  CustomerList({super.key});

  final customer_list_pageController = Get.put(CustomerListViewModel());

  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(RoutesName.homeScreen);
        return true;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //openFilterBottomSheet(context);
            showFilterBottomSheet(context);
          },
          child: Icon(Icons.filter_alt_sharp, color: AllColors.whiteColor),
          backgroundColor: AllColors.primaryDark1,
        ),
        body: Container(
          height: size.height,
          width: double.infinity,
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
                            //Get.back();
                            Get.toNamed(RoutesName.homeScreen);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Customer List",
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
           Obx((){
             return BindPagginationListView(context);
           }),
            ],
          ),
        ),
      ),
    );
  }

  //todo listview bind
  Widget BindPagginationListView(context) {
    ScrollController _scrollController = ScrollController();
    _scrollController!.addListener(() {
      try {
        if (_scrollController!.position.pixels ==
            _scrollController!.position.maxScrollExtent) {
          // You have reached the end of the list
          int total_page = (customer_list_pageController.total_rows / customer_list_pageController.rowsPerPage).toInt();
          if ((customer_list_pageController.total_rows % customer_list_pageController.rowsPerPage) > 0)
            total_page += 1;

          print(
              "last index ${customer_list_pageController.pageNumber} ${customer_list_pageController.total_rows} ${customer_list_pageController.rowsPerPage} ${total_page}");

          if (customer_list_pageController.pageNumber + 1 != total_page) {
            customer_list_pageController.getCustomerList(customer_list_pageController.pageNumber + 1);
            customer_list_pageController.pageNumber += 1;
          }
        }
      }catch(e){
        print('Exception: '+e.toString());
      }
    });
    if (customer_list_pageController.customer_list.value.isNotEmpty &&
        customer_list_pageController.customer_list.value.length > 0) {
      return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.only(bottom: 8.0),
                itemBuilder: (context, index) {
                  _scrollController.addListener(() {
                    if (_scrollController.position.pixels== _scrollController.position.maxScrollExtent){

                      int total_page = (customer_list_pageController.total_rows / customer_list_pageController.rowsPerPage).toInt();

                      if((customer_list_pageController.total_rows%customer_list_pageController.rowsPerPage)>0)
                        total_page+=1;

                      print("last index ${customer_list_pageController.pageNumber} ${customer_list_pageController.total_rows} ${customer_list_pageController.rowsPerPage} ${total_page}");

                      if(customer_list_pageController.pageNumber+1!=total_page){
                        customer_list_pageController. getCustomerList(customer_list_pageController.pageNumber+1);
                        customer_list_pageController.pageNumber+=1;
                      }
                    }
                  });
                  return BindCustomerList(context, index);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: .05,
                    color: AllColors.primaryDark1,
                    thickness: .5,
                  );
                },
                itemCount:
                customer_list_pageController.customer_list.length),
          ));
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            'No Record Found.',
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twentee,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
    }
  }

  BindCustomerList(BuildContext context, int index) {
    return
      ListTile(
        onTap: () {
          customer_list_pageController.updateLocation(index);
          customer_list_pageController.showGooglemapPointer1(index);
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Customer No:',
                style: GoogleFonts.poppins(
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w700,
                    color: AllColors.primaryDark1)),
            Container(
              width: size.width*.3,
              child: Tooltip(
                message: '${customer_list_pageController.customer_list[index].customerno ?? ""}',
                child: Text(
                    '${customer_list_pageController.customer_list[index].customerno ?? ""}',
                     overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w700,
                        color: AllColors.primaryDark1)),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                'Name : ',
                style: GoogleFonts.poppins(
                    fontSize: AllFontSize.sisxteen,
                    fontWeight: FontWeight.w500,
                    color: AllColors.primaryDark1),
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: size.width*.4,
                child: Tooltip(
                  message: '${customer_list_pageController.customer_list[index].name?? ""}',
                  child: Text(
                    '${customer_list_pageController.customer_list[index].name?? ""}',
                    style: GoogleFonts.poppins(
                        fontSize: AllFontSize.sisxteen,
                        fontWeight: FontWeight.w500,
                        color: AllColors.primaryDark1),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                  'Address : ',
                  style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w500,
                      color: AllColors.primaryDark1),
                  overflow: TextOverflow.ellipsis),
              Container(
                width: size.width*.4,
                child: Tooltip(
                  message: '${customer_list_pageController.customer_list[index].address ?? ""}',
                  child: Text(
                      '${customer_list_pageController.customer_list[index].address ?? ""}',
                      style: GoogleFonts.poppins(
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w500,
                          color: AllColors.primaryDark1),
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
            )
          ],
        ),
        leading: Container(
          width: 55,
          height: 75,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AllColors.primaryDark1
          ,border: Border.all(color: AllColors.primaryDark1,)),

          child: CircleAvatar(
            backgroundColor: AllColors.whiteColor,
            child: Icon(Icons.person),
          ),
        ));
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure minimal height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Filter",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        /*customer_list_pageController.getCustomerList(
                            customer_list_pageController.pageNumber);*/

                        customer_list_pageController
                            .customer_no_Controller.clear();
                        customer_list_pageController
                            .customer_name_Controller
                            .clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Icon(
                          Icons.cancel,
                          color: AllColors.primaryDark1,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                      height: 3, color: AllColors.primaryDark1, thickness: 1),
                ),
                Column(
                  children: [
                    TextField(
                      controller: customer_list_pageController.customer_no_Controller,
                      decoration: InputDecoration(
                        labelText: 'Customer No.',
                        hintText: 'Customer No.',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors
                                  .primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {

                        customer_list_pageController.customer_no_Controller.text=value;
                      },
                    ),
                    TextField(
                      controller: customer_list_pageController.customer_name_Controller,
                      decoration: InputDecoration(
                        labelText: 'Customer Name',
                        hintText: 'Customer Name',
                        hintStyle: GoogleFonts.poppins(
                          color: AllColors.lightblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.ten,
                        ),
                        labelStyle: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w700,
                          fontSize: AllFontSize.sisxteen,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AllColors
                                  .primaryDark1), // Change the color to green
                        ),
                      ),
                      cursorColor: AllColors.primaryDark1,
                      onChanged: (value) {
                        customer_list_pageController.customer_name_Controller.text=value;

                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.primaryDark, width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                              Get.back();
                             customer_list_pageController.pageNumber= 0; // Reset page number when applying filters

                              customer_list_pageController.getCustomerList(
                                  customer_list_pageController.pageNumber);


                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(
                                      color: AllColors.redColor, width: 1),
                                ),
                                backgroundColor: AllColors.whiteColor,
                                foregroundColor: AllColors.lightgreyColor),
                            onPressed: () {
                             // Get.back();
                              customer_list_pageController
                                  .customer_no_Controller
                                  .clear();
                              customer_list_pageController
                                  .customer_name_Controller
                                  .clear();

                              customer_list_pageController.getCustomerList(
                                  customer_list_pageController.pageNumber);

                            },
                            child: Text(
                              'Reset',
                              style: GoogleFonts.poppins(
                                  color: AllColors.redColor,
                                  fontSize: AllFontSize.sisxteen,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFullScreenDialog(BuildContext context, int index) {
    showGeneralDialog(
      context: context,
      barrierColor: AllColors.whiteColor,
      transitionDuration: Duration(milliseconds: 100),// Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      pageBuilder: (context, __, ___) {
        return Material( // Wrap with Material widget
          color: Colors.white,
          child: Container(
            child: Column(
              children: [
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
                              Get.back();
                               // customer_list_pageController.pageNumber=0;
                             // customer_list_pageController.onInit();
                              customer_list_pageController.customer_no_Controller.clear();
                              customer_list_pageController.customer_name_Controller.clear();
                              customer_list_pageController.getCustomerList(customer_list_pageController.pageNumber);
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
                      // customer_list_pageController.initCurrentLocationLatLant();
                      customer_list_pageController.getCustomerListGeoLocation(customer_list_pageController.indexes);
                      customer_list_pageController
                          .customer_no_Controller.clear();
                      customer_list_pageController
                          .customer_name_Controller
                          .clear();
                     // Navigator.pop(context);
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
                        'City :  ${customer_list_pageController.city.value==''?"":customer_list_pageController.city.value}',
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
                  child: showGoogleMap(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget showGoogleMap() {
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
      myLocationButtonEnabled: true,
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
