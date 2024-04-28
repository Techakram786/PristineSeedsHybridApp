
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/models/seed_dispatch/production_lot_no_model.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/orders/customers_model.dart';
import '../../models/seed_dispatch/item_category_mst_get_modal.dart';
import '../../models/seed_dispatch/item_group_category_modal.dart';
import '../../models/seed_dispatch/item_master_modal.dart';
import '../../utils/app_utils.dart';
import '../../view_model/seed_dispatch_vm/seed_dispatch_vm.dart';

class AddNewSeedDispatchLineScreen extends StatelessWidget{
  AddNewSeedDispatchLineScreen({super.key});
  final SeedDispatch_VM seedDispatch_VM_Controller = Get.put(SeedDispatch_VM());
  static String _displayCategory(ItemCategoryMstGetModal option) =>
      option.categoryCode!;
  static String _displayGroupCategory(ItemGroupCategory option) =>
      option.groupcode!;
  static String _displayItemCategory(ItemMasterModal option) =>
      option.itemNo!;
  static String _displayFarmerCode(CustomersModel option) =>
      option.customerNo!;
  static String _displayProduction_lot_no(ProductionLotModel option) =>
      option.productionlotno.toString()!;

  static String _displayGot(String option) =>
      option;
  Size size = Get.size;
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
                    child: Text("Add Seed Dispatch Note Line",
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
              return Visibility( visible:seedDispatch_VM_Controller.loading.value ,
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
                      bindLotNo(context),
                      SizedBox(height: 8.0),
                      FarmerDropDown(context),
                     // SizedBox(height: 8.0),
                      //farmerName(context),
                      SizedBox(height: 8.0),
                      categoryDropDown(context),
                      SizedBox(height: 8.0),
                      groupCategoryDropDown(context),
                      SizedBox(height: 8.0),
                      itemDropDown(context),
                      SizedBox(height: 8.0),
                      bindQuantity(context),
                      SizedBox(height: 8.0),
                      bindNoOfBags(context),
                      SizedBox(height: 8.0),
                      bindCompanyBags(context),
                      SizedBox(height: 8.0),
                      bindFarmerBags(context),
                      SizedBox(height: 8.0),
                      GotDropDown(context),
                      SizedBox(height: 8.0),
                      bindMoisture(context),
                      SizedBox(height: 8.0),
                      bindHarvestAcres(context),
                      SizedBox(height: 8.0),
                      bindRemarks(context),


                    ],
                  ),
                ],

              ),
            ),
            Divider(
              height: 2,
              color: AllColors.primaryliteColor,
            ),
            Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 12,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Expanded(
                child: DefaultButton(
                text: "Submit",
                        press: () {
                          seedDispatch_VM_Controller.seedDispatchLineCreate();
                        },
                        loading: seedDispatch_VM_Controller.button_loading.value,
                      ),
                    );
                  }),
                  SizedBox(width: size.width * .01),
                  /*Expanded(
                              child: DefaultButton(
                                text: "Reset",
                                press: () {
                                  plantingPageController.resetAllLineFields();
                                },
                              ),
                            ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget bindHarvestAcres(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.harvest_acreage_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        seedDispatch_VM_Controller.harvest_acreage_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Harvest Acreage",
        labelText: "Harvest Acreage",
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
  Widget bindMoisture(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.moisture_perc_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        seedDispatch_VM_Controller.moisture_perc_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Moisture percentage",
        labelText: "Moisture percentage",
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
  Widget bindRemarks(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.remarks_controller,
      //keyboardType: TextInputType.number,
      onChanged: (value) {
        seedDispatch_VM_Controller.remarks_controller.value;
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
  Widget bindNoOfBags(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.no_of_bags_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        //seedDispatch_VM_Controller.no_of_bags_controller.value;
        int secondFieldValue = int.tryParse(seedDispatch_VM_Controller.company_bags_controller.text) ?? 0;
        int newValue = int.tryParse(value) ?? 0;
        int result = newValue - secondFieldValue;
        //seedDispatch_VM_Controller.farmer_bags_controller.text = result.toString();
      },
      decoration: InputDecoration(
        hintText: "No. of Bags",
        labelText: "No. of Bags",
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
  Widget bindQuantity(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.quantity_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        seedDispatch_VM_Controller.quantity_controller.value;

      },
      decoration: InputDecoration(
        hintText: "Quantity",
        labelText: "Quantity",
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

  Widget bindLotNo(context) {
    return Autocomplete<ProductionLotModel>(
      displayStringForOption: _displayProduction_lot_no,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.lot_no_List;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.lot_no_List
            .where((ProductionLotModel option) {
          return option.productionlotno.toString()
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ProductionLotModel selection) {
        print(selection.productionlotno);

        seedDispatch_VM_Controller.lotNo_controller.text =
            _displayProduction_lot_no(selection).toString();
        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.lotNo_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Lot No.',
            labelText: 'Select Lot No.',
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
          AutocompleteOnSelected<ProductionLotModel> onSelected,
          Iterable<ProductionLotModel> suggestions) {
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
                  final ProductionLotModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.productionlotno.toString(),
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

  Widget categoryDropDown(context) {
    return Autocomplete<ItemCategoryMstGetModal>(
      displayStringForOption: _displayCategory,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.item_ctg_mstget_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.item_ctg_mstget_list
            .where((ItemCategoryMstGetModal option) {
          return option.categoryCode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemCategoryMstGetModal selection) {
        print(selection.categoryCode);

        seedDispatch_VM_Controller.category_code_controller.text =
            _displayCategory(selection).toString();
        seedDispatch_VM_Controller.selected_category.value = selection;
        seedDispatch_VM_Controller.getGroupItemCategory(_displayCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.category_code_controller.text,
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
                  final ItemCategoryMstGetModal option = suggestions.elementAt(index);
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
          return seedDispatch_VM_Controller.item_group_ctg__list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.item_group_ctg__list
            .where((ItemGroupCategory option) {
          return option.groupcode
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemGroupCategory selection) {
        print(selection.groupcode);

        seedDispatch_VM_Controller.category_group_controller.text =
            _displayGroupCategory(selection).toString();
        seedDispatch_VM_Controller.selected_group_category.value = selection;
        seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.category_group_controller.text,
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
  Widget itemDropDown(context) {
    return Autocomplete<ItemMasterModal>(
      displayStringForOption: _displayItemCategory,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.item_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.item_list
            .where((ItemMasterModal option) {
          return option.itemNo
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ItemMasterModal selection) {
        print(selection.itemNo);

        seedDispatch_VM_Controller.item_no_controller.text =
            _displayItemCategory(selection).toString();
        seedDispatch_VM_Controller.selected_item_category.value = selection;
        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.item_no_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Item No.',
            labelText: 'Select Item No.',
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
          AutocompleteOnSelected<ItemMasterModal> onSelected,
          Iterable<ItemMasterModal> suggestions) {
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
                  final ItemMasterModal option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.itemNo.toString(),
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
          seedDispatch_VM_Controller.isShowDocDropDown.value = false;
          return [];
        }

        return await seedDispatch_VM_Controller.searchFarmer(textEditingValue.text);
      /*  if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.farmer_list;
          // return const Iterable<PaymentTermModel>.empty();
        }*/
       /* return seedDispatch_VM_Controller.farmer_list
            .where((CustomersModel option) {
          return option.customerNo
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();*/
      },
      onSelected: (CustomersModel selection) {
        print(selection.customerNo);

        seedDispatch_VM_Controller.farmer_code_controller.text = _displayFarmerCode(selection).toString();
        seedDispatch_VM_Controller.selected_organizer.value = selection;
        seedDispatch_VM_Controller.farmer_name_controller.text=selection.name!+'(${selection.customerNo})';
        seedDispatch_VM_Controller.farmer_name=selection.name!;
        print('Selection_farmer_name.....${seedDispatch_VM_Controller.customer_name.value}');


        //seedDispatch_VM_Controller.getItem(_displayGroupCategory(selection).toString());
        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          controller: controller
            ..text = seedDispatch_VM_Controller.farmer_name_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Farmer ',
            labelText: 'Select Farmer ',
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
                      child: Text(option.name.toString()+'(${option.customerNo})',
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
  Widget GotDropDown(context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return seedDispatch_VM_Controller.got_list;
          // return const Iterable<PaymentTermModel>.empty();
        }
        return seedDispatch_VM_Controller.got_list
            .where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (String selection) {
        seedDispatch_VM_Controller.got_controller.text =
            _displayGot(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return GestureDetector(
          child: TextField(
            controller: controller
              ..text = seedDispatch_VM_Controller.got_controller.text,
            focusNode: focusNode,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.one),
              hintText: 'Select Got',
              labelText: 'Select Got',
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
                      child: Text(option.toString(),
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

  Widget farmerName(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.farmer_name_controller,
      //keyboardType: TextInputType.st,
      onChanged: (value) {
        seedDispatch_VM_Controller.farmer_name_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Farmer Name",
        labelText: "Farmer Name",
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
  Widget bindCompanyBags(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.company_bags_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        updateSecond();
        seedDispatch_VM_Controller.company_bags_controller.value;
        /*int firstFieldValue = int.tryParse(seedDispatch_VM_Controller.no_of_bags_controller.text) ?? 0;
        int newValue = int.tryParse(value) ?? 0;
        int result = firstFieldValue - newValue;
        seedDispatch_VM_Controller.farmer_bags_controller.text = result.toString();*/
      },
      decoration: InputDecoration(
        hintText: "Company Bags",
        labelText: "Company Bags",
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
  Widget bindFarmerBags(context) {
    return TextFormField(
      controller: seedDispatch_VM_Controller.farmer_bags_controller,
      keyboardType: TextInputType.number,
      onChanged: (value) {
        updateThird();
        //seedDispatch_VM_Controller.farmer_bags_controller.value;
      },
      decoration: InputDecoration(
        hintText: "Farmer Bags",
        labelText: "Farmer Bags",
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

  void updateSecond() {
    int firstValue = int.tryParse(seedDispatch_VM_Controller.no_of_bags_controller.text) ?? 0;
    int secondValue = int.tryParse(seedDispatch_VM_Controller.company_bags_controller.text) ?? 0;

    if (secondValue > firstValue) {
      Utils.sanckBarError("Message",'Company bags should not be greater than total bags' );
      seedDispatch_VM_Controller.company_bags_controller.clear();
      seedDispatch_VM_Controller.farmer_bags_controller.clear();
    } else {
      seedDispatch_VM_Controller.farmer_bags_controller.text = (firstValue - secondValue).toString();
    }

    if(secondValue<=0)
    {
      seedDispatch_VM_Controller.farmer_bags_controller.clear();
    }
  }
  void updateThird() {
    int firstValue = int.tryParse(seedDispatch_VM_Controller.no_of_bags_controller.text) ?? 0;
    int secondValue = int.tryParse(seedDispatch_VM_Controller.farmer_bags_controller.text) ?? 0;

    if (secondValue > firstValue) {
      Utils.sanckBarError("Message",'Company bags should not be greater than total bags' );
      seedDispatch_VM_Controller.company_bags_controller.clear();
      seedDispatch_VM_Controller.farmer_bags_controller.clear();
    } else {
      seedDispatch_VM_Controller.company_bags_controller.text = (firstValue - secondValue).toString();
    }
    if(secondValue<=0)
      {
        seedDispatch_VM_Controller.company_bags_controller.clear();
      }
  }
  }

