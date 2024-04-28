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

class IptItemVarietiesScreen extends StatelessWidget {
  IptItemVarietiesScreen({super.key});

  final iptItemVeriety_controller=Get.put(IPTViewModel());

  Size size=Get.size;

  @override
  Widget build(BuildContext context) {
    iptItemVeriety_controller.search_item_varieties_controller.clear();
    iptItemVeriety_controller.onSearchVarietiesTextChanged('');
   // var iptDate = StaticMethod.onlyDate(iptItemVeriety_controller.ipt_header_create[0].iptDate!);
    return WillPopScope(
        onWillPop: ()  async {
          iptItemVeriety_controller
              .search_item_category_crop_controller.clear();
          iptItemVeriety_controller.onSearchTextChanged('');iptItemVeriety_controller.iptItemCategoryGet(iptItemVeriety_controller
              .ipt_header_create[0]
              .iptNo!);
          Get.toNamed(RoutesName.iptItemCategoryGet);
          return true;
        },
        child:Scaffold(
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
                                iptItemVeriety_controller
                                    .search_item_category_crop_controller.clear();
                                iptItemVeriety_controller.onSearchTextChanged('');
                                iptItemVeriety_controller.iptItemCategoryGet(iptItemVeriety_controller
                                    .ipt_header_create[0]
                                    .iptNo!);
                                Get.toNamed(RoutesName.iptItemCategoryGet);
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20,),
                          child:
                              Text(
                                  "(${iptItemVeriety_controller
                                      .ipt_header_create[0].iptNo != null ?
                                  iptItemVeriety_controller
                                      .ipt_header_create[0]
                                      .iptNo! : ''}"+')',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.twentee,
                                    fontWeight: FontWeight.w700,
                                  )
                              ),


                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                iptItemVeriety_controller
                                    .ipt_header_create[0].iptStatus != null ?
                                iptItemVeriety_controller
                                    .ipt_header_create[0].iptStatus! : '',
                                style: GoogleFonts.poppins(
                                  color: iptItemVeriety_controller
                                      .ipt_header_create[0].iptStatus ==
                                      'Pending' ? AllColors.redColor : AllColors
                                      .primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                            SizedBox(height: 3,),
                            Text("",
                               // iptDate.toString(),
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.fourtine,
                                  fontWeight: FontWeight.w600,
                                )
                            ),
                          ],
                        )
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
                                    child: Text(
                                        'Varieties (${iptItemVeriety_controller.SelectedVariety.value})',
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

                                  Obx((){
                                    return bindListLayout();
                                  }),

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
        ),
       );
  }


  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(
        iptItemVeriety_controller.ipt_header_create[0].totalQty.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red, // Set your preferred text color
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
    });
  }


  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (iptItemVeriety_controller.search_group_result == null ||
        iptItemVeriety_controller.search_group_result.isEmpty) {
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
            itemCount: iptItemVeriety_controller.search_group_result.length,
            itemBuilder: (context, index) {
              //var item = orderItemGroupPageController.searchResult[index];
              return BindListView(context,index);
            }),
      );
    }
  }


  Widget bindSearchCategoryItemCrop1(context) {
    return Container(
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search,color: AllColors.primaryDark1,),
            title: new TextField(
              cursorColor: AllColors.primaryDark1,
              controller: iptItemVeriety_controller.search_item_varieties_controller,
              decoration: new InputDecoration(
                  hintText: 'Search Varieties', border: InputBorder.none,hintStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              )),
              onChanged: (value){
                iptItemVeriety_controller.onSearchVarietiesTextChanged(value);
              },
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel,color: AllColors.redColor,), onPressed: () {
              iptItemVeriety_controller.search_item_varieties_controller.clear();
              iptItemVeriety_controller.onSearchVarietiesTextChanged('');
            },
            ),
          ),
        )
    );
  }



  //todo listview bind
  Widget BindListView(context,int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
         // print(iptItemVeriety_controller.search_group_result[position].groupcode);
       //   print(iptItemVeriety_controller.search_group_result[position].categorycode);

          iptItemVeriety_controller. category_code=iptItemVeriety_controller.search_group_result[position].categorycode.toString();
          iptItemVeriety_controller. group_code=iptItemVeriety_controller.search_group_result[position].groupcode.toString();
          print("category...${iptItemVeriety_controller.search_group_result[position].categorycode}");


          iptItemVeriety_controller.getIptItem(iptItemVeriety_controller.ipt_header_create[0].iptNo!,
              iptItemVeriety_controller.search_group_result[position].categorycode!,
              iptItemVeriety_controller.search_group_result[position].groupcode!,'Vairiety');
        },
        subtitle: Row(
          children: [
            bindImage(0),
            SizedBox(width: size.width*.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(iptItemVeriety_controller.search_group_result[position].categorycode! ?? ''
                  ,style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(iptItemVeriety_controller.search_group_result[position].description ??'',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
                Text('Ipt Qty: ${iptItemVeriety_controller.search_group_result[position].orderqty!.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: iptItemVeriety_controller.search_group_result[position].orderqty!>0?AllColors.redColor:AllColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
                Text('In Kg: ${iptItemVeriety_controller.search_group_result[position].orderqty!.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: iptItemVeriety_controller.search_group_result[position].orderqty!>0?AllColors.redColor:AllColors.blackColor,
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
  Widget bindImage(int quantity) {
    if(iptItemVeriety_controller.ipt_item_group_list[0].imageurl != null &&
        iptItemVeriety_controller.ipt_item_group_list[0].imageurl != "")
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(iptItemVeriety_controller.ipt_item_group_list[0].imageurl!,
            width: 80,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If there's an error loading the image, display a default image
              return Image.asset(
                "assets/images/no_file.png",
                width: 80,
                height: 100,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      );
    else
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            "assets/images/no_file.png",
            width: 80,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      );
  }

}