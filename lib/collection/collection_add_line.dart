import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/models/collection/customer_modal.dart';
import 'package:pristine_seeds/models/orders/customers_model.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/collection_vm/collectionVm.dart';

class CollectionAddLineDetails extends StatelessWidget{
  CollectionAddLineDetails({super.key});


  static String _displaycollectionTypeForOption(String option) => option!;
  static String _displaycustomerNameForOption(CustomerResponse option) => option.name!;
  Size size = Get.size;
  final CollectionViewModal collectionController = Get.put(CollectionViewModal());
  String flag='';
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    collectionController.isReadOnly.isFalse?flag='Add':flag='View';
    return WillPopScope(
      onWillPop:() async{
        Get.toNamed(RoutesName.collectionScreen);
        return true;
      },
      child:Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: size.height * 0.09,
                        child: CircleBackButton(
                          press: () {
                            Get.toNamed(RoutesName.collectionScreen);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("${flag} Collection ",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Spacer(),
                    Obx(() {
                      return
                        Visibility(
                          visible: collectionController.isReadOnly.isFalse?true:false,
                          child: ActionChip(
                            elevation: 1,
                            tooltip: "Near By",
                            backgroundColor: collectionController.isNearBy.value
                                ? AllColors.primaryDark1
                                : AllColors.grayColor,
                            shape: StadiumBorder(
                              side: BorderSide(color: AllColors.primaryDark1),
                            ),
                            avatar: Icon(Icons.location_on,
                              color: collectionController.isNearBy.value
                                  ? AllColors.whiteColor
                                  : AllColors.primaryDark1,),
                            label: Text(
                              'Near By',
                              style: GoogleFonts.poppins(
                                color: collectionController.isNearBy.value
                                    ? AllColors.whiteColor
                                    : AllColors.primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              collectionController.isNearBy.toggle();
                              // Update latitude and longitude values based on isNearBy value
                              if (collectionController.isNearBy.value) {
                                collectionController.lat.value =
                                    collectionController.currentLat.value;
                                collectionController.lng.value =
                                    collectionController.currentLng.value;
                              } else {
                                collectionController.lat.value = 0.0;
                                collectionController.lng.value = 0.0;
                              }
                              //collectionController.getCustomerName();
                            },
                          ),
                        );
                    }
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: collectionController.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx((){
                                return Visibility(visible: collectionController.isDocument_type.value,
                                    child: collectionType(context));
                              } // child: ,
                              ),
                              SizedBox(height: 8),
                              bindDatePicker(context),
                              SizedBox(height: 8),
                              Obx((){
                                return Visibility(
                                    visible: collectionController.isParty_Name.value,
                                    child: bindPartyName(context));
                              } // child: ,
                              ),

                              SizedBox(height: 8),
                              bindPlace(context),
                              SizedBox(height: 8),
                              bindChqDDRtgsNo(context),
                              SizedBox(height: 8),
                              bindDrawnBankName(context),
                              SizedBox(height: 8),
                              bindDepositeBank(context),
                              SizedBox(height: 8),
                              bindDepositeAt(context),
                              SizedBox(height: 8),
                              bindBank(context),
                              SizedBox(height: 8),
                              bindDateOfReceipt(context),
                              SizedBox(height: 8),
                              bindAmount(context),
                              SizedBox(height: 8),
                              bindRemark(context),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              visibiltyOfBtn(context)],
          ),
        ),

      ),

    );



  }

