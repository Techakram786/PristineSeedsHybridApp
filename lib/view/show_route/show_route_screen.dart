import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/font_weight.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../view_model/show_routes_vm/show_route_vm.dart';
class ShowRoutesScreen extends StatelessWidget {
  ShowRoutesScreen({super.key});
  final ShowRoutesVM pageController = Get.put(ShowRoutesVM());
  static String _displayemployeeForOption(EmpMasterResponse option) => option.loginEmailId!;
  static String _displayIntervalForOption(String option) => option!;
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Obx(() {
          if (pageController.loading.value) {
            // Show a progress indicator while loading
            return Center(
              child:
              CircularProgressIndicator(), // You can use any progress indicator here
            );
          } else {
            // Show the UI when not loading
            return Column(
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
                          "Location Routes",
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
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                      width: (size.width - 20) * 0.40,
                                      child: bindDatePicker(context)),
                                  Container(
                                    width: (size.width - 20) * 0.60,
                                    padding: EdgeInsets.only(left: 10),
                                    //child: bindEmployeeDropDown(context),
                                    child:bindIntervalDropDown(context),
                                  )
                                ],
                              ),
                            ),
                            bindemployeeDropDown(context),
                            SizedBox(height: size.height*0.01,),
                            //todo like dislike button section
                            Obx(() {
                              return Visibility(
                                visible: pageController.isVisible.value,
                                child: Container(
                                  width: double.infinity,
                                  height: size.height*.8,
                                  child: showGoogleMap(context),
                                ),
                              );
                            })
                            // bindListLayout(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  //todo date picker
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: pageController.filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
        labelStyle: GoogleFonts.poppins(
            color: AllColors.primaryDark1,
            fontWeight: FontWeight.w700,
            fontSize: AllFontSize.sisxteen),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
      onTap: () async {
        DateTime stating_date = new DateTime(1900);
        DateTime ending_date = new DateTime(2200);
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: stating_date,
            lastDate: ending_date,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AllColors.primaryDark1, // Header background color
                  //accentColor: AllColors.primaryDark1, // Color of the buttons
                  colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            });
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          pageController.filter_date_controller.text =
              outputFormat.format(date);
        else
          pageController.filter_date_controller.text = "";

      },
    );
  }

  //todo employee dropdown
 /* Widget bindEmployeeDropDown(context) {
    return TypeAheadField<EmpMasterResponse>(
      animationStart: 0,
      animationDuration: Duration.zero,
      textFieldConfiguration: TextFieldConfiguration(
        controller: pageController.typeAheadControllerEmployee,
        autofocus: false,
        style: TextStyle(fontSize: AllFontSize.fourtine),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical:AllFontSize.ten,horizontal: AllFontSize.ten),
          suffix: Icon(
            Icons.person,
            color: AllColors.primaryDark1,
          ),
          border: OutlineInputBorder(),
          hintText: 'Select Employee',
          labelText: 'Employee',
          labelStyle: TextStyle(color: AllColors.primaryDark1),
          helperStyle: TextStyle(color: AllColors.primaryDark1, fontSize: 14),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.green), // Border color when focused
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey), // Border color when not focused
          ),
        ),
        cursorColor: AllColors.primaryDark1,
      ),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        color: Colors.grey[50],
      ),
      suggestionsCallback: (pattern) {
        return pageController.getSuggestions(pattern);
      },
      itemBuilder: (context, employee) {
        return Container(
            padding: EdgeInsets.all(15),
            child: Text(
              '${employee.loginEmailId!.toString()}',
              style: TextStyle(color: Colors.black),
            ));
      },
      onSuggestionSelected: (suggestion) {
        pageController.typeAheadControllerEmployee.text =
            suggestion.loginEmailId!.toString();
        pageController.getCoordinatesList();
      },
    );
  }*/

  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return pageController.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return pageController.employess_List
            .where((EmpMasterResponse option) {
          return option.loginEmailId
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (EmpMasterResponse selection) {
        print(selection.loginEmailId);
        // Update the TextField with the selected
        pageController.typeAheadControllerEmployee.text =
            _displayemployeeForOption(selection).toString();
        pageController.getCoordinatesList(context);
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller..text=pageController.typeAheadControllerEmployee.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Employee',
            labelText: 'Employee',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten
            ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<EmpMasterResponse> onSelected,
          Iterable<EmpMasterResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final EmpMasterResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.loginEmailId.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen// Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bindIntervalDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displayIntervalForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return pageController.interval_list;
        }
        return pageController.interval_list;
      },
      onSelected: (String selection) {
        print(selection);
        pageController.typeAheadControllerInterval.text = _displayIntervalForOption(selection).toString();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = pageController.typeAheadControllerInterval.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Interval',
            labelText: 'Interval',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final String option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option,
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize.sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  //todo show map..............
  Widget showGoogleMap(context){
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

      markers: pageController.marker,
      onMapCreated: (GoogleMapController controller){
        pageController.completer.complete(controller);
      },
      polylines: pageController.polyline,
      myLocationEnabled: true,
      initialCameraPosition: pageController.kGooglePlex,
      mapType: MapType.normal,
    );
  }
}