import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/orders/customers_model.dart';
import '../../view_model/ipt_vm/ipt_vm.dart';

class IptHeaderCreate extends StatelessWidget{
  IptHeaderCreate({super.key});
  Size size=Get.size;
  final iptCreate_pageController=Get.put(IPTViewModel());
  static String _displayfromCustomerForOption(CustomersModel option) =>
      option.name!;

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: () async  {
         Get.offAllNamed(RoutesName.homeScreen);
         return true;
       },

         child: Scaffold(
           body: Container(
             width: double.infinity,
             height: size.height,
             child: SingleChildScrollView(
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
                             child: Text("New Ipt Create",
                               style: GoogleFonts.poppins(
                                 color: AllColors.primaryDark1,
                                 fontSize: 20,
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
               
                           ),
                           Spacer(),
               
                           /*    Obx(() {
                        return ActionChip(
                          elevation: 1,
                          tooltip: "Near By",
                          backgroundColor: orderspageController.isNearBy.value ? AllColors.grayColor : AllColors.primaryDark1,
                          shape: StadiumBorder(
                              side: BorderSide(color: AllColors.primaryDark1)
                          ),
                          label: Text(
                            'Near By',
                            style: GoogleFonts.poppins(
                              color: orderspageController.isNearBy.value ? AllColors.primaryDark1 : AllColors.whiteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {
                            // Update latitude and longitude values
                            orderspageController.lat.value = orderspageController.currentLat.value;
                            orderspageController.lng.value = orderspageController.currentLng.value;
                            orderspageController.isNearBy.value = true;
                            // Change the value of isNearBy to true
                            if(orderspageController.isNearBy.value = true){
                              orderspageController.isNearBy.value = false;
                            }
                           // Change '==' to '='
               
                            // Print the current latitude value
                            print('current.......${orderspageController.lat.value}');
                          },
                        );
                      }),*/
               
                           Obx(() {
                             return ActionChip(
                               elevation: 1,
                               tooltip: "Near By",
                               backgroundColor: iptCreate_pageController.isNearBy.value ? AllColors.primaryDark1 : AllColors.grayColor,
                               shape: StadiumBorder(
                                 side: BorderSide(color: AllColors.primaryDark1),
                               ),
                               avatar: Icon(Icons.location_on,color: iptCreate_pageController.isNearBy.value ? AllColors.whiteColor : AllColors.primaryDark1,),
                               label: Text(
                                 'Near By',
                                 style: GoogleFonts.poppins(
                                   color: iptCreate_pageController.isNearBy.value ? AllColors.whiteColor : AllColors.primaryDark1,
                                   fontSize: AllFontSize.fourtine,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                               onPressed: () {
                                 iptCreate_pageController.isNearBy.toggle();
                                 // Update latitude and longitude values based on isNearBy value
                                 if (iptCreate_pageController.isNearBy.value) {
                                   iptCreate_pageController.lat.value = iptCreate_pageController.currentLat.value;
                                   iptCreate_pageController.lng.value = iptCreate_pageController.currentLng.value;
                                 } else {
                                   iptCreate_pageController.lat.value =0.0;
                                   iptCreate_pageController.lng.value =0.0;
                                 }
                               },
                             );
                           }),
                         ],
                       ),
                     ),
                     Obx((){
                       return Visibility(
                         visible: iptCreate_pageController.loading.value?true:false,
                         child: Container(
                           margin: EdgeInsets.only(top: 1),
                           child: LinearProgressIndicator(
                             backgroundColor: AllColors.primaryDark1,
                             color: AllColors.ripple_green,
                           ),
                         ),
                       );
                     }),
                     ListView(
                       padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                       shrinkWrap: true,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Obx((){
                              return
                                 Visibility(
                                   visible: iptCreate_pageController.isShowDropDown.value,
                                   child: bindFromCustomerDropDown(context));
                             }),
               
                             Obx(() {
                               return Visibility(
                                   visible: iptCreate_pageController.isShowfrom_CustomerDetails.value,
                                   child: bindCustomerDetails(context));
                             }),
               
                             Obx((){
                               return
                               Visibility(
                                   visible: iptCreate_pageController.isShowDropDown.value,
                                   child: bindToCustomerDropDown(context));
                             }),
               
                             Obx(() {
                               return Visibility(
                                   visible: iptCreate_pageController.isShowto_CustomerDetails.value,
                                   child: bindToCustomerDetails(context));
                             }),
               
                           ],
                         ),
                       ],
               
                     ),
               