  Widget bindBank(context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.bank,
      //..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Bank',
        labelText: 'Bank',
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

  Widget bindRemark( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.remarks,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Remarks',
        labelText: 'Remarks',
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

  Widget bindPlace( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.place,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Place',
        labelText: 'Place',
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

  Widget bindChqDDRtgsNo( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.chqDDRtgsNo,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Chq/DD/RTGS.No.',
        labelText: 'Chq/DD/RTGS.No.',
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

  Widget bindDrawnBankName( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.drawnBankname,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Drawn On Bank Name',
        labelText: 'Drawn On Bank Name',
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

  Widget bindDepositeBank( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.depositedBank,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Deposited Bank',
        labelText: 'Deposited Bank',
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

  Widget bindDepositeAt( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.depositedAt,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Deposited At',
        labelText: 'Deposited At',
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

  Widget bindDateOfReceipt( context) {
    return TextField(
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.dateOfReceipt,
      readOnly: collectionController.isReadOnly.value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Select Date of Receipt',
        labelText: 'Date of Receipt',
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
      onTap: () async {
        if(collectionController.isReadOnly.isFalse){
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
            collectionController.dateOfReceipt.text = outputFormat.format(date);
          else
            collectionController.dateOfReceipt.text = "";
        }

      },
    );
  }

  Widget bindAmount( context) {
    return TextField(
      readOnly: collectionController.isReadOnly.value,
      cursorColor:AllColors.primaryDark1 ,
      controller: collectionController.amount,
      keyboardType: TextInputType.number,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Amount',
        labelText: 'Amount',
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

  Widget bindPartyName( context) {
    return Autocomplete<CustomerResponse>(
      displayStringForOption: _displaycustomerNameForOption,
      optionsBuilder: (TextEditingValue textEditingValue ) async {
       /* if (textEditingValue.text.isEmpty) {
          collectionController.isShowDocDropDown.value = false;
          return collectionController.customers_list.value;
        }*/
        if (textEditingValue.text.isEmpty) {
          collectionController.isShowDocDropDown.value = false;
          return [];
        }

        return await collectionController.searchCustomer(textEditingValue.text);


        if(collectionController.isReadOnly.isTrue){
          collectionController.customers_list.value=[];
        }
       /* return collectionController.customers_list
            .where((CustomerResponse option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (CustomerResponse selection) {
        print(selection);
        collectionController.partyName.text =
            _displaycustomerNameForOption(selection).toString();
       // collectionController.selected_type.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: collectionController.isReadOnly.value,
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = collectionController.partyName.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Party Name',
            labelText: 'Party Name',
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
          AutocompleteOnSelected<CustomerResponse> onSelected,
          Iterable<CustomerResponse> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:suggestions.length,
                itemBuilder: (context, index) {
                  final CustomerResponse option = suggestions .elementAt(index);
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
        );;
      },
    );
  }

  Widget bindDatePicker( context) {
    return TextFormField(
      readOnly: collectionController.isReadOnly.value,
      controller: collectionController.date,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
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
        if(collectionController.isReadOnly.isFalse){
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
            collectionController.date.text = outputFormat.format(date);
          else
            collectionController.date.text = "";
        }

      },
    );
  }

  Widget collectionType( context) {
    return Autocomplete<String>(
      displayStringForOption: _displaycollectionTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue ) async {
        if (textEditingValue.text.isEmpty) {
          collectionController.isShowDocDropDown.value = false;
          return collectionController.collectionTypedata;
        }

          return  collectionController.collectionTypedata;
      },
      onSelected: (String selection) {
        print(selection);
        collectionController.collectionType.text =
            _displaycollectionTypeForOption(selection).toString();
        collectionController.selected_type.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          readOnly: collectionController.isReadOnly.value,
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = collectionController.collectionType.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Collection Type',
            labelText: 'Collection Type',
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
                      collectionController.doc_type.value=option;
                      //print("doc_typeeee......${collectionController.doc_type}");
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

  Widget visibiltyOfBtn( context) {
    if(collectionController.isReadOnly.isFalse)
      {
        return  Container(
                margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DefaultButton(
                        text: "Submit",
                        press: () {
                          collectionController.addData();
                        },

                      ),
                    ),
                    SizedBox(width: size.width * .02),
                    Expanded(
                      child: DefaultButton(
                        text: "Reset",
                        press: () {
                          collectionController.resetAllLineFields();
                          collectionController.collectionType.clear();
                          collectionController.partyName.clear();
                          collectionController.isParty_Name.value=false;
                          collectionController.isParty_Name.value=true;
                          collectionController.isDocument_type.value=false;
                          collectionController.isDocument_type.value=true;
                        },

                      ),
                    ),
                    // }),
                  ],
                ),
              );
      }
    else
     {
       return Container();
     }
  }

}
