import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/orders_vm/orders_vm.dart';
class OrderItemVarietiesScreen extends StatelessWidget {
  OrderItemVarietiesScreen({super.key});
  final OrdersVM orderItemGroupPageController = Get.put(OrdersVM());
  Size size = Get.size;

  Future<bool> onWillPop() async {
    Get.back();
    return false; // Prevent the default back behavior
  }


  @override
  Widget build(BuildContext context) {
    orderItemGroupPageController.search_item_varieties_controller.clear();
    orderItemGroupPageController.onSearchVarietiesTextChanged('');
    var orderDate = StaticMethod.onlyDate(orderItemGroupPageController.order_detail_list[0].orderDate!);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RoutesName.viewCartScreen);
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
                              // Get.offAllNamed(RoutesName.ordersScreen);
                              Get.toNamed(RoutesName.orderItemCategoryScreen);
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20,top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "(${orderItemGroupPageController
                                    .order_detail_list[0].orderNo != null ?
                                orderItemGroupPageController.order_detail_list[0]
                                    .orderNo! : ''}"+')',
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twentee,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                            SizedBox(height: 3,),
                            Container(
                              width: size.width*.4,
                              child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${orderItemGroupPageController
                                      .order_detail_list[0].customerName != null ?
                                  orderItemGroupPageController.order_detail_list[0]
                                      .customerName! : ''}",
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.fourtine,
                                    fontWeight: FontWeight.w600,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              orderItemGroupPageController
                                  .order_detail_list[0].orderStatus != null ?
                              orderItemGroupPageController
                                  .order_detail_list[0].orderStatus! : '',
                              style: GoogleFonts.poppins(
                                color: orderItemGroupPageController
                                    .order_detail_list[0].orderStatus ==
                                    'Pending' ? AllColors.redColor : AllColors
                                    .primaryDark1,
                                fontSize: AllFontSize.fourtine,
                                fontWeight: FontWeight.w700,
                              )
                          ),
                          SizedBox(height: 3,),
                          Text(
                              orderDate.toString(),
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
                                      'Varieties (${orderItemGroupPageController.SelectedVariety.value})',
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
      ),
    );
  }

  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (orderItemGroupPageController.search_group_result == null ||
        orderItemGroupPageController.search_group_result.isEmpty) {
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
            itemCount: orderItemGroupPageController.search_group_result.length,
            itemBuilder: (context, index) {
              //var item = orderItemGroupPageController.searchResult[index];
              return BindListView(context,index);
            }),
      );
    }
  }
  //todo listview bind
  Widget BindListView(context,int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
          print(orderItemGroupPageController.search_group_result[position].groupCode);
          print(orderItemGroupPageController.search_group_result[position].categoryCode);
          orderItemGroupPageController.getOrderItem(orderItemGroupPageController.order_detail_list[0].orderNo!,
              orderItemGroupPageController.search_group_result[position].categoryCode!,
              orderItemGroupPageController.search_group_result[position].groupCode!,'Vairiety');
        },
        subtitle: Row(
          children: [
            bindImage(0),
            SizedBox(width: size.width*.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(orderItemGroupPageController.search_group_result[position].categoryCode! ?? ''
                  ,style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700
                  ),
                ),
                Text(orderItemGroupPageController.search_group_result[position].description ??'',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
                Text('Ordered Qty: ${orderItemGroupPageController.search_group_result[position].orderQty!.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: orderItemGroupPageController.search_group_result[position].orderQty!>0?AllColors.redColor:AllColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.fourtine,
                    )),
                Text('In Kg: ${orderItemGroupPageController.search_group_result[position].orderInKg!.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: orderItemGroupPageController.search_group_result[position].orderInKg!>0?AllColors.redColor:AllColors.blackColor,
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
  Widget bindSearchCategoryItemCrop1(context) {
    return Container(
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search,color: AllColors.primaryDark1,),
            title: new TextField(
              cursorColor: AllColors.primaryDark1,
              controller: orderItemGroupPageController.search_item_varieties_controller,
              decoration: new InputDecoration(
                  hintText: 'Search Varieties', border: InputBorder.none,hintStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              )),
              onChanged: (value){
                orderItemGroupPageController.onSearchVarietiesTextChanged(value);
              },
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel,color: AllColors.redColor,), onPressed: () {
              orderItemGroupPageController.search_item_varieties_controller.clear();
              orderItemGroupPageController.onSearchVarietiesTextChanged('');
            },
            ),
          ),
        )
    );
  }

  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(
        orderItemGroupPageController.order_detail_list[0].totalQty.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red, // Set your preferred text color
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
    });
  }


  //todo bind for badge items qty  .....
  Widget bindImage(int quantity) {
    if(orderItemGroupPageController.order_item_group_get_list[0].imageUrl != null &&
        orderItemGroupPageController.order_item_group_get_list[0].imageUrl != "")
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
          child: Image.network(
            orderItemGroupPageController.order_item_group_get_list[0].imageUrl!,
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
