import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/orders/customers_model.dart';
import '../../models/planting/season_model.dart';
import '../../models/planting/supervisor_modal.dart';
import '../../models/seed_dispatch/seed_dispatch_modal.dart';
import '../../view_model/planting_vm/planting_vm.dart';
import '../../view_model/seed_dispatch_vm/seed_dispatch_vm.dart';

class CreateSeedDispatchHeaderScreen extends StatelessWidget{
  CreateSeedDispatchHeaderScreen({super.key});
  final SeedDispatch_VM seedDispatch_VM_Controller = Get.put(SeedDispatch_VM());
  final PlantingVM plantingPageController = Get.put(PlantingVM());
  Size size = Get.size;
  static String _productionLocationForOption(SeedDispatLocationchModal option) =>
      option.locationname!/*+'('+'${option.locationid}'+')'*/;
  static String _displaySeasonForOption(SeasonGetModel option) =>
      option.seasonName!;
  static String _displayOrganizerForOption(CustomersModel option) =>
      option.name!;
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
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Create Seed Dispatch Note Header",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               Obx(() {
                return Visibility(
                  visible: seedDispatch_VM_Controller.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: !seedDispatch_VM_Controller.reset_field_ui.value,
                  child: Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 12),
                      shrinkWrap: true,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bindDatePicker(context),
                            SizedBox(height: 8.0),
                            LocationDropDown(context),
                            SizedBox(height: 8.0),
                            seasonDropDown(context),
                            SizedBox(height: 8.0),
                            organizerDropDown(context),
                            SizedBox(height: 8.0),
                            bindsupervisor(context),
                            SizedBox(height: 8.0),
                            bindtransporter(context),
                            SizedBox(height: 8.0),
                            bindtruckno(context),
                            SizedBox(height: 8.0),
                            bindcamp(context),
                            SizedBox(height: 8.0),
                            bindreferenceno(context),
                            SizedBox(height: 8.0),
                            bindFrightAmount(context),
                            SizedBox(height: 8.0),
                            bindremarks(context),
                            SizedBox(height: 8.0),
                            SizedBox(height: size.height * .05),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Divider(
                height: 2,
                color: AllColors.primaryliteColor,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 12,bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Expanded(
                        child: DefaultButton(
                          text: "Submit header",
                          press: () {
                            seedDispatch_VM_Controller.seedDispatchHeaderCreate();
                          },
                          loading:
                          seedDispatch_VM_Controller.button_loading.value,
                        ),
                      );
                    }),
                    SizedBox(width: size.width * .03),
                  ],
                ),
              ),

            ],
          )),
    );
  }
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.date_controller,
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
          seedDispatch_VM_Controller.date_controller.text =
              outputFormat.format(date);
        else
          seedDispatch_VM_Controller.date_controller.text = "";
      },
    );
  }
  Widget LocationDropDown(context) {
    return Autocomplete<SeedDispatLocationchModal>(
      displayStringForOption: _productionLocationForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.seed_dispatch_location_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.seed_dispatch_location_list
            .where((SeedDispatLocationchModal option) {
          return option.locationname
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (SeedDispatLocationchModal selection)
      {
        print(selection.locationname);
        seedDispatch_VM_Controller.seed_dispatch_location_controller.text =
            _productionLocationForOption(selection).toString();
        seedDispatch_VM_Controller.selected_location.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.seed_dispatch_location_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Location Centre',
            labelText: 'Location Centre',
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
          AutocompleteOnSelected<SeedDispatLocationchModal> onSelected,
          Iterable<SeedDispatLocationchModal> suggestions) {
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
                  final SeedDispatLocationchModal option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.locationname.toString(),
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
  Widget seasonDropDown(context) {
    return Autocomplete<SeasonGetModel>(
      displayStringForOption: _displaySeasonForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.season_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.season_list
            .where((SeasonGetModel option) {
          return option.seasonName
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (SeasonGetModel selection) {
        print(selection.seasonName);
        seedDispatch_VM_Controller.season_controller.text =
            _displaySeasonForOption(selection).toString();
        seedDispatch_VM_Controller.selected_season.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.season_controller.text,
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
          seedDispatch_VM_Controller.isShowDocDropDown.value = false;
          return [];
        }

        return await seedDispatch_VM_Controller.searchOrganizer(textEditingValue.text);
       /* if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.organizer_list;
          // return const Iterable<PaymentTermModel>.empty();
        }*/
      /*  return seedDispatch_VM_Controller.organizer_list
            .where((CustomersModel option) {
          return option.name
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (CustomersModel selection) {
        print(selection.name);
        seedDispatch_VM_Controller.organizer_controller.text =
            _displayOrganizerForOption(selection).toString();
        seedDispatch_VM_Controller.selected_organizer.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.organizer_controller.text,
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
  Widget bindsupervisor(context) {
    return Autocomplete<SuperVisorModal>(
      displayStringForOption: _displaySupervisorForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.supervisor_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.supervisor_list
            .where((SuperVisorModal option) {
          return option.manageremailid
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (SuperVisorModal selection) {
        print(selection.manageremailid);
        seedDispatch_VM_Controller.supervisor.text =
            _displaySupervisorForOption(selection).toString();
        seedDispatch_VM_Controller.selected_supervisor.value = selection;
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.supervisor.text,
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
  Widget bindtransporter(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.transporter,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.transporter.value;
      },
      decoration: InputDecoration(
        hintText: "Transporter",
        labelText: "Transporter",
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
  Widget bindtruckno(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.truck_no,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.truck_no.value;
      },
      decoration: InputDecoration(
        hintText: "Truck No.",
        labelText: "Truck No.",
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
  Widget bindcamp(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.camp_at,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.camp_at.value;
      },
      decoration: InputDecoration(
        hintText: "Camp At",
        labelText: "Camp At",
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
  Widget bindreferenceno(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.reference_no,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.reference_no.value;
      },
      decoration: InputDecoration(
        hintText: "Reference No.",
        labelText: "Reference No.",
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
  Widget bindremarks(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.remarks,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.remarks.value;
      },
      decoration: InputDecoration(
        hintText: "Remarks",
        labelText: "Remarks",
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
  Widget bindFrightAmount(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.fright_amount_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        seedDispatch_VM_Controller.fright_amount_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Freight Amount",
        labelText: "Freight Amount",
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