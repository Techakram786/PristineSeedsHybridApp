import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/components/default_button.dart';
import 'package:pristine_seeds/models/orders/consignee_model.dart';
import 'package:pristine_seeds/models/orders/customers_model.dart';
import 'package:pristine_seeds/models/orders/payment_terms_model.dart';
import 'package:pristine_seeds/models/orders/states_model.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../view_model/orders_vm/orders_vm.dart';

class NewOrderScreen extends StatelessWidget {
  NewOrderScreen({super.key});
  Size size=Get.size;
  final OrdersVM orderspageController = Get.put(OrdersVM());
  static String _displaybillToCustomerForOption(CustomersModel option) =>
      option.name!;

  static String _displayConsigneeForOption(ConsigneeModel option) =>
      option.name!;

  static String _displayPaymentTermsForOption(PaymentTermModel option) =>
      option.name!; //
  static String _displayStatesForOption(StateModel option) =>
      option.stateName!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                      child: Text("New Order",
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
                        backgroundColor: orderspageController.isNearBy.value ? AllColors.primaryDark1 : AllColors.grayColor,
                        shape: StadiumBorder(
                          side: BorderSide(color: AllColors.primaryDark1),
                        ),
                        avatar: Icon(Icons.location_on,color: orderspageController.isNearBy.value ? AllColors.whiteColor : AllColors.primaryDark1,),
                        label: Text(
                          'Near By',
                          style: GoogleFonts.poppins(
                            color: orderspageController.isNearBy.value ? AllColors.whiteColor : AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                         orderspageController.isNearBy.toggle();
                          // Update latitude and longitude values based on isNearBy value
                          if (orderspageController.isNearBy.value) {
                            orderspageController.lat.value = orderspageController.currentLat.value;
                            orderspageController.lng.value = orderspageController.currentLng.value;
                          } else {
                            orderspageController.lat.value =0.0;
                            orderspageController.lng.value =0.0;
                          }
                        },
                      );
                    }),
                  ],
                ),
              ),
              Obx((){
                return Visibility(
                  visible: orderspageController.isPogressIndicator.value?true:false,
                  child: Container(
                    margin: EdgeInsets.only(top: 1),
                    child: LinearProgressIndicator(
                      backgroundColor: AllColors.primaryDark1,
                      color: AllColors.ripple_green,
                      minHeight: 5,
                      value: 0,
                    ),
                  ),
                );
              }),


              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx((){
                          return  Visibility(
                              visible: orderspageController.isShowDropDown.value,
                              child: bindBillToCustomerDropDown(context));
                        }),

                        Obx(() {
                          return Visibility(
                              visible: orderspageController.isShowCustomerDetails.value,
                              child: bindCustomerDetails(context));
                        }),
                        Obx((){
                          return Visibility(
                            visible: orderspageController.isShowCustomerDetails.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: orderspageController.isCheckBoxChecked.value,
                                    activeColor: AllColors.primaryDark1,
                                    onChanged: (value) {
                                      orderspageController.isCheckBoxChecked.value = value ?? false;
                                      orderspageController.getConsignee(orderspageController.selected_customer.value.customerNo!);
                                    },
                                  );
                                }),
                                Text(
                                  'Ship to Address is different',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.fourtine,
                                  ),
                                ),
                                Spacer(),
                                Obx((){
                                  return   Visibility(
                                    visible: orderspageController.isCheckBoxChecked.value,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: InkWell(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: AllColors.primaryDark1,
                                                border: Border.all(color: AllColors.primaryliteColor,width: 2),
                                                borderRadius: BorderRadius.circular(100)
                                            ),
                                            child: Icon(Icons.add,color: AllColors.customDarkerWhite,)

                                        ),
                                        onTap: (){
                                          orderspageController.getStatesList();
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20.0),
                                              ),
                                            ),
                                            builder: (BuildContext context) {
                                              return SingleChildScrollView(
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery
                                                      .of(context)
                                                      .viewInsets
                                                      .bottom,
                                                ),
                                                child: Container(
                                                  // Customize the bottom sheet content as needed
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            top: 8.0),
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            'Add New Consignee',
                                                            style: GoogleFonts.poppins(
                                                                color: AllColors
                                                                    .primaryDark1,
                                                                fontSize: AllFontSize
                                                                    .sisxteen,
                                                                fontWeight: FontWeight
                                                                    .w700
                                                            ),),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.0),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 15.0, right: 15.0),
                                                        child: Column(
                                                          children: [
                                                            bindcosigneeName(context),
                                                            SizedBox(height: 8.0),
                                                            bindcontactName(context),
                                                            SizedBox(height: 8.0),
                                                            bindcosigneeContact(context),
                                                            SizedBox(height: 8.0),
                                                            Obx(() {
                                                              return  Visibility(
                                                                  visible: orderspageController.isStateName.value,
                                                                  child: bindStatesDropDown(context));
                                                            },
                                                            //  child:
                                                            ),

                                                            SizedBox(height: 8.0),
                                                            bindcosigneeAddress(context),
                                                            SizedBox(height: 8.0),
                                                            bindcosigneeAddress2(context),
                                                            SizedBox(height: 8.0),
                                                            bindcosigneeCity(context),
                                                            SizedBox(height: 8.0),
                                                            bindcosigneePincode(context),
                                                            SizedBox(height: 16.0),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Obx(() {
                                                                  return Expanded(
                                                                    child: DefaultButton(
                                                                      text: "Save",
                                                                      press: () {
                                                                        orderspageController.insertUpdateconsignee();
                                                                      },
                                                                      loading: orderspageController.loading.value,
                                                                    ),
                                                                  );
                                                                }),
                                                                SizedBox(width: size.width * .01),
                                                                Expanded(
                                                                  child: DefaultButton(
                                                                    text: "Reset",
                                                                    press: () {
                                                                      orderspageController.resetAllConsigneeFields();

                                                                    },
                                                                    //loading: pageController.loading.value,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 8.0),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }),

                              ],
                            ),
                          );
                        }),
                        //todo ship to address Dropdown Widget
                        Obx(
                              () =>
                              Visibility(
                                visible: orderspageController.isCheckBoxChecked.value,
                                child: bindConsigneeDropDown(context),
                              ),
                        ),
                        Obx(
                              () =>
                              Visibility(
                                visible:
                                orderspageController.isShowConsigneeDetails.value,
                                child: bindConsigneeDetails(context),
                              ),
                        ),
                        SizedBox(height: 8),
                        Obx((){
                          return Visibility(
                              visible: orderspageController.isShowDropDown.value,
                              child: bindPaymentTermsDropDown(context));
                        }),
                        SizedBox(height: 8),
                        bindDatePicker(context),
                        SizedBox(height: 8),
                        bindDatePickerExpiry(context),
                        SizedBox(height: size.height * .05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /*Obx(() {
                              return */Expanded(
                              child: DefaultButton(
                                text: "Submit",
                                press: () {
                                  orderspageController.orderHeaderCreate();
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
                                  orderspageController.resetAllNewOrderFields();
                                },
                                //loading: pageController.loading.value,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],

                ),
              )
            ],
          )),
    );

  }

  //todo date picker
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: orderspageController.order_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Date",
        labelText: 'Date',
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
          },

        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          orderspageController.order_date_controller.text = outputFormat.format(date);
        else
          orderspageController.order_date_controller.text = "";
      },
    );
  }
  Widget bindDatePickerExpiry(context) {
    return TextFormField(
      controller: orderspageController.order_expiry_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Expiry Date",
        labelText: 'Expiry Date',
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
          },
        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          orderspageController.order_expiry_date_controller.text =
              outputFormat.format(date);
        else
          orderspageController.order_expiry_date_controller.text = "";
      },
    );
  }
  Widget bindBillToCustomerDropDown(context) {
    return Autocomplete<CustomersModel>(
      displayStringForOption: _displaybillToCustomerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          orderspageController.isShowCustomerDetails.value = false;
          return [];
        }

        return await orderspageController.searchCustomer(textEditingValue.text);
      },
      onSelected: (CustomersModel selection) {
        orderspageController.isShowCustomerDetails.value = true;
        orderspageController.isShowCheck.value = true;
        orderspageController.selected_customer.value = selection;
        print(selection.name);
        print(selection.customerNo);
        orderspageController.customers_controller.text =
            _displaybillToCustomerForOption(selection).toString();
        orderspageController.order_expiry_date_controller.text=orderspageController.getCurrentExpryDate(selection.expiryNoOfDays!);
        FocusScope.of(context).unfocus();


      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor:AllColors.primaryDark1 ,
          controller: controller
            ..text = orderspageController.customers_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Bill-to-Customer',
            labelText: 'Bill-to-Customer',
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

  Widget bindConsigneeDropDown(context) {
    return Autocomplete<ConsigneeModel>(
      displayStringForOption: _displayConsigneeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          orderspageController.isShowConsigneeDetails.value = false;
          return orderspageController.consignee_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return orderspageController.consignee_list
            .where((ConsigneeModel option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ConsigneeModel selection) {
        print(selection.name);
        orderspageController.isShowConsigneeDetails.value = true;
        orderspageController.selected_consignee.value = selection;
        orderspageController.consignee_name_drop_down_controller.text=
            _displayConsigneeForOption(selection).toString();
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = orderspageController.consignee_name_drop_down_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Consignee Name',
            labelText: 'Consignee Name',
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
          AutocompleteOnSelected<ConsigneeModel> onSelected,
          Iterable<ConsigneeModel> suggestions) {
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
                  final ConsigneeModel option = suggestions.elementAt(index);
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


  Widget bindPaymentTermsDropDown(context) {
    return Autocomplete<PaymentTermModel>(

      displayStringForOption: _displayPaymentTermsForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return orderspageController.paymentTerms_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return orderspageController.paymentTerms_list
            .where((PaymentTermModel option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (PaymentTermModel selection) {
        print(selection.name);
        orderspageController.location_center_controller.text =
            _displayPaymentTermsForOption(selection).toString();
        orderspageController.selected_location.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = orderspageController.location_center_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Payment Terms',
            labelText: 'Payment Terms',
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
          AutocompleteOnSelected<PaymentTermModel> onSelected,
          Iterable<PaymentTermModel> suggestions) {
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
                  final PaymentTermModel option = suggestions.elementAt(index);
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
  //todo for show details..........

  Widget bindCustomerDetails(contex) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          orderspageController.selected_customer.value.address.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          orderspageController.selected_customer.value.stateName.toString() +
              " (" + orderspageController.selected_customer.value.stateCode
              .toString() + " )",
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          orderspageController.selected_customer.value.countryName.toString() +
              " (" +
              orderspageController.selected_customer.value.countryCode.toString() +
              " )," +
              orderspageController.selected_customer.value.postCode.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'GST:${orderspageController.selected_customer.value.gstRegistrationNo
              .toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Credit Limit: Rs. ${orderspageController.selected_customer.value
              .creditLimit.toString()}',
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          'Outstanding: Rs. ${orderspageController.selected_customer.value
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
  Widget bindConsigneeDetails(contex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.0),
        Text(
          orderspageController.selected_consignee.value.address.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          orderspageController.selected_consignee.value.city.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          orderspageController.selected_consignee.value.stateName.toString() +
              " (" + orderspageController.selected_consignee.value.stateCode
              .toString() + " )",
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: 4.0),
        Text(
          orderspageController.selected_consignee.value.pincode.toString(),
          style: GoogleFonts.poppins(
              color: AllColors.lightblackColor,
              fontSize: AllFontSize.twelve,
              fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  //todo for add consignee...........
  Widget bindcosigneeName(context) {
    return TextFormField(
      controller: orderspageController.consignee_name_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        orderspageController.consignee_name_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Consignee ",
        labelText: "Consignee",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }




  Widget bindcontactName(context) {
    return TextFormField(
      controller: orderspageController.consignee_contact_name_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        orderspageController.consignee_contact_name_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Contact Name ",
        labelText: "Contact Name",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }



  Widget bindcosigneeContact(context) {
    return TextFormField(
      controller: orderspageController.consignee_contact_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        orderspageController.consignee_contact_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Mobile Number",
        labelText: "Mobile Number",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }
  Widget bindStatesDropDown(context) {
    return Autocomplete<StateModel>(
      displayStringForOption: _displayStatesForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return orderspageController.state_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return orderspageController.state_list
            .where((StateModel option) {
          return option.stateName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (StateModel selection) {
        orderspageController.consignee_state_name_controller.text =
            _displayStatesForOption(selection).toString();
        orderspageController.selected_state.value=selection;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor:AllColors.primaryDark1,
          controller: controller
            ..text = orderspageController.consignee_state_name_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select State',
            labelText: 'Select State',
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
                physics: AlwaysScrollableScrollPhysics(),
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
  Widget bindcosigneeAddress(context) {
    return TextFormField(
      controller: orderspageController.consignee_address_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        orderspageController.consignee_address_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Address",
        labelText: "Address",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }
  Widget bindcosigneeAddress2(context) {
    return TextFormField(
      controller: orderspageController.consignee_address2_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        orderspageController.consignee_address2_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Address 2",
        labelText: "Address 2",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }
  Widget bindcosigneeCity(context) {
    return TextFormField(
      controller: orderspageController.consignee_city_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        orderspageController.consignee_city_controller.value;
      },
      decoration: InputDecoration(
        hintText: "City Name",
        labelText: "City Name",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }
  Widget bindcosigneePincode(context) {
    return TextFormField(
      controller: orderspageController.consignee_pincode_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        orderspageController.consignee_pincode_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Pin-Code",
        labelText: "Pin-Code",
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
              color: AllColors.primaryDark1), // Change the color to green
        ),
      ),
      cursorColor: AllColors.primaryDark1,
    );
  }

}

