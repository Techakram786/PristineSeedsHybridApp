import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/view_model/orders_vm/orders_vm.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
class OrderItemCategoryScreen extends StatelessWidget {
  OrderItemCategoryScreen({super.key});

  final OrdersVM orderItemCategoryPageController = Get.put(OrdersVM());
  Size size = Get.size;

  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.ordersScreen);
    return false; // Prevent the default back behavior
  }

  @override
  Widget build(BuildContext context) {
    orderItemCategoryPageController
        .search_item_category_crop_controller.clear();
    orderItemCategoryPageController.onSearchTextChanged('');
    var orderDate = StaticMethod.onlyDate(orderItemCategoryPageController.order_detail_list[0].orderDate!);
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
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RoutesName.viewCartScreen);
          },
          backgroundColor: AllColors.primaryDark1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.shopping_cart_rounded, color: AllColors.whiteColor, size: 30),
              //SizedBox(width: 8), // Adjust the spacing between icon and badge
              buildShoppingBagBadge(), // Your shopping bag badge function
            ],
          ),
        ),*/
        backgroundColor: Colors.white,
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
                              Get.offAllNamed(RoutesName.ordersScreen);
                            },
                          ),
                        ),
                      ),
                      Obx((){
                        return Container(
                          padding: EdgeInsets.only(left: 20,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "(${orderItemCategoryPageController
                                      .order_detail_list[0].orderNo != null ?
                                  orderItemCategoryPageController.order_detail_list[0]
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
                                    "${orderItemCategoryPageController
                                        .order_detail_list[0].customerName!= null ?
                                    orderItemCategoryPageController.order_detail_list[0]
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
                        );
                      }),

                      Spacer(),
                      Obx((){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                orderItemCategoryPageController
                                    .order_detail_list[0].orderStatus != null ?
                                orderItemCategoryPageController
                                    .order_detail_list[0].orderStatus! : '',
                                style: GoogleFonts.poppins(
                                  color: orderItemCategoryPageController
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
                                  child: Text(
                                      orderItemCategoryPageController
                                          .order_detail_list[0].captionForCategory!,
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
      ),
    );
  }

  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(
        orderItemCategoryPageController.order_detail_list[0].totalQty
            .toString(),
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
    if (orderItemCategoryPageController.searchResult == null ||
        orderItemCategoryPageController.searchResult.isEmpty) {
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
            itemCount: orderItemCategoryPageController.searchResult.length,
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
            orderItemCategoryPageController.SelectedVariety.value=orderItemCategoryPageController.searchResult[index].categoryCode!;
            orderItemCategoryPageController.getOrderItemGroupGet(orderItemCategoryPageController.order_detail_list[0].orderNo!,
                orderItemCategoryPageController.searchResult[index].categoryCode!,'screen');

          },
          title: Text(
            '${orderItemCategoryPageController.searchResult[index]
                .categoryCode}${'('}${orderItemCategoryPageController.searchResult[index]
                .categoryDescription==null?"":orderItemCategoryPageController.searchResult[index]
                .categoryDescription}${')'}'?? '',
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
                Text('Varieties: ${orderItemCategoryPageController
                    .searchResult[index].itemGroupCount.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: AllColors.primaryDark1,
                      fontWeight: FontWeight.w500,
                      fontSize: AllFontSize.twelve,
                    )
                ),
                Text('Ordered Qty: ${orderItemCategoryPageController
                    .searchResult[index].orderQty.toString() ?? ''}',
                    style: GoogleFonts.poppins(
                      color: orderItemCategoryPageController
                          .searchResult[index].orderQty!>0?AllColors.redColor:AllColors.blackColor,
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

  //todo bind for search category items.....
  Widget bindSearchCategoryItemCrop(context) {
    return TextFormField(
      cursorColor: AllColors.primaryDark1,
      controller: orderItemCategoryPageController
          .search_item_category_crop_controller,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        orderItemCategoryPageController.search_item_category_crop_controller
            .value;
      },
      decoration: InputDecoration(
        hintText: "Search Category",
        labelText: "Search Category",
        hintStyle: GoogleFonts.poppins(
          color: AllColors.lightblackColor,
          fontWeight: FontWeight.w300,
          fontSize: AllFontSize.ten,
        ),
        suffixIcon: Icon(Icons.search, color: AllColors.primaryDark1,),
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
    );
  }

  Widget bindSearchCategoryItemCrop1(context) {
    return Container(
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.search,color: AllColors.primaryDark1,),
            title: new TextField(
              controller: orderItemCategoryPageController
                  .search_item_category_crop_controller,
              decoration: new InputDecoration(
                  hintText: 'Search Category', border: InputBorder.none,hintStyle: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontSize: AllFontSize.fourtine,
                  fontWeight: FontWeight.w500
              )),
              onChanged: (value){
                orderItemCategoryPageController.onSearchTextChanged(value);
              },
            ),
            trailing: new IconButton(
              icon: new Icon(Icons.cancel,color: AllColors.redColor,), onPressed: () {
              orderItemCategoryPageController
                  .search_item_category_crop_controller.clear();
              orderItemCategoryPageController.onSearchTextChanged('');
            },
            ),
          ),
        )
    );
  }
}
