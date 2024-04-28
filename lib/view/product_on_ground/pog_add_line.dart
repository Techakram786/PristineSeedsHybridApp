import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/models/product_on_ground/category_code_modal.dart';
import 'package:pristine_seeds/models/product_on_ground/item_group_code_modal.dart';
import 'package:pristine_seeds/models/product_on_ground/item_no_modal.dart';
import 'package:pristine_seeds/models/product_on_ground/zone_get_modal.dart';
import 'package:pristine_seeds/view_model/product_on_ground_vm/product_on_ground_vm.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/collection/customer_modal.dart';
import '../../models/planting/season_model.dart';
import '../../resourse/routes/routes_name.dart';

class POGAddLineDetails extends StatelessWidget{

  static String _displayzoneTypeForOption(ZoneModal option) => option.zone!;
  static String _displaySeasonCodeForOption(SeasonGetModel option) => option.seasonName!;
  static String _displaycategoeryCodeForOption(CategoryCodeModal option) => option.categorycode!;
  static String _displayitemGroupcodeForOption(ItemGroupCodeModal option) => option.groupcode!;
  static String _displayitemNoForOption(ItemNoModal option) => option.itemNo!;
  static String _displayCustomerOption(CustomerResponse option) => option.customerno!;
  final ProductOnGroundVM pogController = Get.put(ProductOnGroundVM());
  RxString categoryCode=''.obs;
  Size size=Get.size;
  @override
  Widget build(BuildContext context) {

   return WillPopScope(
     onWillPop:() async{
       Get.toNamed(RoutesName.productongroundScreen);
       return true;
     },
     child: Scaffold(
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
                           Get.toNamed(RoutesName.productongroundScreen);
                         },
                       ),
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.only(left: 20),
                     child: Text("${pogController.flag} POG ",
                       style: GoogleFonts.poppins(
                         color: AllColors.primaryDark1,
                         fontSize: 20,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                   ),
                   Spacer(),
                   Obx(() {
                     return Visibility(
                       visible: pogController.flag=='View'?false:true,
                       child: ActionChip(
                         elevation: 1,
                         tooltip: "Near By",
                         backgroundColor: pogController.isNearBy.value ? AllColors.primaryDark1 : AllColors.grayColor,
                         shape: StadiumBorder(
                           side: BorderSide(color: AllColors.primaryDark1),
                         ),
                         avatar: Icon(Icons.location_on,color: pogController.isNearBy.value ? AllColors.whiteColor : AllColors.primaryDark1,),
                         label: Text(
                           'Near By',
                           style: GoogleFonts.poppins(
                             color: pogController.isNearBy.value ? AllColors.whiteColor : AllColors.primaryDark1,
                             fontSize: AllFontSize.fourtine,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                         onPressed: () {
                           pogController.isNearBy.toggle();
                           // Update latitude and longitude values based on isNearBy value
                           if (pogController.isNearBy.value) {
                             pogController.lat.value = pogController.currentLat.value;
                             pogController.lng.value = pogController.currentLng.value;
                           } else {
                             pogController.lat.value =0.0;
                             pogController.lng.value =0.0;
                           }
                           //pogController.getCustomerName();
                         },
                       ),
                     );
                   }),
                 ],
               ),
             ),
             Obx(() {
               return Visibility(
                 visible: pogController.loading.value,
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
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       SingleChildScrollView(
                         child: Column(
                           children: [
                             Obx((){
                               return Visibility(visible: pogController.isZone.value,
                                   child:  getZone(context),);
                             } // child: ,
                             ),

                            /* SizedBox(height: 8),
                             empName(context),*/
                             SizedBox(height: 8),
                             Obx((){
                               return Visibility(visible: pogController.isSeason.value,
                                 child:   seasonCode(context),);
                             } // child: ,
                             ),
                             SizedBox(height: 8),
                             Obx((){
                               return Visibility(visible: pogController.isCategoryCode.value,
                                 child: categoryCodeFun(context),);
                             } // child: ,
                             ),
                             SizedBox(height: 8),
                             Obx((){
                               return Visibility(visible: pogController.isItemGroupCode.value,
                                 child:itemGroupCode(context),);
                             } // child: ,
                             ),
                             SizedBox(height: 8),
                             Obx((){
                               return Visibility(visible: pogController.isitemNo.value,
                                 child: itemNo(context),);
                             } // child: ,
                             ),
                             SizedBox(height: 8),
                             Obx((){
                               return Visibility(visible: pogController.iscustomerdritri.value,
                                 child:  customerOrDistributor(context));
                             } // child: ,
                             ),
                             SizedBox(height: 8),
                             pogQtyFun(context),
                             SizedBox(height: 8),
                             datePickup(context),
                             SizedBox(height: 8),
                             remarksFun(context),
                             SizedBox(height: 8),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
             visibiltyOfBtn(context),
             //visibilityCompleteButton(context),
           ],
         ),
       )
     ),
   );
  }

  Widget getZone( context) {
    return Autocomplete<ZoneModal>(
      displayStringForOption: _displayzoneTypeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          pogController.isShowDocDropDown.value = false;
          return pogController.zoneList;
        }

        if(pogController.flag=='View'){
          pogController.zoneList.value=[];
        }
        return pogController.zoneList
            .where((ZoneModal option) {
          return option.zone
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (ZoneModal selection) {
        print(selection.zone);
        pogController.zone_controller.value.text =
            _displayzoneTypeForOption(selection).toString();
        //pogController.selected_type.value = selection;
        FocusScope.of(context).unfocus();
      },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            readOnly:  pogController.flag=='View'?true:false,
            controller: controller
              ..text = pogController.zone_controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.one),
              hintText: 'Select Zone',
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
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<ZoneModal> onSelected,
            Iterable<ZoneModal> suggestions) {
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
                    final ZoneModal option = suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.zone.toString(),
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
        });

  }

