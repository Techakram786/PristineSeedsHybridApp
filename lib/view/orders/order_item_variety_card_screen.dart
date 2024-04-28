import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../../view_model/orders_vm/orders_vm.dart';
class OrderItemVarietyCardScreen extends StatelessWidget {
  OrderItemVarietyCardScreen({Key? key}) : super(key: key);

  final OrdersVM orderItemVarietyCardController = Get.put(OrdersVM());
  Size size = Get.size;

  Future<bool> onWillPop() async {
    Get.back();
    //Get.offAllNamed(RoutesName.orderItemCategoryScreen);
    return false;
    // Prevent the default back behavior
  }
  @override
  Widget build(BuildContext context) {

    var orderDate = StaticMethod.onlyDate(orderItemVarietyCardController.order_detail_list[0].orderDate!);
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
                              //Get.offAllNamed(RoutesName.ordersScreen);
                              Get.toNamed(RoutesName.orderItemVarietiesScreen);
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "(${orderItemVarietyCardController
                                    .order_detail_list[0].orderNo != null ?
                                orderItemVarietyCardController.order_detail_list[0]
                                    .orderNo! : ''}"+')',
                                style: GoogleFonts.poppins(
                                  color: AllColors.primaryDark1,
                                  fontSize: AllFontSize.twentee,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: size.width*.4,
                              child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${orderItemVarietyCardController
                                      .order_detail_list[0].customerName != null ?
                                  orderItemVarietyCardController.order_detail_list[0]
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
                              orderItemVarietyCardController
                                  .order_detail_list[0].orderStatus != null ?
                              orderItemVarietyCardController
                                  .order_detail_list[0].orderStatus! : '',
                              style: GoogleFonts.poppins(
                                color: orderItemVarietyCardController
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
                Obx((){
                  return Visibility(
                    visible: orderItemVarietyCardController.isPogressIndicator.value?true:false,
                    child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: LinearProgressIndicator(
                        backgroundColor: AllColors.primaryDark1,
                        color: AllColors.ripple_green,
                        minHeight: 2,
                        value: 0,

                      ),
                    ),
                  );
                }),
                SizedBox(height: size.height * .01),
                Obx((){
                  return  Container(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                    child: ListTile(
                      subtitle: Row(
                        children: [
                          bindImage(0),
                          SizedBox(width: size.width*.04),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(orderItemVarietyCardController.order_item_get_list[0].categoryCode ?? ''
                                ,style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontSize: AllFontSize.sisxteen,
                                    fontWeight: FontWeight.w700
                                ),),
                              Text(orderItemVarietyCardController.order_item_get_list[0].groupDesc ?? '',
                                  style: GoogleFonts.poppins(
                                    color: AllColors.primaryDark1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AllFontSize.fourtine,
                                  )),
                              Text('Ordered Qty: ${orderItemVarietyCardController.order_item_get_list[0].orderQty!.toString() ?? ''}',
                                  style: GoogleFonts.poppins(
                                    color: orderItemVarietyCardController.order_item_get_list[0].orderQty!>0?AllColors.redColor:AllColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AllFontSize.fourtine,
                                  )),
                              Text('In ${orderItemVarietyCardController.order_item_get_list[0].baseUnitOfMeasure.toString()}: ${orderItemVarietyCardController.order_item_get_list[0].orderInKg!.toString() ?? ''}',
                                  style: GoogleFonts.poppins(
                                    color: orderItemVarietyCardController.order_item_get_list[0].orderInKg!>0?AllColors.redColor:AllColors.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: AllFontSize.fourtine,
                                  )),
                            ],
                          ),
                        ],
                      ),

                    ),
                  );
                }),
                Divider(
                  height: 2,
                  color: AllColors.blackColor,
                ),
                Obx((){
                  return Expanded(
                    child: Container(
                      child: bindListLayout(),
                    ),
                  );
                }),

              ],
            )
        ),
      ),
    );
  }

  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (orderItemVarietyCardController.order_item_get_list == null ||
        orderItemVarietyCardController.order_item_get_list.isEmpty) {
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
                  height: 5,
                  color: AllColors.primaryDark1,
                ),
            itemCount: orderItemVarietyCardController.order_item_get_list.length,
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
      child:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderItemVarietyCardController.order_item_get_list[position].itemName ?? ''
                      ,style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700
                      ),),
                    Text('Sec.Pack: ${orderItemVarietyCardController.order_item_get_list[position].secondaryPacking.toString() +' '+
                        orderItemVarietyCardController.order_item_get_list[position].baseUnitOfMeasure! ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),
                    Text('Price/ ${orderItemVarietyCardController.order_item_get_list[position].baseUnitOfMeasure!+': Rs. '+
                        orderItemVarietyCardController.order_item_get_list[position].unitPrice.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: AllColors.primaryDark1, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            orderItemVarietyCardController.orderItemLineInsert(orderItemVarietyCardController.order_detail_list[0].orderNo!,
                                orderItemVarietyCardController.order_item_get_list[position].itemNo!,
                                orderItemVarietyCardController.order_item_get_list[position].orderQty!,'REMOVE','VARIETY');
                          },
                        ),
                        Obx((){
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              child: Text(orderItemVarietyCardController.order_item_get_list[position].orderQty.toString(),
                                style: TextStyle(
                                  color: AllColors.primaryDark1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AllFontSize.twentee,
                                ),
                              ),
                              onTap: (){
                                showRemarkDialog(context,position);
                              },
                            ),
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: AllColors.primaryDark1, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            print(orderItemVarietyCardController.order_item_get_list[position].itemNo);
                            orderItemVarietyCardController.orderItemLineInsert(orderItemVarietyCardController.order_detail_list[0].orderNo!,
                                orderItemVarietyCardController.order_item_get_list[position].itemNo!,
                                orderItemVarietyCardController.order_item_get_list[position].orderQty!,'ADD','VARIETY');
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text('In ${orderItemVarietyCardController.order_item_get_list[position].baseUnitOfMeasure.toString()}: ${orderItemVarietyCardController.order_item_get_list[position].orderInKg!.toString()+' '+
                          orderItemVarietyCardController.order_item_get_list[position].baseUnitOfMeasure.toString() ?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          if(position==orderItemVarietyCardController.order_item_get_list.length-1)
            Divider(
              height: 2,
              color: AllColors.blackColor,
            )
        ],
      ),
    );
  }

  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(orderItemVarietyCardController.order_detail_list[0].totalQty.toString(),/*orderItemVarietyCardController.order_item_get_list[0].orderQty!=null ?
      orderItemVarietyCardController.order_item_get_list[0].orderQty.toString(): '0'*/
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red, // Set your preferred text color
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
    });
  }

  Widget bindImage(int quantity) {
    if(orderItemVarietyCardController.order_item_group_get_list[0].imageUrl != null &&
        orderItemVarietyCardController.order_item_group_get_list[0].imageUrl != "")
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
            orderItemVarietyCardController.order_item_group_get_list[0].imageUrl!,
            width: 100,
            height: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              // If there's an error loading the image, display a default image
              return Image.asset(
                "assets/images/no_file.png",
                width: 100,
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
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );

  }

  showRemarkDialog(BuildContext context, int position) {
    orderItemVarietyCardController.qty_controller.text=orderItemVarietyCardController.order_item_get_list[position].orderQty.toString();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color: AllColors.primaryDark1,),),
          content: TextFormField(
            cursorColor:AllColors.primaryDark1,
            keyboardType: TextInputType.number,
            controller: orderItemVarietyCardController.qty_controller,
            decoration: InputDecoration(labelText: "Enter Qty",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder:UnderlineInputBorder(borderSide: BorderSide(color:AllColors.primaryDark1, )),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:AllColors.primaryDark1, ))

            ),
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
                if(orderItemVarietyCardController.qty_controller.text.isNotEmpty){
                  orderItemVarietyCardController.orderItemLineInsert(orderItemVarietyCardController.order_detail_list[0].orderNo!,
                      orderItemVarietyCardController.order_item_get_list[position].itemNo!,
                      int.parse(orderItemVarietyCardController.qty_controller.text),'','Dialog');
                  Navigator.of(context).pop();
                }
                else
                  Utils.sanckBarError('Order!', 'Please Enter Order Qty');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1),),
            ),
          ],
        );
      },
    );
  }
}
