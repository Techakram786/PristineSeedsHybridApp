import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';

import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../utils/app_utils.dart';
import '../../view_model/ipt_vm/ipt_vm.dart';

class IptViewCartScreen extends StatelessWidget {
  IptViewCartScreen({super.key});
  final iptViewCard_controller=Get.put(IPTViewModel());

  Size size = Get.size;
  @override
  Widget build(BuildContext context) {
    var iptDate="";
    if(iptViewCard_controller.ipt_header_create.length>0){
      iptDate = StaticMethod.onlyDate(iptViewCard_controller.ipt_header_create[0].iptDate?? '')!;
    }
     return WillPopScope(
       onWillPop: () async  {
         if(iptViewCard_controller.selectedFlag=='Pending')
           {
             iptViewCard_controller.pageNumber=0;
             iptViewCard_controller.ipt_get_list.value=[];
             iptViewCard_controller.iptItemCategoryGet(iptViewCard_controller
                 .ipt_header_create[0]
                 .iptNo!);
             iptViewCard_controller.getIptHeaderList(iptViewCard_controller.pageNumber,iptViewCard_controller.selectedFlag.value,'FromViewCart');
           }
         else
           {
             Get.toNamed(RoutesName.iptHeaderList);
           }

         //Get.toNamed(RoutesName.iptItemVerietyCardDetails);
         return false;
       },
         child:Scaffold(
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
                              /*   iptViewCard_controller.pageNumber=0;
                                 iptViewCard_controller.ipt_get_list.value=[];
                                 iptViewCard_controller.getIptHeaderList(iptViewCard_controller.pageNumber,iptViewCard_controller.selectedFlag.value,'FromViewCart');*/
                                 if(iptViewCard_controller.selectedFlag=='Pending')
                                 {
                                   iptViewCard_controller.pageNumber=0;
                                   iptViewCard_controller.ipt_get_list.value=[];
                                   iptViewCard_controller.iptItemCategoryGet(iptViewCard_controller
                                       .ipt_header_create[0]
                                       .iptNo!);
                                   iptViewCard_controller.getIptHeaderList(iptViewCard_controller.pageNumber,iptViewCard_controller.selectedFlag.value,'FromViewCart');
                                 }
                                 else
                                 {
                                   Get.toNamed(RoutesName.iptHeaderList);
                                 }
                              //   Get.toNamed(RoutesName.iptItemVerietyCardDetails);

                               },
                             ),
                           ),
                         ),
                         Container(
                           padding: EdgeInsets.only(left: 20,top: 15),
                           child:
                               Text(
                                   "(${iptViewCard_controller
                                       .ipt_header_create[0].iptNo != null ?
                                   iptViewCard_controller
                                       .ipt_header_create[0].iptNo! : ''}"+')',
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
                                 iptViewCard_controller
                                     .ipt_header_create[0].iptStatus != null ?
                                 iptViewCard_controller
                                     .ipt_header_create[0].iptStatus! : '',
                                 style: GoogleFonts.poppins(
                                   color: iptViewCard_controller
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
                         )
                       ],
                     ),
                   ),
                   Obx((){
                     return Visibility(
                       visible: iptViewCard_controller.loading.value?true:false,
                       child: Container(
                         margin: EdgeInsets.only(top: 1),
                         child: LinearProgressIndicator(
                           backgroundColor: AllColors.primaryDark1,
                           color: AllColors.primaryliteColor,
                         ),
                       ),
                     );
                   }),
                   SizedBox(height: size.height * .01),
                   Obx((){
                     return  Container(
                       padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                       child: bindHeaderDetails(),
                     );
                   }),
                   Divider(
                     height: 2,
                     color: AllColors.primaryDark1,
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


  //todo bind header details........
  Widget bindHeaderDetails() {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('View Cart',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),
                  /*Text('\u{20B9} ${ viewCartController.order_detail_list[0].totalPrice.toString()}',
                    style: GoogleFonts.poppins(
                      color: AllColors.redColor,
                      fontSize: AllFontSize.twentee,
                      fontWeight: FontWeight.w700,)
                ),*/
                 /* Text(iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending'?'\u{20B9} ${ iptViewCard_controller.ipt_header_create[0].totalPrice.toString()}':
                  '\u{20B9}${iptViewCard_controller.ipt_header_create[0].totalApprovePrice.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.redColor,
                        fontSize: AllFontSize.twentee,
                        fontWeight: FontWeight.w700,)
                  ),*/
                ],
              ),
              SizedBox(height: size.height*.01),
              Obx((){
                return Visibility(
                  visible: iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending'?true:false,
                  child: Container(
                    width: size.width*.4,
                    child: DefaultButton(
                      text: "Create IPT",
                      press: () {
                        iptViewCard_controller.onCompleteflag="Go to List";
                        iptViewCard_controller.IptHeaderComplete(iptViewCard_controller
                            .ipt_header_create[0].iptNo!,iptViewCard_controller.onCompleteflag);
                      },
                      // loading: viewCartController.loading.value,
                    ),
                  ),
                );
              }),
              SizedBox(height: size.height*.01),
              Row(
                children: [
                  Text('Total Qty: ${iptViewCard_controller.ipt_header_create[0].totalQty.toString()}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w600,)
                  ),
                  Obx((){
                    return  Visibility(
                      visible: iptViewCard_controller.ipt_header_create[0].iptStatus!='Pending'?true:false,
                      child: Text('/ Appr.Qty: ${iptViewCard_controller.ipt_header_create[0].totalApproveQty.toString()}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,)
                      ),
                    );
                  }),
                ],
              ),
              SizedBox(height: size.height*.01),
              Row(
                children: [
                  Text('In Kg: ${iptViewCard_controller.ipt_header_create[0].totalOrderInKg.toString()+' Kg'}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontSize: AllFontSize.fourtine,
                        fontWeight: FontWeight.w600,)
                  ),
                  Obx((){
                    return  Visibility(
                      visible: iptViewCard_controller.ipt_header_create[0].iptStatus!='Pending'?true:false,
                      child: Text('/ Appr.In Kg: ${iptViewCard_controller.ipt_header_create[0].totalOrderInKg.toString()} ',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontSize: AllFontSize.fourtine,
                            fontWeight: FontWeight.w600,)
                      ),
                    );
                  }),

                ],
              ),
              SizedBox(height: size.height*.01),

            ],
          ),
        )
    );
  }


  //todo bind for list layout category items.....
  Widget bindListLayout() {
    if (iptViewCard_controller.ipt_header_create[0].lines == null ||
        iptViewCard_controller.ipt_header_create[0].lines!.isEmpty ) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text('No Records Found.', style: TextStyle(
              fontSize: 20,
              color: AllColors.primaryDark1,
              fontWeight: FontWeight.w700
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
            itemCount: iptViewCard_controller.ipt_header_create[0].lines!.length,
            itemBuilder: (context, index) {
              //var item = orderItemGroupPageController.searchResult[index];
              return BindListView(context,index);
            }),
      );
    }
  }


  Widget BindListView(context,int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
        },
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bindImage(position),
                SizedBox(width: size.width*.001),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(iptViewCard_controller.ipt_header_create[0].lines![position].itemNo ?? ''
                      ,style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700
                      ),),
                    Text('Sec.Pack: ${iptViewCard_controller.ipt_header_create[0].lines![position].secondaryPacking.toString() +' '+
                        iptViewCard_controller.ipt_header_create[0].lines![position].baseUnitOfMeasure.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),

                    Text('Lot No: ${iptViewCard_controller.ipt_header_create[0].lines![position].lotNo.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),
                   /* Text('Price/ ${iptViewCard_controller.ipt_header_create[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                        iptViewCard_controller.ipt_header_create[0].lines![position].unitPrice.toString() ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),*/
                 /*   Obx((){
                      return  Visibility(
                        visible: iptViewCard_controller.ipt_header_create[0].iptStatus!='Pending'?true:false,
                        child: Text('Appr.Price/ ${iptViewCard_controller.ipt_header_create[0].lines![position].baseUnitOfMeasure.toString()+': Rs. '+
                            iptViewCard_controller.ipt_header_create[0].lines![position].approvePrice.toString() ?? ''}',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w500,
                              fontSize: AllFontSize.fourtine,
                            )
                        ),
                      );
                    }),*/

                    Text('Ipt  Qty: ${iptViewCard_controller.ipt_header_create[0].lines![position].qty.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),
                    Obx((){
                      return  Visibility(
                        visible: iptViewCard_controller.ipt_header_create[0].iptStatus!='Pending'?true:false,
                        child: Text('Appr.Qty: ${iptViewCard_controller.ipt_header_create[0].lines![position].approveQty.toString()}',
                            style: GoogleFonts.poppins(
                              color: AllColors.primaryDark1,
                              fontWeight: FontWeight.w500,
                              fontSize: AllFontSize.fourtine,
                            )
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height*.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.remove,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            if(iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending'){
                              int qty=iptViewCard_controller.ipt_header_create[0].lines![position].qty!.toInt();
                              qty--;
                              print(qty);

                              iptViewCard_controller.IptItemLineInsert(iptViewCard_controller.
                              ipt_header_create[0].lines![position].iptNo!,
                                  iptViewCard_controller.ipt_header_create[0].lines![position].itemNo!,
                                qty,iptViewCard_controller.ipt_header_create[0].lines![position].lotNo!);
                            }
                          },
                        ),
                        Obx((){
                          return InkWell(
                            child: Text(iptViewCard_controller.ipt_header_create[0].lines![position].approveQty==0?
                            iptViewCard_controller.ipt_header_create[0].lines![position].qty.toString():
                            iptViewCard_controller.ipt_header_create[0].lines![position].approveQty.toString(),
                              style: TextStyle(
                                color: AllColors.primaryDark1,
                                fontWeight: FontWeight.w700,
                                fontSize: AllFontSize.twentee,
                              ),
                            ),
                            onTap: (){
                              if(iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending') {
                                showRemarkDialog(context, position);
                              }
                            },
                          );
                        }),

                        IconButton(
                          iconSize: 25,
                          icon: Container(
                              decoration: BoxDecoration(
                                color: iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending'?AllColors.primaryDark1:AllColors.primaryliteColor, // Change this color to your desired background color
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add,color: AllColors.customDarkerWhite,),
                              )),
                          onPressed: () {
                            if(iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending') {
                              int qty=iptViewCard_controller.ipt_header_create[0].lines![position].qty!.toInt();
                              qty++;
                             // print(qty);

                              iptViewCard_controller.IptItemLineInsert(
                                  iptViewCard_controller.ipt_header_create[0]
                                      .lines![position].iptNo!,
                                  iptViewCard_controller.ipt_header_create[0]
                                      .lines![position].itemNo!,
                                 qty,iptViewCard_controller.ipt_header_create[0].lines![position].lotNo!);
                           }
                          },
                        ),
                      ],
                    ),
                    Obx(() {
                      return  Text('In ${iptViewCard_controller.ipt_header_create[0].lines![position].baseUnitOfMeasure.toString()}: ${iptViewCard_controller.ipt_header_create[0].lines![position].orderInKg.toString()+' '+
                          iptViewCard_controller.ipt_header_create[0].lines![position].baseUnitOfMeasure.toString()?? ''}',
                          style: GoogleFonts.poppins(
                            color: AllColors.primaryDark1,
                            fontWeight: FontWeight.w500,
                            fontSize: AllFontSize.fourtine,
                          ));
                    }),
                  ],
                ),
                Spacer(),
                Expanded(
                  child: Obx((){
                    return Visibility(
                      visible: iptViewCard_controller.ipt_header_create[0].iptStatus=='Pending'?true:false,
                      child: DefaultButtonRed(
                        text: "Delete",
                        press: () {

                          iptViewCard_controller.IptItemLineInsert(iptViewCard_controller.ipt_header_create[0].lines![position].iptNo!,
                              iptViewCard_controller.ipt_header_create[0].lines![position].itemNo!,
                              0, iptViewCard_controller.ipt_header_create[0].lines![position].lotNo!);
                        },
                      ),
                    );
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }




  Widget bindImage(int position) {
    if(iptViewCard_controller.ipt_header_create[0].lines![position].imageUrl != null &&
        iptViewCard_controller.ipt_header_create[0].lines![position].imageUrl != "")
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
            iptViewCard_controller.ipt_header_create[0].lines![position].imageUrl!,
            width: 100,
            height: 120,
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
            width: 100,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );

  }
  showRemarkDialog(BuildContext context, int position) {
    iptViewCard_controller.ipt_qty_controller.text=iptViewCard_controller.ipt_header_create[0].lines![position].qty!.toString();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm...",style: TextStyle(color:AllColors.primaryDark1,),),
          content: TextFormField(
            keyboardType: TextInputType.number,
            controller: iptViewCard_controller.ipt_qty_controller,
            decoration: InputDecoration(labelText: "Enter Qty",labelStyle: TextStyle(color:AllColors.primaryDark1, ),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:AllColors.primaryDark1,))
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
                if(iptViewCard_controller.ipt_qty_controller.text.isNotEmpty){
                  iptViewCard_controller.IptItemLineInsert(iptViewCard_controller.ipt_header_create[0].lines![position].iptNo!,
                      iptViewCard_controller.ipt_header_create[0].lines![position].itemNo!,
                      int.parse(iptViewCard_controller.ipt_qty_controller.text),iptViewCard_controller.ipt_header_create[0].lines![position].lotNo!);
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