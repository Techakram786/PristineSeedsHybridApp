import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/models/orders/customers_model.dart';
import 'package:pristine_seeds/models/planting/season_model.dart';
import 'package:pristine_seeds/view_model/planting_vm/planting_vm.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/planting/production_location_model.dart';
import '../../resourse/routes/routes_name.dart';

class PlantingLineDetailsScreen extends StatelessWidget {
  PlantingLineDetailsScreen({super.key});

  Size size = Get.size;
  final PlantingVM plantingLineDetailsPageController = Get.put(PlantingVM());

  static String _displayOrganizerForOption(CustomersModel option) =>
      option.name!;

  static String _productionLocationForOption(ProductionLocationModel option) =>
      option.locationName!; //
  static String _displaySeasonForOption(SeasonGetModel option) =>
      option.seasonName!;

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
                            /*if(plantingLineDetailsPageController.scrollController!=null){
                              plantingLineDetailsPageController.initScrollController();
                              plantingLineDetailsPageController.onInit();
                            }*/
                            //plantingLineDetailsPageController.plantingHeaderGetRefressUi('');
                            //plantingLineDetailsPageController.onInit();
                            Get.toNamed(RoutesName.planting_list);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Planting (${plantingLineDetailsPageController.planting_header_list[0].code != null ? plantingLineDetailsPageController.planting_header_list[0].code.toString() : ''})",
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
              Obx(() {
                return Visibility(
                  visible: plantingLineDetailsPageController.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),
              Container(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 1.0,
                      offset: Offset(0.0, 0.00))
                ], color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Text(
                          'Location Centre: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          plantingLineDetailsPageController
                              .planting_header_list[0].productionCenterLoc
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryliteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Season Name: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message:  plantingLineDetailsPageController
                              .planting_header_list[0].seasonName
                              .toString(),
                          child: Container(
                            width: size.width*.5,
                            child: Text(
                              textAlign: TextAlign.end,
                              plantingLineDetailsPageController
                                  .planting_header_list[0].seasonName
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Season Code: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          plantingLineDetailsPageController
                              .planting_header_list[0].seasonCode
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryliteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Organizer Name: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message: plantingLineDetailsPageController
                              .planting_header_list[0].organizerName
                              .toString(),
                          child: Container(
                            width: size.width * .5,
                            child: Text(
                              plantingLineDetailsPageController
                                  .planting_header_list[0].organizerName
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Organizer Code: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Tooltip(
                          message: plantingLineDetailsPageController.planting_header_list[0].organizerCode.toString(),
                          child: Container(
                            width: size.width*.5,
                            child: Text(
                              plantingLineDetailsPageController.planting_header_list[0].organizerCode.toString(),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                  color: AllColors.primaryliteColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Land Acres: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Obx((){
                          return  Text(
                            plantingLineDetailsPageController
                                .planting_header_list[0].totalLandInAcres
                                .toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryliteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600),
                          );
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Sowing Acres: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Obx((){
                          return  Text(
                            plantingLineDetailsPageController
                                .planting_header_list[0]
                                .totalSowingAreaInAcres
                                .toString(),
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryliteColor,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w600),
                          );
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Text(
                          'Date: ',
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          plantingLineDetailsPageController.planting_header_list[0].plantingDate.toString(),
                          style: GoogleFonts.poppins(
                              color: AllColors.primaryliteColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx((){
                        return Visibility(
                          visible: plantingLineDetailsPageController.planting_header_list[0].status!<=0 ? true : false,
                          child: ActionChip(
                            elevation: 1,
                            tooltip: "Discard Header",
                            backgroundColor: AllColors.grayColor,
                            avatar: Icon(Icons.delete, color: AllColors.redColor),
                            shape: StadiumBorder(
                                side: BorderSide(color: AllColors.redColor)),
                            label: Text('Discard',
                                style: GoogleFonts.poppins(
                                  color: AllColors.redColor,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                            onPressed: () {
                              showConfirmDiscardDialog(context,"Do You Want To Discard Header?","Header Discard",plantingLineDetailsPageController.planting_header_list[0].code,null);
                            },
                          ),
                        );
                      }),

                      Obx(() {
                        return Visibility(
                            visible: plantingLineDetailsPageController
                                .planting_header_list[0].lines!.length > 0 && plantingLineDetailsPageController
                                .planting_header_list[0].status!<=0 ? true : false,
                            child: ActionChip(
                              elevation: 1,
                              tooltip: "Header Complete",
                              backgroundColor: AllColors.grayColor,
                              avatar: Icon(Icons.post_add,
                                  color: AllColors.primaryDark1),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.primaryliteColor)),
                              label: Text('Complete',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onPressed: () {
                                showConfirmCompleteDialog(context,"Do You Want To Complete(${plantingLineDetailsPageController.planting_header_list[0].code})?","Complete Plant",plantingLineDetailsPageController.planting_header_list[0].code);plantingLineDetailsPageController.resetAllHeaderFields();
                              },
                            ));
                      }),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' Line Details: ',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,
                          )),
                      Obx(() {
                        return Visibility(
                            visible: plantingLineDetailsPageController
                                .planting_header_list[0].status! < 1 ? true : false,
                            child: ActionChip(
                              elevation: 1,
                              tooltip: "Add Planting Line",
                              backgroundColor: AllColors.grayColor,
                              avatar: Icon(Icons.add,
                                  color: AllColors.primaryDark1),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: AllColors.primaryliteColor)),
                              label: Text('Add Line',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )),
                              onPressed: () {
                                plantingLineDetailsPageController
                                    .resetAllLineFields();
                                Get.toNamed(RoutesName.add_new_palnting_line_screen);
                              },
                            ));
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return bindListLayout();
              }),

            ],
          )),
    );
  }

  Widget productionLocationDropDown(context) {
    return Autocomplete<ProductionLocationModel>(
      displayStringForOption: _productionLocationForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return plantingLineDetailsPageController.production_location_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return plantingLineDetailsPageController.production_location_list
            .where((ProductionLocationModel option) {
          return option.locationName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ProductionLocationModel selection) {
        print(selection.locationName);
        plantingLineDetailsPageController.production_location_controller.text =
            _productionLocationForOption(selection).toString();
        plantingLineDetailsPageController.selected_location.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = plantingLineDetailsPageController
                .production_location_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Location Center',
            labelText: 'Location Center',
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
          AutocompleteOnSelected<ProductionLocationModel> onSelected,
          Iterable<ProductionLocationModel> suggestions) {
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
                  final ProductionLocationModel option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.locationName.toString(),
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

  Widget seasonDropDown(context) {
    return Autocomplete<SeasonGetModel>(
      displayStringForOption: _displaySeasonForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return plantingLineDetailsPageController.season_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return plantingLineDetailsPageController.season_list
            .where((SeasonGetModel option) {
          return option.seasonName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (SeasonGetModel selection) {
        print(selection.seasonName);
        plantingLineDetailsPageController.season_controller.text =
            _displaySeasonForOption(selection).toString();
        plantingLineDetailsPageController.selected_season.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = plantingLineDetailsPageController.season_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Season',
            labelText: 'Select Season',
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
          AutocompleteOnSelected<SeasonGetModel> onSelected,
          Iterable<SeasonGetModel> suggestions) {
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
                  final SeasonGetModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.seasonName.toString(),
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

  Widget organizerDropDown(context) {
    return Autocomplete<CustomersModel>(
      displayStringForOption: _displayOrganizerForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          plantingLineDetailsPageController.isShowDocDropDown.value = false;
          return [];
        }

        return await plantingLineDetailsPageController.searchOrganizer(textEditingValue.text);
       /* if (textEditingValue.text.isEmpty) {
          return plantingLineDetailsPageController.organizer_list;
          // return const Iterable<PaymentTermModel>.empty();
        }*/
      /*  return plantingLineDetailsPageController.organizer_list
            .where((CustomersModel option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (CustomersModel selection) {
        print(selection.name);
        plantingLineDetailsPageController.organizer_controller.text =
            _displayOrganizerForOption(selection).toString();
        plantingLineDetailsPageController.selected_organizer.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text =
                plantingLineDetailsPageController.organizer_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Organizer',
            labelText: 'Select Organizer',
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

  Widget bindPlantingDatePicker(context) {
    return TextFormField(
      controller: plantingLineDetailsPageController.planting_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Planting Date",
        labelText: 'Planting Date',
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
            });
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          plantingLineDetailsPageController.planting_date_controller.text =
              outputFormat.format(date);
        else
          plantingLineDetailsPageController.planting_date_controller.text = "";
      },
    );
  }

  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (plantingLineDetailsPageController.planting_header_list[0].lines ==
        null ||
        plantingLineDetailsPageController
            .planting_header_list[0].lines!.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            'No Records Found.',
            style: TextStyle(fontSize: 20, color: AllColors.primaryColor),
          ),
        ),
      );
    } else {
      Size size = Get.size;
      return Expanded(
        child: Container(
          //height: size.height - 170,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => Divider(
                height: 2,
                color: AllColors.primaryDark1,
              ),
              itemCount: plantingLineDetailsPageController
                  .planting_header_list[0].lines!.length,
              itemBuilder: (context, index) {
                return BindListView(context, index);
              }),
        ),
      );
    }
  }

  //todo listview bind
  Widget BindListView(context, int position) {
    return InkWell(
      child: ListTile(
        onTap: () {
          plantingLineDetailsPageController.openBottomSheetDialog(context,position);
          plantingLineDetailsPageController.planting_no.value=
              plantingLineDetailsPageController.planting_header_list[0].code.toString();
          plantingLineDetailsPageController.planting_line_no.value=
              plantingLineDetailsPageController.planting_header_list[0].lines![position].lineNo.toString();

        },
        subtitle: Row(
          children: [
            Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border:
                    Border.all(color: AllColors.primaryDark1, width: 1)),
                child: bindImage(position)),
            SizedBox(width: size.width * .01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Line No.: ${plantingLineDetailsPageController.planting_header_list[0].lines![position].lineNo.toString()}',
                  style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  width: size.width * .6,
                  child: Text(
                      'Org. Name: ${plantingLineDetailsPageController.planting_header_list[0].lines![position].organizerName ?? ''}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w500,
                        fontSize: AllFontSize.fourtine,
                      )),
                ),
                Text(
                    'Sowing Acres: ${plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingAreaInAcres.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
                Text(
                    'Sowing Date: ${(plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingDateMale) != null ? plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingDateMale :plantingLineDetailsPageController.planting_header_list[0].lines![position].sowingDateOther}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

//todo bind for badge items qty  .....
  Widget bindImage(int position) {
    if (plantingLineDetailsPageController
        .planting_header_list[0].lines![position].organizerName !=
        null &&
        plantingLineDetailsPageController
            .planting_header_list[0].lines![position].organizerName !=
            "")
      return CircleAvatar( // Set the desired radius
        backgroundColor: AllColors.whiteColor,
        backgroundImage: AssetImage('assets/images/leaves_img.png'),
        /*child: Text(
    plantingLineDetailsPageController
        .planting_header_list[0].lines![position].organizerName![0]
        .toString(),
    style: GoogleFonts.poppins(
        color: AllColors.primaryDark1, // Text color
        fontWeight: FontWeight.w700,
        fontSize: 40),
  ),*/
      );
    else
      return CircleAvatar(

        backgroundColor: AllColors.primaryliteColor,
        /* child: Text(
          'NO',
          style: GoogleFonts.poppins(
            color: AllColors.primaryDark1, // Text color
            fontWeight: FontWeight.w700,
          ),
        ),*/
      );
  }

  showConfirmDiscardDialog(BuildContext context,String message,String flag,String? planting_no,String? line_no) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content:   Text(
            message,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                plantingLineDetailsPageController.plantingHeaderLineDiscard(flag,planting_no,line_no,context);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }
  showConfirmCompleteDialog(BuildContext context,String message,String flag,String? planting_no) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1)),
          content:   Text(
            message,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.fourtine,
                fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor),),
            ),
            TextButton(
              onPressed: () {
                plantingLineDetailsPageController.PlantingHeaderComplete(planting_no!);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }

}
