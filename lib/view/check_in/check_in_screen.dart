
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pristine_seeds/components/default_button.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/models/check_in/vehicle_type_response.dart';
import 'package:pristine_seeds/view/home_view/home_pge_screen.dart';
import '../../components/back_button.dart';
import '../../models/check_out/vehicle_no_response.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../view_model/check_in_vm/check_in_vm.dart';

class CheckInScreen extends StatelessWidget {
  CheckInScreen({super.key});

  final CheckInViewModel pageController = Get.put(CheckInViewModel());
  XFile? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode typeAheadFocusNode = FocusNode();

  static String _displayStringForOption(VehicleTypeResponse option) =>
      option.vehicleType!;
  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;
  static String _displayvehiclenoForOption(VehicleNoResponse option) =>
      option.vehicleNumber!;
  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
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
              CircularProgressIndicator(color: AllColors.primaryDark1,), // You can use any progress indicator here
            );
          } else {
            // Show the UI when not loading
            return Column(
              children: [
                //todo header section
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
                              Get.off(HomePageScreen());
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Check In",
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.twentee,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 12),
                    shrinkWrap: true,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Obx((){
                                return Visibility(visible: pageController.isVehicle.value,
                                  child: bindVehicleTypeDropDown(context), );

                              }),
                              //todo Dropdown Widget


                              SizedBox(height: size.height * 0.02),
                              //todo place TextFormField
                              TextFormField(
                                controller:
                                pageController.place_edit_controller.value,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Place can't be blank";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // Clear the error when the user enters a value
                                  if (value.isNotEmpty) {
                                    _formKey.currentState?.validate();
                                  }
                                },
                                maxLength: 100,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: AllFontSize.two,
                                      horizontal: AllFontSize.one),
                                  hintText: "Enter Place Name",
                                  labelText: 'Place',
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
                              ),
                              SizedBox(height: size.height * 0.02),

                              //todo working with Checkbox
                              Row(
                                children: [
                                  Obx(() {
                                    return Checkbox(
                                      value: pageController
                                          .isCheckBoxChecked.value,
                                      activeColor: AllColors.primaryDark1,
                                      onChanged: (value) {
                                        pageController.checkin_opening_km_controller.value.text='';
                                        pageController.vehicle_no_controller.text='';
                                        pageController.isCheckBoxChecked.value = value ?? false;
                                      },
                                    );
                                  }),
                                  Text(
                                    'Working With',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: AllFontSize.fourtine,
                                    ),
                                  ),
                                ],
                              ),
                              //todo working with employess Dropdown Widget
                              Obx(
                                    () => Visibility(
                                  visible: pageController.isCheckBoxChecked.value,
                                  child: bindemployeeDropDown(context),
                                ),
                              ),
                              //todo vehivle number......
                              Obx(
                                    () => Visibility(
                                  visible: (pageController.selected_vehicle_type!.value.isMaintainKm!=null && pageController.selected_vehicle_type!.value.isMaintainKm!>0 && pageController.isCheckBoxChecked==false),
                                  child:Column(
                                    children: [
                                      Obx(() {
                                        return Visibility(
                                          visible:pageController.isvehicleNo.value,
                                            child: bindVehicleNoDropDown(context));
                                      },
                                      ),

                                          //child: bindVehicleNoDropDown(context)),
                                      SizedBox(height: size.height * 0.02),
                                      bindOpeningkm(context),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height * 0.04),
                              //todo Image Uploader Pickers
                              Obx(() {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Visibility(
                                      visible: true,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              pageController.getFrontImage('CheckIn','');
                                              print('hjgh');
                                            },
                                            child: DottedBorder(
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(20),
                                              dashPattern: [10, 5, 10, 5],
                                              child: Container(
                                                width: size.width * 0.40,
                                                height: size.height * 0.22,
                                                child: pageController
                                                    .inFront_image_path
                                                    .isNotEmpty
                                                    ? ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(20.0),
                                                  child: kIsWeb
                                                      ? Image.network(
                                                    pageController
                                                        .inFront_image_path
                                                        .toString(),
                                                    fit: BoxFit
                                                        .cover, // Use BoxFit.cover to make the image fit
                                                  )
                                                      : Image.file(
                                                    File(pageController
                                                        .inFront_image_path
                                                        .toString()),
                                                    fit: BoxFit
                                                        .cover, // Use BoxFit.cover to make the image fit
                                                  ),
                                                )
                                                    : Icon(
                                                  Icons.camera,
                                                  size: 60,
                                                  color: AllColors
                                                      .primaryDark1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            'Front Image',
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontWeight: FontWeight.w700,
                                              fontSize: AllFontSize.fourtine,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: !pageController
                                          .isCheckBoxChecked.value && pageController.isManiTainKm.value>0,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              pageController
                                                  .getBackImage('CheckIn');
                                            },
                                            child: DottedBorder(
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(20),
                                              dashPattern: [10, 5, 10, 5],
                                              child: Container(
                                                width: size.width * 0.40,
                                                height: size.height * 0.22,
                                                child: pageController
                                                    .inBack_image_path
                                                    .isNotEmpty
                                                    ? ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(20.0),
                                                  child: kIsWeb
                                                      ? Image.network(
                                                    pageController
                                                        .inBack_image_path
                                                        .toString(),
                                                    fit: BoxFit
                                                        .cover, // Use BoxFit.cover to make the image fit
                                                  )
                                                      : Image.file(
                                                    File(pageController
                                                        .inBack_image_path
                                                        .toString()),
                                                    fit: BoxFit
                                                        .cover, // Use BoxFit.cover to make the image fit
                                                  ),
                                                )
                                                    : Icon(
                                                  Icons.camera,
                                                  size: 60,
                                                  color: AllColors
                                                      .primaryDark1,
                                                ), // Placeholder icon
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            'Back Image',
                                            style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontWeight: FontWeight.w700,
                                              fontSize: AllFontSize.fourtine,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              SizedBox(height: size.height * 0.04),
                              //todo submit button ui
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                // Space between the buttons
                                children: [
                                  Expanded(
                                    child: DefaultButton(
                                      text: "Submit",
                                      press: () {
                                        pageController.submitCheckInDataApi1(
                                            pageController.place_edit_controller.value);
                                      },
                                        loading: pageController.loading.value,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  // Adjust the spacing as needed
                                  Expanded(
                                    child: DefaultButton(
                                      text: "Reset",
                                      press: () {
                                        _formKey.currentState?.reset();
                                        pageController.typeAheadControllerVehicle.clear();
                                        pageController.place_edit_controller.value.clear();
                                        pageController.typeAheadControllerEmployee.clear();
                                        pageController.isCheckBoxChecked.value = false;
                                        pageController.inFront_image_path.value = '';
                                        pageController.inBack_image_path.value = '';
                                        // pageController.resetField();
                                        pageController.vehicle_no_controller.clear();
                                        pageController.isVehicle.value=false;
                                        pageController.isVehicle.value=true;
                                      },
                                      loading: pageController.loading.value = false,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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

  //todo vehicles dropdown
  Widget bindVehicleTypeDropDown(context) {
 /*   return Autocomplete<VehicleTypeResponse>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          pageController.isShowCheckinVehicleNo.value=false;
          //pageController.vehicle_no_controller.text='';
          //pageController.checkin_opening_km_controller.text='';
          //pageController.vehicleNoList.clear();
          return pageController.vehicleTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return pageController.vehicleTypeList
            .where((VehicleTypeResponse option) {
          return option.vehicleType
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (VehicleTypeResponse selection) {
        //pageController.isShowCheckinVehicleNo.value=true;
        pageController.selected_vehicle_type!.value=selection!;
        pageController.isManiTainKm.value=selection.isMaintainKm!;
        // Update the TextField with the selected
        pageController.typeAheadControllerVehicle.text = _displayStringForOption(selection).toString();
        pageController.getVehicleNumber1(pageController.typeAheadControllerVehicle.text);
       // pageController.getVehicletype();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor:AllColors.primaryDark1,
          controller: controller..text=pageController.typeAheadControllerVehicle.text,
          focusNode: focusNode,
          readOnly: true,
          onChanged: (value){
            if (value.isNotEmpty) {
              pageController.isShowCheckinVehicleNo.value = true;
              // Set the flag to true to open the dropdown
            }
           // if(value==""){
             pageController.typeAheadControllerVehicle.text=value.toString();
              pageController.typeAheadControllerVehicle.clear();
              pageController.isvehicleNo.value=false;
              pageController.isvehicleNo.value=true;
              pageController.vehicle_no_controller.text=value.toString();
              pageController.vehicleNoList=[];
              pageController.vehicle_no_controller.clear();

            //}
          },
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: (){
                pageController.isShowCheckinVehicleNo.value=true;
              },
                child: Icon(Icons.arrow_drop_down)
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Vehicle Type',
            labelText: 'Vehicle Type',
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
          AutocompleteOnSelected<VehicleTypeResponse> onSelected,
          Iterable<VehicleTypeResponse> suggestions) {
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
                  final VehicleTypeResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.vehicleType.toString(),
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
*/
    return Container(
      width: size.width*.94,
      child: DropdownMenu<VehicleTypeResponse>(
        width: size.width * .94,
        controller: pageController.typeAheadControllerVehicle,
        label: Text(
          "Vehicle Type",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //hintStyle:TextStyle(color: ),
          //labelStyle: TextStyle(color: AllColors.primaryDark1,fontSize: AllFontSize.sisxteen,fontWeight: FontWeight.w700),
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        enabled: true,
        onSelected: (VehicleTypeResponse? selection) {
          //pageController.isShowCheckinVehicleNo.value=true;
          pageController.selected_vehicle_type!.value=selection!;
          pageController.isManiTainKm.value=selection.isMaintainKm!;
          // Update the TextField with the selected
          pageController.typeAheadControllerVehicle.text = _displayStringForOption(selection).toString();
          pageController.getVehicleNumber(pageController.typeAheadControllerVehicle.text,'');
          pageController.vehicle_no_controller.clear();
          pageController.checkin_opening_km_controller.value.clear();
          // pageController.getVehicletype();
        },
        dropdownMenuEntries:
        pageController.vehicleTypeList.map<DropdownMenuEntry<VehicleTypeResponse>>((VehicleTypeResponse e) {
          return DropdownMenuEntry<VehicleTypeResponse>(value: e, label: e.vehicleType!);
        }).toList(),
      ),
    );
  }





  //todo employee dropdown
  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
       /* if (textEditingValue.text.isEmpty) {
          return pageController.employeeTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
*/
        if (textEditingValue.text.isEmpty) {
          pageController.isShowCustomerDetails.value = false;
          return [];
        }

        return await pageController.searchCustomer(textEditingValue.text);
        return pageController.employeeTypeList
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
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1 ,
          controller: controller..text=pageController.typeAheadControllerEmployee.text,
          focusNode: focusNode,
          onChanged: (value){
            pageController.typeAheadControllerEmployee.clear();
          },
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
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
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

  //todo for vehicle number
  /*Widget bindVehicleNoDropDown(context) {
    return Autocomplete<VehicleNoResponse>(
      displayStringForOption: _displayvehiclenoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          pageController.checkin_opening_km_controller.value.text='';
          return pageController.vehicleNoList;
        }

        if( pageController.isVehicle.isTrue) {
            //pageController.vehicleNoList=[];
            pageController.vehicle_no_controller.clear();
          }

        return pageController.vehicleNoList
            .where((VehicleNoResponse option) {
          return option.vehicleNumber
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (VehicleNoResponse selection) {
        print(selection.vehicleNumber);
        pageController.vehicle_no_controller.text = _displayvehiclenoForOption(selection).toString();
        pageController.checkin_opening_km_controller.value.text = selection.closingKm.toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: controller..text = pageController.vehicle_no_controller.text,
          focusNode: focusNode,
          onChanged: (text){

          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Vehicle No.',
            labelText: 'Vehicle No.',
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
              borderSide: BorderSide(color: AllColors.primaryDark1),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please select a vehicle number';
            }
            return null;
          },
        );
      },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<VehicleNoResponse> onSelected, Iterable<VehicleNoResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: suggestions.isEmpty
                  ? Text(
                'No Record Found!',
                style: GoogleFonts.poppins(
                  color: AllColors.lightblackColor,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500,
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final VehicleNoResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                      if (_formKey.currentState!.validate()) {
                        print('No selection');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.vehicleNumber.toString(),
                        style: GoogleFonts.poppins(
                          color: AllColors.blackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: AllFontSize.sisxteen,
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
  }*/

  Widget bindVehicleNoDropDown(context) {
    /*   return Autocomplete<VehicleTypeResponse>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          pageController.isShowCheckinVehicleNo.value=false;
          //pageController.vehicle_no_controller.text='';
          //pageController.checkin_opening_km_controller.text='';
          //pageController.vehicleNoList.clear();
          return pageController.vehicleTypeList;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return pageController.vehicleTypeList
            .where((VehicleTypeResponse option) {
          return option.vehicleType
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (VehicleTypeResponse selection) {
        //pageController.isShowCheckinVehicleNo.value=true;
        pageController.selected_vehicle_type!.value=selection!;
        pageController.isManiTainKm.value=selection.isMaintainKm!;
        // Update the TextField with the selected
        pageController.typeAheadControllerVehicle.text = _displayStringForOption(selection).toString();
        pageController.getVehicleNumber1(pageController.typeAheadControllerVehicle.text);
       // pageController.getVehicletype();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor:AllColors.primaryDark1,
          controller: controller..text=pageController.typeAheadControllerVehicle.text,
          focusNode: focusNode,
          readOnly: true,
          onChanged: (value){
            if (value.isNotEmpty) {
              pageController.isShowCheckinVehicleNo.value = true;
              // Set the flag to true to open the dropdown
            }
           // if(value==""){
             pageController.typeAheadControllerVehicle.text=value.toString();
              pageController.typeAheadControllerVehicle.clear();
              pageController.isvehicleNo.value=false;
              pageController.isvehicleNo.value=true;
              pageController.vehicle_no_controller.text=value.toString();
              pageController.vehicleNoList=[];
              pageController.vehicle_no_controller.clear();

            //}
          },
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: (){
                pageController.isShowCheckinVehicleNo.value=true;
              },
                child: Icon(Icons.arrow_drop_down)
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Vehicle Type',
            labelText: 'Vehicle Type',
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
          AutocompleteOnSelected<VehicleTypeResponse> onSelected,
          Iterable<VehicleTypeResponse> suggestions) {
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
                  final VehicleTypeResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.vehicleType.toString(),
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
*/
    return Container(
      width: size.width*.94,
      child: DropdownMenu<VehicleNoResponse>(
        width: size.width * .94,
        controller: pageController.vehicle_no_controller,

        label: Text(
          "Vehicle No. ",
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          //hintStyle:TextStyle(color: ),
          //labelStyle: TextStyle(color: AllColors.primaryDark1,fontSize: AllFontSize.sisxteen,fontWeight: FontWeight.w700),
          filled: false,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        enabled: true,
        onSelected: (VehicleNoResponse? selection) {
          pageController.vehicle_no_controller.text = _displayvehiclenoForOption(selection!).toString();
          pageController.checkin_opening_km_controller.value.text = selection.closingKm.toString();

          // pageController.getVehicletype();
        },

        dropdownMenuEntries:
        pageController.vehicleNoList.value.map<DropdownMenuEntry<VehicleNoResponse>>((VehicleNoResponse e) {
          return DropdownMenuEntry<VehicleNoResponse>(value: e, label: e.vehicleNumber!);
        }).toList(),
      ),
    );
  }


  Widget bindOpeningkm(context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: pageController.checkin_opening_km_controller.value,
      onChanged: (value) {
        pageController.checkin_opening_km_controller.value.text=value;

      },
      //maxLength: 100,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Opening Km",
        labelText: 'Opening Km',
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
          borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }
}