 Widget empName( context) {
    return TextField(
      readOnly:  pogController.flag=='View'?true:false,
      cursorColor:AllColors.primaryDark1 ,
      controller: pogController.empName_controller.value,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter Emp Name',
        labelText: 'Emp Name',
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

  Widget seasonCode( context) {
    return Autocomplete<SeasonGetModel>(
        displayStringForOption: _displaySeasonCodeForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            pogController.isShowDocDropDown.value = false;
            return pogController.seasonList;
          }
          if(pogController.flag=='View'){
            pogController.seasonList.value=[];
          }
          return pogController.seasonList
              .where((SeasonGetModel option) {
            return option.seasonName
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (SeasonGetModel selection) {
          print(selection.seasonName);
          pogController.season_controller.value.text =
              _displaySeasonCodeForOption(selection).toString();
          //pogController.selected_type.value = selection;
          FocusScope.of(context).unfocus();
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            readOnly: pogController.flag=='View'?true:false,
            controller: controller
              ..text = pogController.season_controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.one),
              hintText: 'Select Season',
              labelText: 'Season',
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
        });

  }

  Widget categoryCodeFun(context) {
    return Autocomplete<CategoryCodeModal>(
        displayStringForOption: _displaycategoeryCodeForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty) {
            pogController.isShowDocDropDown.value = false;
            return pogController.categoryCodeList;
          }
          if(pogController.flag=='View'){
            pogController.categoryCodeList.value=[];
          }
          return pogController.categoryCodeList
              .where((CategoryCodeModal option) {
            return option.categorycode
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (CategoryCodeModal selection) {
          print(selection.categorycode);
          pogController. category_code=selection.categorycode.toString();
          print('categoryyyy.......${pogController. item_group_code}');

          pogController.categoryCode_controller.value.text =
              _displaycategoeryCodeForOption(selection).toString();
          //pogController.selected_type.value = selection;
          FocusScope.of(context).unfocus();
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            readOnly:  pogController.flag=='View'?true:false,
            controller: controller
              ..text = pogController.categoryCode_controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.one),
              hintText: 'Select Category code',
              labelText: 'Category code',
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
            AutocompleteOnSelected<CategoryCodeModal> onSelected,
            Iterable<CategoryCodeModal> suggestions) {
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
                    final CategoryCodeModal option = suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                        pogController.itemGroupCode_controller.value.clear();
                        pogController.isItemGroupCode.value=false;
                        pogController. isItemGroupCode.value=true;
                        pogController.itemNo_controller.value.clear();
                        pogController.isitemNo.value=false;
                        pogController.isitemNo.value=true;
                        pogController.itemGroupCodeFun();
                        categoryCode.value=pogController.categoryCodeList[index].categorycode!;
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.categorycode.toString(),
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
        });
  }

 Widget itemGroupCode( context) {
   return Autocomplete<ItemGroupCodeModal>(
       displayStringForOption: _displayitemGroupcodeForOption,
       optionsBuilder: (TextEditingValue textEditingValue) async {
         if (textEditingValue.text.isEmpty) {
           pogController.isShowDocDropDown.value = false;
           return pogController.itemGroupCodeList;
         }
         if(pogController.flag=='View'){
           pogController.itemGroupCodeList.value=[];
         }
         return pogController.itemGroupCodeList
             .where((ItemGroupCodeModal option) {
           return option.groupcode
               .toString()
               .toLowerCase()
               .contains(textEditingValue.text.toLowerCase());
         }).toList();
       },
       onSelected: (ItemGroupCodeModal selection) {
         print(selection.groupcode);
         pogController.item_group_code=selection.groupcode.toString();
         print("Item_categort........${pogController.item_group_code}");
         pogController.itemGroupCode_controller.value.text =
             _displayitemGroupcodeForOption(selection).toString();
         //pogController.selected_type.value = selection;
         FocusScope.of(context).unfocus();
       },
       fieldViewBuilder: (BuildContext context, TextEditingController controller,
           FocusNode focusNode, VoidCallback onFieldSubmitted) {
         return TextField(
           readOnly:  pogController.flag=='View'?true:false,
           controller: controller
             ..text = pogController.itemGroupCode_controller.value.text,
           focusNode: focusNode,
           //onSubmitted: onFieldSubmitted,
           decoration: InputDecoration(
             contentPadding: EdgeInsets.symmetric(
                 vertical: AllFontSize.two, horizontal: AllFontSize.one),
             hintText: 'Select Item Group code',
             labelText: ' Item Group code',
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
           AutocompleteOnSelected<ItemGroupCodeModal> onSelected,
           Iterable<ItemGroupCodeModal> suggestions) {
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
                   final ItemGroupCodeModal option = suggestions.elementAt(index);
                   return GestureDetector(
                     onTap: () {
                       onSelected(option);
                       try{
                         pogController.itemNo_controller.value.clear();
                         pogController.isitemNo.value=false;
                         pogController.isitemNo.value=true;
                         pogController.getItemNoFun();
                       }catch(e){
                         print(e);
                       }

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
       });
 }

  Widget itemNo( context) {
    return Autocomplete<ItemNoModal>(
        displayStringForOption: _displayitemNoForOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          if (textEditingValue.text.isEmpty ) {
            pogController.isShowDocDropDown.value = false;
            return pogController.itemNoList;
          }
          if(pogController.flag=='View'){
            pogController.itemNoList.value=[];
          }
          return pogController.itemNoList
              .where((ItemNoModal option) {
            return option.itemNo
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();
        },
        onSelected: (ItemNoModal selection) {
          print(selection.itemNo);
          pogController.itemNo_controller.value.text =
              _displayitemNoForOption(selection).toString();
          //pogController.selected_type.value = selection;
          FocusScope.of(context).unfocus();
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            readOnly:  pogController.flag=='View'?true:false,
            controller: controller
              ..text = pogController.itemNo_controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.one),
              hintText: 'Select Item No.',
              labelText: 'Item No.',
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
            AutocompleteOnSelected<ItemNoModal> onSelected,
            Iterable<ItemNoModal> suggestions) {
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
                    final ItemNoModal option = suggestions.elementAt(index);
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
        });
  }

 Widget customerOrDistributor( context) {
    return Autocomplete<CustomerResponse>(
        displayStringForOption: _displayCustomerOption,
        optionsBuilder: (TextEditingValue textEditingValue) async {
          /*if (textEditingValue.text.isEmpty) {
            pogController.isShowDocDropDown.value = false;
            return pogController.customerorDistributorList;
          }*/

          if (textEditingValue.text.isEmpty) {
            pogController.isShowDocDropDown.value = false;
            return [];
          }
          return await pogController.searchCustomer(textEditingValue.text);
          if(pogController.flag=='View'){
            pogController.customerorDistributorList.value=[];
          }
         /* return pogController.customerorDistributorList
              .where((CustomerResponse option) {
            return option.customerno
                .toString()
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          }).toList();*/
        },
        onSelected: (CustomerResponse selection) {
          print(selection.customerno);
          pogController.customer_controller.value.text =
              _displayCustomerOption(selection).toString();
          //pogController.selected_type.value = selection;
          FocusScope.of(context).unfocus();
        },
        fieldViewBuilder: (BuildContext context, TextEditingController controller,
            FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextField(
            readOnly:  pogController.flag=='View'?true:false,
            controller: controller
              ..text = pogController.customer_controller.value.text,
            focusNode: focusNode,
            //onSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AllFontSize.two, horizontal: AllFontSize.one),
              hintText: 'Select Customer',
              labelText: 'Customer',
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
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final CustomerResponse option = suggestions.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          option.customerno.toString(),
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
        });
  }

  pogQtyFun(BuildContext context) {
    return TextField(
      readOnly: pogController.flag=='View'?true:false,
      keyboardType: TextInputType.number,
      cursorColor:AllColors.primaryDark1 ,
      controller: pogController.pogQty_controller.value,
      // ..text = orderspageController.customers_controller.text,
      //  focusNode: focusNode,
      //onSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: 'Enter POG Qty',
        labelText: 'POG Qty',

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

  datePickup(BuildContext context) {
    return TextFormField(
      readOnly: pogController.flag=='View'?true:false,
      controller: pogController.date_controller,
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
        if(pogController.flag=='Update' || pogController.flag=='Add'){
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
            pogController.date_controller.text = outputFormat.format(date);
          else
            pogController.date_controller.text = "";
        }

      },
    );
  }

  remarksFun(BuildContext context) {
    return TextField(
      readOnly: pogController.flag=='View'?true:false,
      cursorColor:AllColors.primaryDark1 ,
      controller: pogController.remark_controller.value,
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

  visibiltyOfBtn(BuildContext context) {
     return Container(
          margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: pogController.flag=='Add'?true:false,
                child: Expanded(
                  child: DefaultButton(
                    text: "Submit",
                    press: () {
                      pogController.addLines();
                    },
                  ),
                ),
              ),
              SizedBox(width: size.width * .02),
              Visibility(
                visible: pogController.flag=='Add'?true:false ,
                child: Expanded(
                  child: DefaultButton(
                    text: "Reset",
                    press: () {
                       pogController.clearAllField();
                    },
                  ),
                ),
              ),

              Visibility(
                visible: pogController.flag=='Update'?true:false ,
                child: Expanded(
                  child: DefaultButton(
                    text: "Update",
                    press: () {
                      pogController.updateDataLine();
                    },
                  ),
                ),
              ),

              SizedBox(width: size.width * .02),
              Visibility(
                visible: pogController.flag=='Update'?true:false ,
                child: Expanded(
                  child: DefaultButton(
                    text: "Complete",
                    press: () {
                      pogController.completeLine();
                    },
                  ),
                ),
              ),
              // }),
            ],
          ),

      );
  }

}