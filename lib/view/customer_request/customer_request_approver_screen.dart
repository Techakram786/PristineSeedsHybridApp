import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/models/customer_request/customer_request_approver_model.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../../view_model/customer_request_vm/customer_request_vm.dart';

class CustomerRequestApproverScreen extends StatelessWidget{
  CustomerRequestApproverScreen({super.key});
  Size size=Get.size;
  
  final customer_request_approver_pageController=Get.put(CustomerViewModel());

  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: () async {
         Get.offAllNamed(RoutesName.homeScreen);
         return false;
         },
       child: Scaffold(
         body: Container(
           width: double.infinity,
           height: size.height,
           child: Obx(() {
             if (customer_request_approver_pageController.isLoading.value) {
               return Center(
                 child:
                 CircularProgressIndicator(color: AllColors
                     .primaryDark1,), // You can use any progress indicator here
               );
             }
             else {
               return Column(
                 children: [
                   Container(
                     padding: EdgeInsets.only(
                         left: 10, right: 10, bottom: 0, top: 25),
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
                                 Get.offAllNamed(RoutesName.homeScreen);
                               },
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 20.0),
                           child: Text('Customer Request Approval',
                               style: GoogleFonts.poppins(
                                   color: AllColors.primaryDark1,
                                   fontSize: AllFontSize.eighteen,
                                   fontWeight: FontWeight.w700)),
                         ),
                       ],
                     ),
                   ),
                   Expanded(
                     child: Container(
                       padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                       child: SingleChildScrollView(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           // Adjust as needed
                           crossAxisAlignment: CrossAxisAlignment.start,
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
                                     child: bindemployeeDropDown(context),
                                   )
                                 ],
                               ),
                             ),
                             Container(
                               padding: EdgeInsets.only(top: 10),
                               child: Obx(() {
                                 return Row(
                                     mainAxisAlignment: MainAxisAlignment
                                         .spaceBetween,
                                     children: [
                                       Flexible(
                                         child: TextButton.icon(
                                           label: Text(
                                             "Pending: ${customer_request_approver_pageController.pending_count.value}",
                                             style: GoogleFonts.poppins(
                                                 fontSize: AllFontSize.twelve,
                                                 color: Colors.blue,
                                                 fontWeight: FontWeight.w700),
                                           ),
                                           icon: SizedBox.shrink(),
                                           //Icon(Icons.pending,),
                                           onPressed: () async {
                                             customer_request_approver_pageController.selection_type = "";
                                             customer_request_approver_pageController
                                                 .getCustomerApparverList();
                                           },
                                         ),
                                       ),
                                       Flexible(
                                         child: TextButton.icon(
                                           label: Text(
                                             "Approved: ${customer_request_approver_pageController.
                                             approvel_count.value}",
                                             style: GoogleFonts.poppins(
                                                 fontSize: AllFontSize.twelve,
                                                 color: AllColors.primaryDark1,
                                                 fontWeight: FontWeight.w700),
                                           ),
                                           icon: SizedBox.shrink(),
                                           //Icon(Icons.thumb_up, color: Colors.green,),
                                           onPressed: () async {
                                             customer_request_approver_pageController
                                                 .selection_type = "Approved";
                                             //productOnGround_controller.
                                             customer_request_approver_pageController
                                                 .getCustomerApparverList();
                                           },
                                         ),
                                       ),
                                       Flexible(
                                         child: TextButton.icon(
                                           label: Text(
                                             "Rejected: ${customer_request_approver_pageController
                                                 .rejected_count.value}",
                                             style: GoogleFonts.poppins(
                                                 fontSize: AllFontSize.twelve,
                                                 color: AllColors.redColor,
                                                 fontWeight: FontWeight.w700),
                                           ),
                                           icon: SizedBox.shrink(),
                                           //Icon(Icons.thumb_down, color: Colors.red),
                                           onPressed: () async {
                                             customer_request_approver_pageController
                                                 .selection_type = "Rejected";
                                             customer_request_approver_pageController
                                                 .getCustomerApparverList();
                                           },
                                         ),
                                       ),
                                     ]);
                               },
                               //  child:
                               ),
                             ),
                             Obx((){
                               return  bindListLayout();
                             }),

                           ],
                         ),
                       ),
                     ),
                   ),
                   //),
                 ],
               );
             }
           }),

         ),

       ),

     );
  }


  bindListLayout() {
    if (customer_request_approver_pageController.customer_request_approver_list == null ||
        customer_request_approver_pageController.customer_request_approver_list.isEmpty || customer_request_approver_pageController.customer_request_approver_list[0].condition=='False') {
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('No Records Found.', style: TextStyle(
            fontSize: 20,
            color: AllColors.primaryColor
        ),),
      );
    } else {
      return Container(
        height: size.height * .7,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) =>
                Divider(
                  height: .05,
                  color: AllColors.primaryDark1,
                ),
            itemCount: customer_request_approver_pageController.customer_request_approver_list.length,
            itemBuilder: (context, index) {
              var item = customer_request_approver_pageController.customer_request_approver_list[index];
              return BindListView(context, item, index);
            }),
      );
    }
  }

  Widget BindListView(context, CustomerRequestApproverResponse item, int position) {
    var date=item.createdOn??"";
    var orderDate = StaticMethod.dateTimeToDate(date);
    return InkWell(
      child: ListTile(
        onTap: () {
       //  showBottomSheetOpen(context,item);
          openBottomSheetDialog(context,position);
        },
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Request No : ${customer_request_approver_pageController.customer_request_approver_list[position]
                    .requestNo ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w600,
                  fontSize: AllFontSize.fourtine,
                )),
          ],
        ),

        subtitle: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Name : ${customer_request_approver_pageController.customer_request_approver_list
                  [position].name ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                        'Sale Person Code : ${customer_request_approver_pageController.customer_request_approver_list
                        [position].salesPersonCode ??''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w400,
                          fontSize: AllFontSize.twelve,
                        )),
                  ),
                  Text(
                      ' ${orderDate.toString()??''}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w400,
                        fontSize: AllFontSize.twelve,
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bindDatePicker(context) {
    return TextFormField(
      controller: customer_request_approver_pageController.filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: AllColors.primaryDark1), // Change the color to green
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
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },


        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          customer_request_approver_pageController.filter_date_controller.text =
              outputFormat.format(date);
        else
          customer_request_approver_pageController.filter_date_controller.text = "";
        customer_request_approver_pageController.getCustomerApparverList();
      },
    );
  }

  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return customer_request_approver_pageController.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return customer_request_approver_pageController.employess_List
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
        customer_request_approver_pageController.employee_name_controller.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = customer_request_approver_pageController.employee_name_controller
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
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
  openBottomSheetDialog(BuildContext context,int position){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
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
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('Approval Details',style: GoogleFonts.poppins(
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
                            Text('Request No.:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].requestNo.toString(),
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
                            Text('Name. ',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].name.toString(),
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
                            Text('Address:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].address.toString(),
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
                            Text('Contect :',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].contact?? '',
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
                            Text('Phone No:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].phoneNo.toString(),
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
                            Text('Sale Person  Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].salesPersonCode?? '',
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
                            Text('Country Region Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].countryRegionCode?? '',
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
                            Text('Post Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].postCode.toString()?? '',
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
                            Text('Email:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].email.toString()?? '',
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
                            Text('Mobile Phone No:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].mobilePhoneNo.toString(),
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
                            Text('Gst Registration No.:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].gstRegistractionNo.toString(),
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
                            Text('Gst Registration Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].gstRegistractionType.toString() ,
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
                            Text('Gst Customer Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].gstCustomerType.toString(),
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
                            Text('Pan No :',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].panNo.toString()   ,
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
                            Text('State Code:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].stateCode.toString(),
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
                            Text('District :',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].district.toString(),
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
                            Text('Region:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].region.toString(),
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
                            Text('Customer Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].customerType.toString(),
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
                            Text('Territory Type:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].territoryType.toString(),
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
                            Text('Seed Licence No:',style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700),),
                            Text(customer_request_approver_pageController.customer_request_approver_list[position].seedLicenseNo.toString(),
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700),),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),

            ),

            Container(
              child:  Padding(
                padding: const EdgeInsets.all(0),
                child: Visibility(
                  visible:  (customer_request_approver_pageController.selection_type == "Approved" || customer_request_approver_pageController.selection_type == "Rejected") ?
                  customer_request_approver_pageController.isshowBottom.value ==true :  customer_request_approver_pageController.isshowBottom.value == false,
                  child: Container(
                    // padding: EdgeInsets.only(bottom: 80),
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width * .4,
                          child: DefaultButton(
                            text: "Approve",
                            press: () {
                             showApproveDialog(context,customer_request_approver_pageController.customer_request_approver_list[position].requestNo!);
                            // Navigator.pop(context);
                            },
                            //  loading: viewCartController.loading.value,
                          ),
                        ),
                        Container(
                          width: size.width * .4,
                          child: DefaultButtonRed(
                            text: "Reject",
                            press: () {
                              showRemarkDialog(context, position);

                            },
                            //loading: viewCartController.loading.value,
                          ),
                        )
                      ],
                    ),
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

  void showRemarkDialog(context, int position) {
    customer_request_approver_pageController.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject...",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller:customer_request_approver_pageController.remarks_controller,
            decoration: InputDecoration(labelText: "Enter Remarks",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,))


            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                if(customer_request_approver_pageController.remarks_controller.text.isNotEmpty){
                  customer_request_approver_pageController
                      .markApproveReject(customer_request_approver_pageController.customer_request_approver_list[position].requestNo!, customer_request_approver_pageController.remarks_controller.text,'Rejected');
                  Navigator.of(context).pop();
                  Get.offAllNamed(RoutesName.customerRequestApproverList);
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }


  void showApproveDialog(context, String request_no) {
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Approve...",style: TextStyle(color: AllColors.primaryDark1,)),
          content:Text('Do you want to approve?',style: TextStyle(color: AllColors.primaryDark1),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                customer_request_approver_pageController.markApproveReject(request_no, '','Approved');
                Navigator.of(context).pop();
               Get.offAllNamed(RoutesName.customerRequestApproverList);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }




}