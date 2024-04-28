import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/orders/customers_model.dart';
import '../../models/planting/fsio_bsio_doc_get_model.dart';
import '../../models/planting/fsio_bsio_lot_details_get_model.dart';
import '../../models/planting/supervisor_modal.dart';
import '../../view_model/planting_vm/planting_vm.dart';
class AddNewPlantingLineScreen extends StatelessWidget {
  AddNewPlantingLineScreen({super.key});

  Size size=Get.size;
  final PlantingVM plantingPageController = Get.put(PlantingVM());
  static String _displaydocumentTypeForOption(String option) => option!;
  static String _displayOrganizerForOption(CustomersModel option) => option.name!;
  static String _displayDocumentCodeForOption(FSIOBSIODocGetModel option) => option.documentNo!; //

  static String _displayMaleLotForOption(FSIOBSIOLotDetailsGetModel option) => option.lotNo!;
  static String _displayFemaleLotForOption(FSIOBSIOLotDetailsGetModel option) => option.lotNo!;
  static String _displayOtherLotForOption(FSIOBSIOLotDetailsGetModel option) => option.lotNo!;
  static String _displaySupervisorForOption(SuperVisorModal option) =>
      option.manageremailid!;
  @override
  Widget build(BuildContext context) {
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
                      child: Text("Add Planting Line",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                  shrinkWrap: true,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        documentTypeDropDown(context),
                        SizedBox(height: 8.0),
                        Obx((){
                          return Visibility(
                              visible: plantingPageController.isShowDocDropDown.value,
                              child: documentCodeDropDown(context));
                        }),
                        Obx(() =>
                            Visibility(
                              visible: plantingPageController.isShowDocDetails.value,//plantingPageController.isShowDocDetails.value,
                              child: bindDocumentCodeDetails(context),
                            ),
                        ),
                        SizedBox(height: 8.0),
                        bindExpectedYield(context),
                        SizedBox(height: 8.0),
                        bindSowingArea(context),
                        SizedBox(height: 8.0),
                        bindLandLease(context),
                        Padding(padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            //height: 350,
                            //width: 400,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Farmer Details',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.twentee
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                                ),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  growerDropDown(context),
                                  Obx(
                                        () =>
                                        Visibility(
                                          visible: plantingPageController.isShowGrowerDetails.value,//plantingPageController.isShowDocDetails.value,
                                          child: bindGrowerDetailsDetails(context),
                                        ),
                                  ),
                                  SizedBox(height: 8.0),
                                  bindsupervisor(context),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            //height: 350,
                            //width: 400,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Male Group',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.twentee
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindMaleDatePicker(context),
                                  SizedBox(height: 8.0),
                                  parentMaleLotDropDown(context),
                                  Obx(
                                        () =>
                                        Visibility(
                                          visible: plantingPageController.isShowMaleDetails.value,//plantingPageController.isShowDocDetails.value,
                                          child: bindMaleLotDetails(context),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            //height: 350,
                            //width: 400,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Female Group',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.twentee
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindFemaleDatePicker(context),
                                  SizedBox(height: 8.0),
                                  parentFemaleLotDropDown(context),
                                  Obx(
                                        () =>
                                        Visibility(
                                          visible: plantingPageController.isShowFemaleDetails.value,//plantingPageController.isShowDocDetails.value,
                                          child: bindFemaleLotDetails(context),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(padding: EdgeInsets.only(top: 10),
                          child: SizedBox(
                            //height: 350,
                            //width: 400,
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Other Group',
                                labelStyle: GoogleFonts.poppins(
                                    color: AllColors.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: AllFontSize.twentee
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1, color: AllColors.primaryliteColor),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  bindOtherDatePicker(context),
                                  SizedBox(height: 8.0),
                                  parentOtherLotDropDown(context),
                                  SizedBox(height: 8.0),
                                  Obx(
                                        () =>
                                        Visibility(
                                          visible: plantingPageController.isShowOtherDetails.value,//plantingPageController.isShowDocDetails.value,
                                          child: bindOtherLotDetails(context),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.0),
                        bindRevisedYield(context),

                        SizedBox(height: size.height * .02),
                        Padding(padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return Expanded(
                                  child: DefaultButton(
                                    text: "Submit",
                                    press: () {
                                      plantingPageController.plantingLineCreate();
                                    },
                                    loading: plantingPageController.loading.value,
                                  ),
                                );
                              }),
                              SizedBox(width: size.width * .01),
                              Expanded(
                                child: DefaultButton(
                                  text: "Reset",
                                  press: () {
                                    plantingPageController.resetAllLineFields();
                                  },
                                ),
                              ),
                            ],
                          ),
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

  Widget documentTypeDropDown(context) {
    return Autocomplete<String>(
      displayStringForOption: _displaydocumentTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowDocDropDown.value=false;
          return plantingPageController.document_type_list;
        }
        return plantingPageController.document_type_list;
      },
      onSelected: (String selection) {
        print(selection);
        plantingPageController.isShowDocDropDown.value=true;
        plantingPageController.document_code_controller.clear();
        plantingPageController.plantingFsioBsioDocumentGet(selection);
        plantingPageController.document_type_controller.text =
            _displaydocumentTypeForOption(selection).toString();
        plantingPageController.selected_type.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = plantingPageController.document_type_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Document Type',
            labelText: 'Document Type',
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
        );
      },
    );
  }
  Widget documentCodeDropDown(context) {
    return Autocomplete<FSIOBSIODocGetModel>(

      displayStringForOption: _displayDocumentCodeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowDocDetails.value=false;

          plantingPageController.isShowMaleDetails.value=false;
          plantingPageController.isShowFemaleDetails.value=false;
          plantingPageController.isShowOtherDetails.value=false;

          plantingPageController.sowing_male_date_controller.text='';
          plantingPageController.sowing_female_date_controller.text='';
          plantingPageController.sowing_other_date_controller.text='';

          plantingPageController.other_lot_dropdown_controller.text='';
          plantingPageController.other_lot_dropdown_controller.text='';
          plantingPageController.other_lot_dropdown_controller.text='';

          return plantingPageController.document_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return plantingPageController.document_list
            .where(( option) {
          return option.
          documentNo.toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (FSIOBSIODocGetModel selection) {
        print(selection.documentNo);
        plantingPageController.plantingFsioBsioLotDetailsGet(selection.documentNo!);
        //plantingPageController.getGrowers();
        plantingPageController.maleLotDetailsGet(selection.documentNo!);
        plantingPageController.otherLotDetailsGet(selection.documentNo!);
        plantingPageController.document_code_controller.text = _displayDocumentCodeForOption(selection).toString();
        plantingPageController.selected_document.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = plantingPageController.document_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Document Code',
            labelText: 'Document Code',
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
          AutocompleteOnSelected<FSIOBSIODocGetModel> onSelected,
          Iterable<FSIOBSIODocGetModel> suggestions) {
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
                  final FSIOBSIODocGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.documentNo.toString(),
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
  Widget bindDocumentCodeDetails(context) {
    if(plantingPageController.document_details_get_list.length>0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Crop Code:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.document_details_get_list[0].cropCode?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Cls.Of Seed:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.document_details_get_list[0].itemClassOfSeeds?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Crop Type:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.document_details_get_list[0].itemCropType?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Crop Code:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.document_details_get_list[0].cropCode?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Variety Code:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.document_details_get_list[0].varietyCode?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Unit Of Measure:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.document_details_get_list[0].baseUnitOfMeasure?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      );
    }
    else{
      return Text('');
    }

  }//
  Widget bindExpectedYield(context) {
    return TextFormField(
      controller: plantingPageController.expected_yield_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        plantingPageController.expected_yield_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Expected Yield",
        labelText: "Expected Yield",
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
  Widget bindSowingArea(context) {
    return TextFormField(
      controller: plantingPageController.sowing_area_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        plantingPageController.sowing_area_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Sowing Area",
        labelText: "Sowing Acres",
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
  Widget bindLandLease(context) {
    return Row(
      children: [
        Text('Land Lease',
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700),),
        // plantingPageController.selectedOption.value
        Obx((){
          return Radio(
            value: 1,
            groupValue: plantingPageController.selectedOption.value,
            onChanged: (value) {
              plantingPageController.selectedOption.value=value as int;
            },
            activeColor: AllColors.primaryDark1,
          );
        }),
        Text('Yes',
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),),
        Obx((){
          return Radio(
            value: 0,
            groupValue: plantingPageController.selectedOption.value,
            onChanged: (value) {
              plantingPageController.selectedOption.value=value as int;
            },
            activeColor: AllColors.primaryDark1,
          );
        }),
        Text('No',
          style: GoogleFonts.poppins(
              color: AllColors.primaryDark1,
              fontSize: AllFontSize.fourtine,
              fontWeight: FontWeight.w700),),
      ],
    );
  }
  Widget growerDropDown(context) {
    return Autocomplete<CustomersModel>(

      displayStringForOption: _displayOrganizerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowDocDropDown.value = false;
          return [];
        }

        return await plantingPageController.searchGrower(textEditingValue.text);
       /* if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowGrowerDetails.value=false;
          return plantingPageController.grower_list;
          // return const Iterable<PaymentTermModel>.empty();
        }*/
     /*   return plantingPageController.grower_list
            .where((CustomersModel option) {
          return option.
          name.toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (CustomersModel selection) {
        print(selection.name);
        plantingPageController.isShowGrowerDetails.value=true;
        plantingPageController.grower_name_controller.text =
            _displayOrganizerForOption(selection).toString();
        plantingPageController.selected_grower.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = plantingPageController.grower_name_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Grower Name',
            labelText: 'Grower Name',
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
  Widget bindGrowerDetailsDetails(context) {
    if(plantingPageController.grower_list.length>0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grower State:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.selected_grower.value.stateName?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grower State Code:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.selected_grower.value.stateCode?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grower Country:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.selected_grower.value.countryName?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grower Country Code:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.selected_grower.value.countryCode?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grower Address:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Tooltip(
                  message: plantingPageController.selected_grower.value.address ?? "",
                  child: Text(' ${plantingPageController.selected_grower.value.address?? ''}',
                    style: GoogleFonts.poppins(
                        color: AllColors.primaryliteColor,
                        fontSize: AllFontSize.twelve,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grower Code:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.selected_grower.value.customerNo?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      );
    }
    else{
      return Text('');
    }

  }
  Widget bindsupervisor(context) {
    return Autocomplete<SuperVisorModal>(
      displayStringForOption: _displaySupervisorForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return plantingPageController.supervisor_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return plantingPageController.supervisor_list
            .where((SuperVisorModal option) {
          return option.manageremailid
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (SuperVisorModal selection) {
        print(selection.manageremailid);
        plantingPageController.superviser_controller.text =
            _displaySupervisorForOption(selection).toString();
        plantingPageController.selected_supervisor.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = plantingPageController.superviser_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Supervisor',
            labelText: 'Select Supervisor',
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
          AutocompleteOnSelected<SuperVisorModal> onSelected,
          Iterable<SuperVisorModal> suggestions) {
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
                  final SuperVisorModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.manageremailid.toString(),
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
    /*return TextFormField(
      controller: seedDispatch_VM_Controller.supervisor,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.supervisor.value;
      },
      decoration: InputDecoration(
        hintText: "Supervisor",
        labelText: "Supervisor",
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
    );*/
  }
  /*Widget bindSuperViserName(context) {
    return TextFormField(
      controller: plantingPageController.superviser_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        plantingPageController.superviser_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Superviser Name",
        labelText: "Superviser Name",
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
  }*/

  //todo for male lot .....................
  Widget bindMaleDatePicker(context) {
    return TextFormField(
      controller: plantingPageController.sowing_male_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Sowing Date Male",
        labelText: 'Sowing Date Male',
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
                primaryColor: AllColors.primaryDark1, // Change the primary color
                //accentColor: AllColors.primaryDark1, // Change the accent color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },

        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          plantingPageController.sowing_male_date_controller.text = outputFormat.format(date);
        else
          plantingPageController.sowing_male_date_controller.text = "";
      },
    );
  }
  Widget parentMaleLotDropDown(context) {
    return Autocomplete<FSIOBSIOLotDetailsGetModel>(
      displayStringForOption: _displayMaleLotForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowMaleDetails.value=false;
          return plantingPageController.male_lot_list;
        }
        return plantingPageController.male_lot_list;
      },
      onSelected: (FSIOBSIOLotDetailsGetModel selection) {
        print(selection);

        plantingPageController.feMaleLotDetailsGet(selection.documentNo!,selection.itemNo! );
        plantingPageController.isShowMaleDetails.value=true;
        plantingPageController.isShowFemaleDetails.value=false;
        plantingPageController.isShowOtherDetails.value=false;
        plantingPageController.sowing_other_date_controller.text='';
        plantingPageController.other_lot_dropdown_controller.text='';
        plantingPageController.male_lot_dropdown_controller.text =
            _displayMaleLotForOption(selection).toString();
        plantingPageController.selected_male_lot.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = plantingPageController.male_lot_dropdown_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Parent Male Lot',
            labelText: 'Parent Male Lot',
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
          AutocompleteOnSelected<FSIOBSIOLotDetailsGetModel> onSelected,
          Iterable<FSIOBSIOLotDetailsGetModel> suggestions) {
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
                  final FSIOBSIOLotDetailsGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.lotNo!,
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
  Widget bindMaleLotDetails(context) {
    if(plantingPageController.male_lot_list.length>0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item No: ',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.male_lot_list[0].itemNo?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Qty:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.male_lot_list[0].qty.toString() ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Parent Item No:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.male_lot_list[0].parentItemNo ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      );
    }
    else{
      return Text('');
    }

  }

  //todo for female lot...................
  Widget bindFemaleDatePicker(context) {
    return TextFormField(
      controller: plantingPageController.sowing_female_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Date Female",
        labelText: 'Sowing Date Female',
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
                primaryColor: AllColors.primaryDark1, // Change the primary color
                //accentColor: AllColors.primaryDark1, // Change the accent color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },


        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          plantingPageController.sowing_female_date_controller.text = outputFormat.format(date);
        else
          plantingPageController.sowing_female_date_controller.text = "";
      },
    );
  }
  Widget parentFemaleLotDropDown(context) {
    return Autocomplete<FSIOBSIOLotDetailsGetModel>(
      displayStringForOption: _displayFemaleLotForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowFemaleDetails.value=false;
          return plantingPageController.female_lot_list;

        }
        return plantingPageController.female_lot_list;
      },
      onSelected: (FSIOBSIOLotDetailsGetModel selection) {
        print(selection);
        plantingPageController.isShowFemaleDetails.value=true;
        plantingPageController.isShowMaleDetails.value=false;
        plantingPageController.isShowOtherDetails.value=false;
        plantingPageController.sowing_other_date_controller.text='';
        plantingPageController.other_lot_dropdown_controller.text='';
        plantingPageController.female_lot_dropdown_controller.text =
            _displayFemaleLotForOption(selection).toString();
        plantingPageController.selected_female_lot.value=selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = plantingPageController.female_lot_dropdown_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Parent Female Lot',
            labelText: 'Parent Female Lot',
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
          AutocompleteOnSelected<FSIOBSIOLotDetailsGetModel> onSelected,
          Iterable<FSIOBSIOLotDetailsGetModel> suggestions) {
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
                  final FSIOBSIOLotDetailsGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.lotNo!,
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
  Widget bindFemaleLotDetails(context) {
    if(plantingPageController.female_lot_list.length>0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item No:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.female_lot_list[0].itemNo ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Qty:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.female_lot_list[0].qty.toString() ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Parent Item No:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.female_lot_list[0].parentItemNo ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      );
    }
    else{
      return Text('');
    }

  }

  //todo for other lot.................
  Widget bindOtherDatePicker(context) {
    return TextFormField(
      controller: plantingPageController.sowing_other_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Sowing Other Date",
        labelText: 'Sowing Other Date',
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
                primaryColor: AllColors.primaryDark1, // Change the primary color
                //accentColor: AllColors.primaryDark1, // Change the accent color
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          plantingPageController.sowing_other_date_controller.text = outputFormat.format(date);
        else
          plantingPageController.sowing_other_date_controller.text = "";
      },
    );
  }
  Widget parentOtherLotDropDown(context) {
    return Autocomplete<FSIOBSIOLotDetailsGetModel>(
      displayStringForOption: _displayOtherLotForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          plantingPageController.isShowOtherDetails.value=false;
          return plantingPageController.other_lot_list;
        }
        return plantingPageController.other_lot_list;
      },
      onSelected: (FSIOBSIOLotDetailsGetModel selection) {
        print(selection);
        plantingPageController.isShowOtherDetails.value=true;
        plantingPageController.isShowMaleDetails.value=false;
        plantingPageController.isShowFemaleDetails.value=false;
        plantingPageController.sowing_male_date_controller.text='';
        plantingPageController.sowing_female_date_controller.text='';
        plantingPageController.selected_male_lot.value.lotNo='';
        plantingPageController.selected_female_lot.value.lotNo='';
        plantingPageController.selected_male_lot.value.qty=0;
        plantingPageController.male_lot_dropdown_controller.text='';
        plantingPageController.female_lot_dropdown_controller.text='';

        plantingPageController.other_lot_dropdown_controller.text =
            _displayOtherLotForOption(selection).toString();
        plantingPageController.selected_other_lot.value=selection;
        print('qty......'+plantingPageController.selected_other_lot.value.qty.toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = plantingPageController.other_lot_dropdown_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Parent Other Lot',
            labelText: 'Parent Other Lot',
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
          AutocompleteOnSelected<FSIOBSIOLotDetailsGetModel> onSelected,
          Iterable<FSIOBSIOLotDetailsGetModel> suggestions) {
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
                  final FSIOBSIOLotDetailsGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.lotNo!,
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
  Widget bindOtherLotDetails(context) {
    if(plantingPageController.other_lot_list.length>0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item No:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.other_lot_list[0].itemNo ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Item Qty:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.other_lot_list[0].qty.toString() ??''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Parent Item No:',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w600),
              ),
              Text('${plantingPageController.other_lot_list[0].parentItemNo ?? ''}',
                style: GoogleFonts.poppins(
                    color: AllColors.primaryliteColor,
                    fontSize: AllFontSize.twelve,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      );
    }
    else{
      return Text('');
    }

  }

  Widget bindRevisedYield(context) {
    return TextFormField(
      controller: plantingPageController.revised_yield_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        plantingPageController.revised_yield_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Revised Yield",
        labelText: "Revised Yield",
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
      cursorColor: AllColors.primaryDark1,//////
    );
  }
}
