import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/ipt_vm/ipt_vm.dart';

class IptItemCategory extends StatelessWidget {
  IptItemCategory({super.key});
  final _iptItemCategory_controller=Get.put(IPTViewModel());

  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    _iptItemCategory_controller.search_item_category_crop_controller.clear();
    var iptDate = StaticMethod.onlyDate(_iptItemCategory_controller.ipt_header_create[0].iptDate!);
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async  {
        Get.toNamed(RoutesName.iptHeaderList);
        return true;
      },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(RoutesName.iptViewCartScreen);
            },
            child: Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: buildShoppingBagBadge(),
                    ),
                    Icon(Icons.shopping_cart_rounded, color: AllColors.whiteColor, size: 30), // Your shopping bag icon
                  ],),
                ),
              ],

            ), // You can change the icon as needed
            backgroundColor: AllColors
                .primaryDark1, // Customize the button's background color

          ),

          body: Container(
            width: double.infinity,
            height: size.height,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 25),
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
                              Get.toNamed(RoutesName.iptHeaderList);
                            },
                          ),
                        ),
                      ),
                      Obx((){
                        return Container(
                          padding: EdgeInsets.only(left: 20,),
                          child:
                              Text(
                                  "(${_iptItemCategory_controller
                                      .ipt_header_create[0].iptNo != null ?

                                  _iptItemCategory_controller
                                      .ipt_header_create[0].iptNo! : ''}"+')',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w700,
                                  )
                              ),

                        );
                      }),

                      Spacer(),
                      Obx((){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                _iptItemCategory_controller.ipt_header_create.isNotEmpty &&
                                _iptItemCategory_controller
                                    .ipt_header_create[0].iptStatus != null ?
                                _iptItemCategory_controller
                                    .ipt_header_create[0].iptStatus! : '',
                                style: GoogleFonts.poppins(
                                  color: _iptItemCategory_controller
                                      .ipt_header_create[0].iptStatus ==
                                      'Pending' ? AllColors.redColor : AllColors
                                      .primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                            SizedBox(height: 3,),
                            Text(
                                iptDate.toString(),
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )
                            ),

                          ],
                        );
                      }),

                    ],
                  ),
                ),
                SizedBox(height: size.height * .01,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                      child: Column(
                        children: [
                          Container(
                            child: Column(crossAxisAlignment: CrossAxisAlignment
                                .start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Select Crop",
                                      style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700,
                                      )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: bindSearchCategoryItemCrop1(context),
                                ),
                                // bindItemCategoryCropDropDown(context),
                                Obx((){
                                  return  bindListLayout();
                                })

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),


        ), );
  }


  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(_iptItemCategory_controller.ipt_header_create[0].totalQty.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red, // Set your preferred text color
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
    });
  }

  Widget bindSearchCategoryItemCrop1(context) {
    return Container(
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search,color: AllColors.primaryDark1,),
            title: new TextField(
              controller: _iptItemCategory_controller
                  .search_item_category_crop_controller,
              decoration: new InputDecoration(
                  hintText: 'Search Category', border: InputBorder.none,hintStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              )),
              onChanged: (value){
                _iptItemCategory_controller.onSearchTextChanged(value);
              },
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel,color: AllColors.redColor,), onPressed: () {
              _iptItemCategory_controller
                  .search_item_category_crop_controller.clear();
              _iptItemCategory_controller.onSearchTextChanged('');
            },
            ),
          ),
        )
    );
  }

//todo bind for list layout category items.....
  Widget bindListLayout() {
    if (_iptItemCategory_controller.searchResult == null ||
        _iptItemCategory_controller.searchResult.isEmpty) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text('No Records Found.', style: TextStyle(
              fontSize: 20,
              color: AllColors.primaryColor
          ),),
        ),
      );
    } else {
      Size size = Get.size;
      return Container(
        height: size.height - 170,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) =>
                Divider(
                  height: 2,
                  color: AllColors.primaryDark1,
                ),
            itemCount: _iptItemCategory_controller.searchResult.length,
            itemBuilder: (context, index) {
              //var item = orderItemCategoryPageController.searchResult[index];
              return BindListView(context, index);
            }),
      );
    }
  }


  //todo bind for list view category items.....
  Widget BindListView(BuildContext context, int index) {
    {
      return InkWell(
        child: ListTile(
          onTap: () {
          print("tttttttttttttt"+_iptItemCategory_controller.searchResult[index].categorycode!);
            _iptItemCategory_controller.SelectedVariety.value=_iptItemCategory_controller.searchResult[index].categorycode!;

           _iptItemCategory_controller.getIptItemGroupGet(_iptItemCategory_controller.ipt_header_create[0].iptNo!,
               _iptItemCategory_controller.searchResult[index].categorycode!,'screen');
          },
          title: Text(' ${_iptItemCategory_controller.searchResult[index] .categorycode}'
              '(${_iptItemCategory_controller.searchResult[index].categorydescription?? ''})'
           ,
            style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.sisxteen, fontWeight: FontWeight.w700
            ),
          ),

          trailing: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Varieties: ${_iptItemCategory_controller
                    .searchResult[index].itemgroupcount.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    )
                ),
                Text('Ipt Qty: ${_iptItemCategory_controller
                    .searchResult[index].orderqty.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: _iptItemCategory_controller
                          .searchResult[index].orderqty!>0?AllColors.redColor:AllColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    )
                ),
              ],
            ),
          ),
        ),
      );
    }
  }




}