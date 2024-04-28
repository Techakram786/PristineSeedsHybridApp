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
import '../../models/event_management_modal/event_type_modal.dart';
import '../../models/orders/customers_model.dart';
import '../../models/seed_dispatch/item_category_mst_get_modal.dart';
import '../../models/seed_dispatch/item_group_category_modal.dart';
import '../../view_model/event_management_view_modal/event_mg_vm.dart';

class CreateEventManagement extends StatelessWidget {
  //CreateEventManagement({super.key});
  CreateEventManagement({Key? key}) : super(key: key);
  final EventManagementViewModal event_mng_vm =
      Get.put(EventManagementViewModal());
  Size size = Get.size;

  static String _displayCategory(ItemCategoryMstGetModal option) =>
      option.categoryCode!;

  static String _displayGroupCategory(ItemGroupCategory option) =>
      option.groupcode!;

  static String _displayEventType(EventTypeModal option) => option.eventtype!;

  static String _displayFarmerCode(CustomersModel option) => option.customerNo!;

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
                            //event_mng_vm.eventMngGetRefressUi("");
                            Get.back();
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Create Event Management",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: event_mng_vm.loading.value,
                  child: LinearProgressIndicator(
                    backgroundColor: AllColors.primaryDark1,
                    color: AllColors.primaryliteColor,
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: !event_mng_vm.reset_field_ui.value,
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
                            bindDesc(context),
                            SizedBox(height: 8.0),
                            eventTypeDropDown(context),
                            SizedBox(height: 8.0),
                            bindeventBudget(context),
                            SizedBox(height: 8.0),
                            categoryDropDown(context),
                            SizedBox(height: 8.0),
                            groupCategoryDropDown(context),
                            SizedBox(height: 8.0),
                            FarmerDropDown(context),
                            SizedBox(height: 8.0),
                            bindeventexpectedFarmer(context),
                            SizedBox(height: 8.0),
                            eventCoverVillage(context),

                            SizedBox(height: 8.0),
                            bindeventexpectedDealer(context),
                            SizedBox(height: 8.0),
                            bindeventexpectedDistributer(context),
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
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return Expanded(
                        child: DefaultButton(
                          text: "Submit",
                          press: () {
                            event_mng_vm.createEventMng("create header",'');
                          },
                          loading: event_mng_vm.loading.value,
                        ),
                      );
                    }),
                    SizedBox(width: size.width * .01),
                    /*Expanded(
                                    child: DefaultButton(
                                      text: "Reset",
                                      press: () {
                                        plantingPageController
                                            .resetAllHeaderFields();
                                      },
                                    ),
                                  ),*/
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget bindDesc(context) {
    return TextFormField(
      controller: event_mng_vm.desc_controller,
      //keyboardType: TextInputType.number,
      onChanged: (value) {
        event_mng_vm.desc_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Description",
        labelText: "Description",
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

  Widget bindDatePicker(context) {
    return TextFormField(
      controller: event_mng_vm.date_controller,
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
                primaryColor: AllColors.primaryDark1,
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          event_mng_vm.date_controller.text = outputFormat.format(date);
        else
          event_mng_vm.date_controller.text = "";
      },
    );
  }

  Widget bindeventBudget(context) {
    return TextFormField(
      controller: event_mng_vm.budget_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        event_mng_vm.budget_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Budget",
        labelText: "Budget",
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

  Widget bindeventexpectedFarmer(context) {
    return TextFormField(
      controller: event_mng_vm.expected_farmer_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        event_mng_vm.expected_farmer_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Expected farmer",
        labelText: "Expected farmer",
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

  Widget bindeventexpectedDealer(context) {
    return TextFormField(
      controller: event_mng_vm.expected_dealer_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        event_mng_vm.expected_dealer_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Expected dealer",
        labelText: "Expected dealer",
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

  Widget bindeventexpectedDistributer(context) {
    return TextFormField(
      controller: event_mng_vm.expected_distributer_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        event_mng_vm.expected_distributer_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Expected distributer",
        labelText: "Expected distributer",
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

  Widget categoryDropDown(context) {
    return Autocomplete<ItemCategoryMstGetModal>(
      displayStringForOption: _displayCategory,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return event_mng_vm.item_ctg_mstget_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return event_mng_vm.item_ctg_mstget_list
            .where((ItemCategoryMstGetModal option) {
          return option.categoryCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstGetModal selection) {
        print(selection.categoryCode);

        event_mng_vm.item_category_code_controller.text =
            _displayCategory(selection).toString();
        event_mng_vm.selected_category.value = selection;
        event_mng_vm
            .getGroupItemCategory(_displayCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = event_mng_vm.item_category_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Category Code',
            labelText: 'Select Category Code',
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
          AutocompleteOnSelected<ItemCategoryMstGetModal> onSelected,
          Iterable<ItemCategoryMstGetModal> suggestions) {
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
                  final ItemCategoryMstGetModal option =
                      suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.categoryCode.toString(),
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

  Widget groupCategoryDropDown(context) {
    return Autocomplete<ItemGroupCategory>(
      displayStringForOption: _displayGroupCategory,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return event_mng_vm.item_group_ctg__list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return event_mng_vm.item_group_ctg__list
            .where((ItemGroupCategory option) {
          return option.groupcode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemGroupCategory selection) {
        print(selection.groupcode);

        event_mng_vm.item_group_code_controller.text =
            _displayGroupCategory(selection).toString();
        event_mng_vm.selected_group_category.value = selection;
        //event_mng_vm.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = event_mng_vm.item_group_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select group Category Code',
            labelText: 'Select group Category Code',
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
          AutocompleteOnSelected<ItemGroupCategory> onSelected,
          Iterable<ItemGroupCategory> suggestions) {
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
                  final ItemGroupCategory option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.groupcode.toString(),
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

  Widget eventTypeDropDown(context) {
    return Autocomplete<EventTypeModal>(
      displayStringForOption: _displayEventType,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return event_mng_vm.enent_type_list;
        }
        return event_mng_vm.enent_type_list.where((EventTypeModal option) {
          return option.eventtype
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (EventTypeModal selection) {
        print(selection.eventtype);

        event_mng_vm.event_type_controller.text =
            _displayEventType(selection).toString();
        event_mng_vm.selected_event_type.value = selection;
        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = event_mng_vm.event_type_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Event type',
            labelText: 'Select  Event type',
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
          AutocompleteOnSelected<EventTypeModal> onSelected,
          Iterable<EventTypeModal> suggestions) {
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
                  final EventTypeModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.eventtype.toString(),
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

  Widget FarmerDropDown(context) {
    return Autocomplete<CustomersModel>(
      displayStringForOption: _displayFarmerCode,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          event_mng_vm.isShowDocDropDown.value = false;
          return [];
        }

        return await event_mng_vm.searchFarmer(textEditingValue.text);
     /*   if (textEditingValue.text.isEmpty) {
          return event_mng_vm.farmer_list;
          // return const Iterable<PaymentTermModel>.empty();
        }*/
       /* return event_mng_vm.farmer_list.where((CustomersModel option) {
          return option.customerNo
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (CustomersModel selection) {
        print(selection.customerNo);

        event_mng_vm.farmer_code_controller.text =
            _displayFarmerCode(selection).toString();
        event_mng_vm.selected_farmer_code.value = selection;

        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = event_mng_vm.farmer_code_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Farmer Code',
            labelText: 'Select Farmer Code',
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
                        option.customerNo.toString(),
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

  Widget eventCoverVillage(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Expanded(
              child: TextFormField(
                controller: event_mng_vm.cover_villages_controller,
                onChanged: (value) {
                  event_mng_vm.cover_villages_controller.value;
                },
                decoration: InputDecoration(
                  hintText: "Cover villages",
                  labelText: "Cover villages",
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
              ),
            ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.add, color: AllColors.redColor),
                      onPressed: () {
                        // Add the current value to the list when the user presses the add button
                        event_mng_vm.updateVillageList(event_mng_vm.cover_villages_controller.text);
                        event_mng_vm.cover_villages_controller.clear();

                      },
                    ),
                  ),
                ),
          ]
    ),
          Obx(() {
            return Visibility(
              visible: event_mng_vm.villageList.isNotEmpty,
              child: Wrap(
                spacing: 5.0,
                children: event_mng_vm.villageList
                    .map((village) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Chip(
                                        shape: StadiumBorder(side: BorderSide(color: AllColors.primaryDark1)),
                                        label: Text(village,style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1
                                        ),),
                      deleteIconColor: AllColors.primaryDark1,
                                        onDeleted: () {
                      // Remove the village when the user deletes the chip
                      event_mng_vm.removeVillage(village);
                                        },
                                      ),
                    ))
                    .toList(),
              ),
            );
          },
           // child:
          ),
        ],
      ),
    );
  }
}
