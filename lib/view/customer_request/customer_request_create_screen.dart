import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/models/customer_request/customer_type_model.dart';
import 'package:pristine_seeds/models/customer_request/sale_person_model.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_font_size.dart';
import '../../models/customer_request/vender_type_model.dart';
import '../../models/orders/states_model.dart';
import '../../utils/app_utils.dart';
import '../../view_model/customer_request_vm/customer_request_vm.dart';

class CustomerRequestCreate extends StatelessWidget{
  CustomerRequestCreate({super.key});
  final customer_create_controller=Get.put(CustomerViewModel());
  Size size = Get.size;
  static String _displayCustomerType(CustomerTypeResponse option) =>
      option.customerType!;

  static String _displayVenderType(VendarTypeResponse option) =>
      option.vendorType!;

  static String _displaySalePerson(SalePersonResponse option) =>
      option.name!;

  static String _displayStateName(StateModel option) =>
      option.stateName!;

  static String _displayGstCustomerType(String option) => option!;
  static String _displayCountry(String option) => option!;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(RoutesName.customerRequestList);
          return true;

        },
      child: Scaffold(
      body:  Container(
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
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: size.height * 0.09,
                          child: CircleBackButton(
                            press: () {
                              customer_create_controller.name_controller.clear();
                              customer_create_controller.getCustomerRequestList(customer_create_controller.status.value);
                              Get.toNamed(RoutesName.customerRequestList);
                            },
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Obx(() {
                            return  Container(
                              padding: EdgeInsets.only(left: 12),
                              child: Text("Customer Request ${customer_create_controller.flag.value}"/*customer_create_controller.flag.value=="Update"?"Customer Request Update":"Customer Request Create"*/,
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize:  15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Obx(() {
                              return Visibility(
                                visible: customer_create_controller.flag.value=="Update" || customer_create_controller.flag.value=="View" ?true:false,
                                child: Text('(Request No :  ${customer_create_controller.request_no.value.toString()})',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    )),
                              );
                            },),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(() {
                        return  Visibility(
                          visible: customer_create_controller.flag.value=="Update" || customer_create_controller.flag.value=="View" ?true:false,
                          child: Container(
                            child: ActionChip(
                              elevation: 2,
                              padding: EdgeInsets.all(2),
                              backgroundColor: AllColors.primaryDark1,
                              shadowColor: Colors.black,
                              shape: StadiumBorder(
                                  side: BorderSide(color: AllColors.primaryliteColor)),
                              //avatar: Icon(Icons.add, color: AllColors.customDarkerWhite),
                              //CircleAvatar
                              label: Text(customer_create_controller.status.value=="Completed"?"View":"Upload",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.customDarkerWhite,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onPressed: () {
                                customer_create_controller.showLineImagesPopup(context);
                                //   customer_create_controller.flag.value="Submit";
                                // Get.toNamed(RoutesName.customerRequestCreate);
                              }, //Text
                            ),
                          ),
                        );
                      },
                      //  child:
                      ),

                    ],
                  ),
                /*  Obx(() {
                    return Visibility(
                      visible: customer_create_controller.flag.value=="Update" || customer_create_controller.flag.value=="View" ?true:false,
                      child: Text('Request No :  ${customer_create_controller.request_no.value.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w700,
                            fontSize: AllFontSize.sisxteen,
                          )),
                    );
                  },),*/
                ],
              ),
            ),
            Obx(() {
             return Visibility(
                visible:customer_create_controller.isLoading.value ,
                child: LinearProgressIndicator(
                  backgroundColor: AllColors.primaryDark1,
                  color: AllColors.primaryliteColor,
                ),
              );
           },),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Obx(() {
                        return Visibility(
                          visible: customer_create_controller.flag.value=="Update"?true:false,
                          child: Text('Request No :  ${customer_create_controller.request_no.value.toString()}',
                              style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.sisxteen,
                              )),
                        );
                      },
                        //child:
                      ),*/

                      bindName(context),
                      SizedBox(height: 8.0),
                      bindAddress(context),
                       SizedBox(height: 8.0),
                       bindContact(context),
                      SizedBox(height: 8.0),
                      bindContactNo(context),
                      SizedBox(height: 8.0),
                      Obx(() {
                        return  Visibility(
                            visible: customer_create_controller.isDropDown.value ,
                            child: bindSalePerson(context));
                      },),
                      SizedBox(height: 8.0),
                      Obx(
                        () {
                          return Visibility(
                              visible:customer_create_controller.isDropDown.value ,
                              child: bindCustomerType(context));
                        },
                      ),
                      SizedBox(height: 8.0),
                      Obx(() {
                          return Visibility(
                              visible:customer_create_controller.isDropDown.value ,
                              child: bindVenderType(context));
                        },
                      ),
                      SizedBox(height: 8.0),
                      Obx(() {
                        return  Visibility(
                            visible:customer_create_controller.isDropDown.value,
                            child: bindStateCode(context));
                      },
                      ),
                      SizedBox(height: 8.0),
                      bindCountryRegion(context),
                      SizedBox(height: 8.0),
                     bindPostCode(context),
                      SizedBox(height: 8.0),
                      bindEmail(context),
                      SizedBox(height: 8.0),
                      bindPhoneNo(context),
                      SizedBox(height: 8.0),
                      bindGstRegistrationNO(context),
                      SizedBox(height: 8.0),
                      bindGstRegistrationType(context),
                      SizedBox(height: 8.0),
                      Obx(() {
                       return Visibility(
                           visible: customer_create_controller.isDropDown.value,
                           child: bindGstCustomerType(context));
                      }),
                      SizedBox(height: 8.0),
                      bindPanNo(context),
                      SizedBox(height: 8.0),
                      bindZone(context),
                      SizedBox(height: 8.0),
                      bindDistrict(context),
                      SizedBox(height: 8.0),
                      bindRegion(context),
                      SizedBox(height: 8.0),
                      bindTaluka(context),
                      SizedBox(height: 8.0),
                      bindTerritoryType(context),
                      SizedBox(height: 8.0),
                      bindSeedLicenseNo(context),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              color: AllColors.primaryliteColor,
            ),

            Padding(padding:
            EdgeInsets.only(left: 20, right: 20, top: 12,bottom: 20),
              child:Visibility(
                visible:customer_create_controller.status=="Completed"?false:true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Obx(() {
                      return
                        Expanded(
                          child: DefaultButton(
                            text:customer_create_controller.flag.value=="Update"?"Update":"Submit",
                            press: () {
                              if(customer_create_controller.flag.value=="Update"){
                                print(customer_create_controller.flag.value);
                                customer_create_controller.customerRequestUpdate();
                              }else{
                                print(customer_create_controller.flag.value);
                                customer_create_controller.customerRequestCreate();
                              }
                            },
                            //  loading: seedDispatch_VM_Controller.button_loading.value,
                          ),
                        );
                   }),
                    SizedBox(width: size.width * .01),

                    Obx(() {
                      return
                        Expanded(
                        child: DefaultButton(
                          text:customer_create_controller.flag.value=="Update"?"Complete":"Reset",
                          press: () {
                            if(customer_create_controller.flag.value=="Update"){
                              customer_create_controller.customerRequestComplete();
                            }else{
                              customer_create_controller.resetAllFields();
                            }
                          },
                        ),
                      );
                    },
                      //  child:
                    ),
                  ],
                ),
              ),
               // child:
              ),


          ],
        ),
      ),
      ),
    );
  }

  Widget bindName( context) {
    return TextField(
      readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
      controller: customer_create_controller.name_controller,
     //  ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Name',
        labelText: 'Name',
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
  }
  Widget bindAddress( context) {
    return TextField(
       readOnly:customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.address_controller,
       // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Address',
        labelText: 'Address',
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
  }
  Widget bindContact( context) {
    return TextField(
       readOnly:customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.contact_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Contact',
        labelText: 'Contact',
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
  }
  Widget bindContactNo( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
      keyboardType: TextInputType.number,
      controller: customer_create_controller.contact_no_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Contact No.',
        labelText: 'Contact No.',

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
  }
  Widget bindSalePerson(context) {
    return Autocomplete<SalePersonResponse>(
      displayStringForOption: _displaySalePerson,
      optionsBuilder: (TextEditingValue textEditingValue) async {
      /*  if (textEditingValue.text.isEmpty) {
          return customer_create_controller.sale_person_list;
          // return const Iterable<PaymentTermModel>.empty();
        }*/

        if (textEditingValue.text.isEmpty) {
          customer_create_controller.isShowDocDropDown.value = false;
          return [];
        }

        return await customer_create_controller.searchSalePerson(textEditingValue.text);

        if(customer_create_controller.isReadOnly.value){
          customer_create_controller.sale_person_list.value=[];
        }
        if(customer_create_controller.flag.value=='View')
        {
          customer_create_controller.sale_person_list.value=[];
        }

      /*  return customer_create_controller.sale_person_list
            .where((SalePersonResponse option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/

      },
      onSelected: (SalePersonResponse selection) {
        print(selection.name);


        customer_create_controller.sale_person_controller.text =
            _displaySalePerson(selection).toString();

        //  seedDispatch_VM_Controller.selected_item_category.value = selection



        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: customer_create_controller.status.value=="Completed"?true:false,
          controller: controller
            ..text = customer_create_controller.sale_person_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Sale Person',
            labelText: 'Sale Person',
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
          AutocompleteOnSelected<SalePersonResponse> onSelected,
          Iterable<SalePersonResponse> suggestions) {
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
                  final SalePersonResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.name.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
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
  Widget bindCountryRegion( context) {
    return Autocomplete<String>(
      displayStringForOption: _displayCountry,
      optionsBuilder: (TextEditingValue textEditingValue ) async {
        if (textEditingValue.text.isEmpty) {
          return customer_create_controller.countryTypeList;
          // return const Iterable<PaymentTermModel>.empty();
        }
        if(customer_create_controller.isReadOnly.value){
          customer_create_controller.countryTypeList=[];
        }
        if(customer_create_controller.flag.value=='View')
        {
          customer_create_controller.countryTypeList=[];
        }

        return  customer_create_controller.countryTypeList;
      },
      onSelected: (String selection) {
        print(selection);
        customer_create_controller.country_region_controller.text =
            _displayCountry(selection).toString();
        //customer_create_controller.selected_type.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly:customer_create_controller.status.value=="Completed"?true:false,
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = customer_create_controller.country_region_controller.text,
          focusNode: focusNode,
          onChanged: (String value) {
            customer_create_controller.country_region_controller.text = value;
          },
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Enter Country Region',
            labelText: 'Country/Region Code',
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
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );;
      },
    );
  }
/*  Widget bindCountryRegion( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.country_region_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Country Region',
        labelText: 'Country/Region Code',
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
  }*/
  Widget bindPostCode( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       keyboardType: TextInputType.number,
       controller: customer_create_controller.post_code_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Post Code',
        labelText: 'Post Code',
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
  }
  Widget bindEmail( context) {
    return TextField(
       readOnly:customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.email_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Email',
        labelText: 'Email',
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
  }
  Widget bindPhoneNo( context) {
    return TextField(
       readOnly:customer_create_controller.status.value=="Completed"?true:false,
       keyboardType: TextInputType.number,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.mobile_no_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Mobile No.',
        labelText: 'Mobile No.',
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
  }
  Widget bindGstRegistrationNO( context) {
    return TextField(
      readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.registration_no_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Registration No.',
        labelText: 'Registration No.',
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
  }
  Widget bindGstRegistrationType( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.registration_type_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Registration Type',
        labelText: 'Registration Type',
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
  }
  Widget bindGstCustomerType( context) {
    return Autocomplete<String>(
      displayStringForOption: _displayGstCustomerType,
      optionsBuilder: (TextEditingValue textEditingValue ) async {
        if (textEditingValue.text.isEmpty) {
          return customer_create_controller.gstCustomerTypeList;
          // return const Iterable<PaymentTermModel>.empty();
        }
        if(customer_create_controller.isReadOnly.value){
          customer_create_controller.gstCustomerTypeList=[];
        }
        if(customer_create_controller.flag.value=='View')
        {
          customer_create_controller.gstCustomerTypeList=[];
        }

        return  customer_create_controller.gstCustomerTypeList;
      },
      onSelected: (String selection) {
        print(selection);
        customer_create_controller.gst_customer_type_controller.text =
            _displayGstCustomerType(selection).toString();
        //customer_create_controller.selected_type.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly:customer_create_controller.status.value=="Completed"?true:false,
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = customer_create_controller.gst_customer_type_controller.text,
          focusNode: focusNode,
          onChanged: (String value) {
            customer_create_controller.gst_customer_type_controller.text = value;
          },
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Enter Gst Customer Type',
            labelText: 'Gst Customer Type',
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
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );;
      },
    );
  }

  Widget bindPanNo( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.pan_no_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Pan No.',
        labelText: 'Pan No.',
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
  }
  Widget bindStateCode(context) {
    return Autocomplete<StateModel>(
      displayStringForOption: _displayStateName,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return customer_create_controller.state_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        if(customer_create_controller.isReadOnly.value){
          customer_create_controller.state_list.value=[];
        }
        if(customer_create_controller.flag.value=='View')
        {
          customer_create_controller.state_list.value=[];
        }
        return customer_create_controller.state_list
            .where((StateModel option) {
          return option.stateName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (StateModel selection) {
        print(selection.stateName);


        customer_create_controller.state_code_controller.text =
            _displayStateName(selection).toString();
     //   customer_create_controller.StateName.value= _displayStateName(selection).toString() ;
        customer_create_controller.StateCode=selection.stateCode!;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
            readOnly:customer_create_controller.status.value=="Completed"?true:false,
          controller: controller
            ..text = customer_create_controller.state_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: ' State Name',
            labelText: 'Select State Name',
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
          AutocompleteOnSelected<StateModel> onSelected,
          Iterable<StateModel> suggestions) {
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
                  final StateModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.stateName.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
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
  Widget bindZone( context) {
    return TextField(
       readOnly:customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.zone_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Zone',
        labelText: 'Zone',
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
  }
  Widget bindDistrict( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.district_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter District ',
        labelText: 'District',
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
  }
  Widget bindRegion( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.reagion_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Region',
        labelText: 'Region',
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
  }
  Widget bindTaluka( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.taluka_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Taluka',
        labelText: 'Taluka',
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
  }
  Widget bindCustomerType(context) {
    return Autocomplete<CustomerTypeResponse>(
      displayStringForOption: _displayCustomerType,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return customer_create_controller.Customer_type_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        if(customer_create_controller.isReadOnly.value){
          customer_create_controller.Customer_type_list.value=[];
        }
        if(customer_create_controller.flag.value=='View')
        {
          customer_create_controller.Customer_type_list.value=[];
        }
        return customer_create_controller.Customer_type_list
            .where((CustomerTypeResponse option) {
          return option.customerType
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (CustomerTypeResponse selection) {
        print(selection.customerType);

        customer_create_controller.customer_type_controller.text =
            _displayCustomerType(selection).toString();
       // seedDispatch_VM_Controller.selected_item_category.value = selection;
        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly:customer_create_controller.status.value=="Completed"?true:false,
          controller: controller
            ..text = customer_create_controller.customer_type_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Customer Type',
            labelText: 'Select Customer Type',
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
          AutocompleteOnSelected<CustomerTypeResponse> onSelected,
          Iterable<CustomerTypeResponse> suggestions) {
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
                  final CustomerTypeResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.customerType.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
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
  Widget bindTerritoryType( context) {
    return TextField(
       readOnly: customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.territory_type_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Territory Type',
        labelText: 'Territory Type',
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
  }
  Widget bindSeedLicenseNo( context) {
    return TextField(
       readOnly:customer_create_controller.status.value=="Completed"?true:false,
      cursorColor:AllColors.primaryDark1 ,
       controller: customer_create_controller.seed_licence_controller,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Seed Licence No.',
        labelText: ' Seed Licence No.',
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
  }
  Widget bindVenderType(context) {
    return Autocomplete<VendarTypeResponse>(
      displayStringForOption: _displayVenderType,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return customer_create_controller.vender_type_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        if(customer_create_controller.flag.value=='View')
        {
          customer_create_controller.vender_type_list.value=[];
        }
        if( customer_create_controller.isReadOnly.value){
         // customer_create_controller.isDropDown.value=false;
          customer_create_controller.vender_type_list.value=[];
        }else{
          return customer_create_controller.vender_type_list
              .where((VendarTypeResponse option) {
            return option.vendorType
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
          //customer_create_controller.isDropDown.value=true;
        }
        return customer_create_controller.vender_type_list
            .where((VendarTypeResponse option) {
          return option.vendorType
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (VendarTypeResponse selection) {
        print(selection.vendorType);


        customer_create_controller.vendor_type_controller.text =
          _displayVenderType(selection).toString();
      //  seedDispatch_VM_Controller.selected_item_category.value = selection;


        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: customer_create_controller.status.value=="Completed"?true:false,
          controller: controller
            ..text = customer_create_controller.vendor_type_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Vendor Type',
            labelText: 'Select Vendor Type',
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
          AutocompleteOnSelected<VendarTypeResponse> onSelected,
          Iterable<VendarTypeResponse> suggestions) {
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
                  final VendarTypeResponse option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.vendorType.toString(),
                        style: GoogleFonts.poppins(
                            color: AllColors.blackColor,
                            fontWeight: FontWeight.w300,
                            fontSize: AllFontSize
                                .sisxteen // Change the text color here
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








}