                     Container(
                       margin: EdgeInsets.only(top: 35, left: 10, right: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           /*Obx(() {
                                  return */Expanded(
                             child: DefaultButton(
                               text: "Submit",
                               press: () {
                                iptCreate_pageController.IptHeaderCreate();
                               },
                               // loading: orderspageController.loading.value,
                             ),
                           ),
                           // }),
                           SizedBox(width: size.width * .01),
                           Expanded(
                             child: DefaultButton(
                               text: "Reset",
                               press: () {
                                 iptCreate_pageController.resetAllNewIptFields();
                               },
                               //loading: pageController.loading.value,
                             ),
                           ),
                         ],
                       ),
                     ),
               
               ]),
             ),


           ),
         ),
         );
  }
  Widget bindFromCustomerDropDown(context) {
    return Autocomplete<CustomersModel>(
      displayStringForOption: _displayfromCustomerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          iptCreate_pageController.isShowfrom_CustomerDetails.value = false;
          return [];
        }

        return await iptCreate_pageController.searchCustomer(textEditingValue.text);
      },
      onSelected: (CustomersModel selection) {
       iptCreate_pageController.isShowfrom_CustomerDetails.value = true;
        //orderspageController.isShowCheck.value = true;
       iptCreate_pageController.selected_customer.value = selection;
       iptCreate_pageController.from_customer_no=selection.customerNo.toString();
       print("from_cust${iptCreate_pageController.selected_customer.value.address}");
        print(selection.name);
        print(selection.customerNo);
        iptCreate_pageController.from_customers_controller.text =
            _displayfromCustomerForOption(selection).toString();
       // orderspageController.order_expiry_date_controller.text=orderspageController.getCurrentExpryDate(selection.expiryNoOfDays!);
        FocusScope.of(context).unfocus();

      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor:AllColors.primaryDark1 ,
          controller: controller
            ..text = iptCreate_pageController.from_customers_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'From-Customer',
            labelText: 'From-Customer',
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
          AutocompleteOnSelected<CustomersModel> onSelected,
          Iterable<CustomersModel> suggestions) {
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
                  final CustomersModel option = suggestions.elementAt(index);
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

  Widget bindToCustomerDropDown(context) {
    return Autocomplete<CustomersModel>(
      displayStringForOption: _displayfromCustomerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          iptCreate_pageController.isShowto_CustomerDetails.value = false;
          return [];
        }
        return await iptCreate_pageController.searchCustomer(textEditingValue.text);
      },
      onSelected: (CustomersModel selection) {
        iptCreate_pageController.isShowto_CustomerDetails.value = true;
        //orderspageController.isShowCheck.value = true;
        iptCreate_pageController.selected_tocustomer.value = selection;
        iptCreate_pageController.to_customer_no=selection.customerNo.toString();
        print("to_cust${iptCreate_pageController.selected_tocustomer.value.address}");
        print(selection.name);
        print(selection.customerNo);
        iptCreate_pageController.to_customers_controller.text =
            _displayfromCustomerForOption(selection).toString();
        // orderspageController.order_expiry_date_controller.text=orderspageController.getCurrentExpryDate(selection.expiryNoOfDays!);
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor:AllColors.primaryDark1 ,
          controller: controller
            ..text = iptCreate_pageController.to_customers_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'To-Customer',
            labelText: 'To-Customer',
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
          AutocompleteOnSelected<CustomersModel> onSelected,
          Iterable<CustomersModel> suggestions) {
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
                  final CustomersModel option = suggestions.elementAt(index);
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


  Widget bindCustomerDetails(contex) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          iptCreate_pageController.selected_customer.value.address.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          iptCreate_pageController.selected_customer.value.stateName.toString() +
              " (" + iptCreate_pageController.selected_customer.value.stateCode
              .toString() + " )",
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          iptCreate_pageController.selected_customer.value.countryName.toString() +
              " (" +
              iptCreate_pageController.selected_customer.value.countryCode.toString() +
              " )," +
              iptCreate_pageController.selected_customer.value.postCode.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'GST:${iptCreate_pageController.selected_customer.value.gstRegistrationNo
              .toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Credit Limit: Rs. ${iptCreate_pageController.selected_customer.value
              .creditLimit.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Outstanding: Rs. ${iptCreate_pageController.selected_customer.value
              .currentOutstanding.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.redColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
      ],
    );
  }


  Widget bindToCustomerDetails(contex) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          iptCreate_pageController.selected_tocustomer.value.address.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          iptCreate_pageController.selected_tocustomer.value.stateName.toString() +
              " (" + iptCreate_pageController.selected_tocustomer.value.stateCode
              .toString() + " )",
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          iptCreate_pageController.selected_tocustomer.value.countryName.toString() +
              " (" +
              iptCreate_pageController.selected_tocustomer.value.countryCode.toString() +
              " )," +
              iptCreate_pageController.selected_tocustomer.value.postCode.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'GST:${iptCreate_pageController.selected_tocustomer.value.gstRegistrationNo
              .toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Credit Limit: Rs. ${iptCreate_pageController.selected_tocustomer.value
              .creditLimit.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Outstanding: Rs. ${iptCreate_pageController.selected_tocustomer.value
              .currentOutstanding.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.redColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
      ],
    );
  }


}