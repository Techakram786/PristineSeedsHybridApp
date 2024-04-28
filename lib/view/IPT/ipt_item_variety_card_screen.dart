import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pristine_seeds/models/ipt/lot_no_model.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/ipt_vm/ipt_vm.dart';

class IptItemVarietyCardScreen extends StatelessWidget{
  IptItemVarietyCardScreen({super.key});

  final ipt_varietycard_controller=Get.put(IPTViewModel());

  static String _displayLotNoForOption(LotNoModel option) =>
      option.lotNo!;

  Size size = Get.size;

  @override
  Widget build(BuildContext context) {
    var iptDate = StaticMethod.onlyDate(ipt_varietycard_controller.ipt_header_create[0].iptDate!);
    return WillPopScope(
      onWillPop: () async  {
        ipt_varietycard_controller.search_item_varieties_controller.clear();
        ipt_varietycard_controller.onSearchVarietiesTextChanged('');
        Get.back();
       // Get.toNamed(RoutesName.iptItemVerietyGetDetails);
        return false;
      },
        child:  Scaffold(
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
                      child:buildShoppingBagBadge(),
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
                                ipt_varietycard_controller.search_item_varieties_controller.clear();
                                ipt_varietycard_controller.onSearchVarietiesTextChanged('');
                                Get.back();
                              //  Get.toNamed(RoutesName.iptItemVerietyGetDetails);

                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child:
                              Text(
                                  "(${ipt_varietycard_controller
                                      .ipt_header_create[0].iptNo != null ?
                                  ipt_varietycard_controller.ipt_header_create[0]
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
                                ipt_varietycard_controller
                                    .ipt_header_create[0].iptStatus != null ?
                                ipt_varietycard_controller
                                    .ipt_header_create[0].iptStatus! : '',
                                style: GoogleFonts.poppins(
                                  color:ipt_varietycard_controller
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
                      visible: ipt_varietycard_controller.loading.value?true:false,
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
                      child: ListTile(
                        subtitle: Row(
                          children: [
                            bindImage(0),
                            SizedBox(width: size.width*.04),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ipt_varietycard_controller.ipt_item_get_list[0].categorycode ?? ''
                                  ,style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontSize: AllFontSize.sisxteen,
                                      fontWeight: FontWeight.w700
                                  ),),
                                Text(ipt_varietycard_controller.ipt_item_get_list[0].groupdesc ?? '',
                                    style: GoogleFonts.poppins(
                                      color: AllColors.primaryDark1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AllFontSize.fourtine,
                                    )),
                                Text('Ordered Qty: ${ipt_varietycard_controller.ipt_item_get_list[0].orderqty!.toString() ?? ''}',
                                    style: GoogleFonts.poppins(
                                      color: ipt_varietycard_controller.ipt_item_get_list[0].orderqty!>0?AllColors.redColor:AllColors.blackColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: AllFontSize.fourtine,
                                    )),
                                Text('In ${ipt_varietycard_controller.ipt_item_get_list[0].baseunitofmeasure.toString()}: ${ipt_varietycard_controller.ipt_item_get_list[0].orderinkg!.toString() ?? ''}',
                                    style: GoogleFonts.poppins(
                                      color:ipt_varietycard_controller.ipt_item_get_list[0].orderinkg!>0?AllColors.redColor:AllColors.blackColor,
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
    if (ipt_varietycard_controller.ipt_item_get_list == null ||
        ipt_varietycard_controller.ipt_item_get_list.isEmpty) {
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
            itemCount: ipt_varietycard_controller.ipt_item_get_list.length,
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
   // print('hjfdjkgf......${ipt_varietycard_controller.ipt_item_get_list[position].}');
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

                    Text(ipt_varietycard_controller.ipt_item_get_list[position].itemname ?? ''
                      ,style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.sisxteen,
                          fontWeight: FontWeight.w700
                      ),),
                    Text('Sec.Pack: ${ipt_varietycard_controller.ipt_item_get_list[position].secondarypacking.toString() +' '+
                        ipt_varietycard_controller.ipt_item_get_list[position].baseunitofmeasure! ?? ''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),

                    Text('Quantity : ${ipt_varietycard_controller.ipt_item_get_list[position].orderqty.toString()}',
                        style: GoogleFonts.poppins(
                           color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )),
                   /* Text('Price/ ${ipt_varietycard_controller.ipt_item_get_list[position].baseunitofmeasure!+': Rs. '+
                        ipt_varietycard_controller.ipt_item_get_list[position].unitprice.toString() ==null ? '0' :"0"}',
                 //   ipt_varietycard_controller.ipt_item_get_list[position].unitprice.toString()}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w500,
                          fontSize: AllFontSize.fourtine,
                        )
                    ),*/
                  ],
                ),
                Spacer(),
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
                    ipt_varietycard_controller.ipt_qty_controller.text='';
                    ipt_varietycard_controller.ipt_lot_no_controller.text='';
                    if(ipt_varietycard_controller.ipt_item_get_list[0].orderqty!<=0){
                      ipt_varietycard_controller.isAddUpdate.value=true;
                      ipt_varietycard_controller.isUpdateLayout.value=false;
                      showLotNoQuantityDialog(context,position);

                    }else{
                      showAddMenu(context,position);
                    }


                    

                   // showCompleteDialog(context,position);
                    /*if(ipt_varietycard_controller.ipt_item_get_list[0].orderqty!>0){
                    //  ipt_varietycard_controller.isUpdateLayout.value=true;
                     // ipt_varietycard_controller.isAddUpdate.value=false;

                    }else{
                      ipt_varietycard_controller.isAddUpdate.value=true;
                      ipt_varietycard_controller.isUpdateLayout.value=false;
                    }*/



                  },
                ),
              ],
            ),
          ),
          if(position==ipt_varietycard_controller.ipt_item_get_list.length-1)
            Divider(
              height: 2,
              color: AllColors.blackColor,
            )
        ],
      ),
    );
  }

  Widget bindImage(int quantity) {
    if(ipt_varietycard_controller.ipt_item_get_list[0].imageurl != null
       && ipt_varietycard_controller.ipt_item_get_list[0].imageurl != "")
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
            ipt_varietycard_controller.ipt_item_get_list[0].imageurl!,
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


  //todo bind for badge items qty  .....
  Widget buildShoppingBagBadge() {
    return Obx((){
      return  Text(ipt_varietycard_controller.ipt_header_create[0].totalQty.toString(),/*orderItemVarietyCardController.order_item_get_list[0].orderQty!=null ?
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


  showLotNoQuantityDialog(BuildContext context, int position) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Set the shape to make it full-screen
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title:  Text(
            'Fill Actual Details....',
            style: GoogleFonts.poppins(
              fontSize: AllFontSize.sisxteen,
              fontWeight: FontWeight.w700,
              color: AllColors.primaryDark1,
            ),
          ),
          content:Container(
            height: 200,
            child: Column(
              children: [
                Obx(
                        (){
                      return Visibility(
                          visible : ipt_varietycard_controller.isUpdateLayout.value ?true:false ,
                          child: bindLotDropDown(context,position));}

                  // child:
                ),
                Obx(() {
                  return Visibility(
                    visible: ipt_varietycard_controller.isAddUpdate.value ?true:false ,
                    child: TextFormField(
                      controller: ipt_varietycard_controller.ipt_lot_no_controller,
                      //   keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Enter Lot No. ",
                        labelStyle: TextStyle(color: AllColors.primaryDark1),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AllColors.primaryDark1),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AllColors.primaryDark1),
                        ),
                      ),
                    ),
                  );
                },
                  //child:
                ),

                TextFormField(
                  controller: ipt_varietycard_controller.ipt_qty_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Quantity",
                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AllColors.primaryDark1),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AllColors.primaryDark1,
                      ),
                    ),
                    onPressed: () {
                      print("Qty.........${ipt_varietycard_controller.ipt_qty_controller.text}");
                      print("Lot.........${ipt_varietycard_controller.ipt_lot_no_controller.text}");
                      print("iptNo${ipt_varietycard_controller.ipt_header_create[0].iptNo!}");
                      print("item_no${ipt_varietycard_controller.ipt_item_get_list[position].itemno!}");
                      print("category...ssdss.${ipt_varietycard_controller.category_code}");
                      print("group......"+  ipt_varietycard_controller.group_code);

                      ipt_varietycard_controller.IptItemLineInsert(ipt_varietycard_controller.ipt_header_create[0].iptNo!,
                          ipt_varietycard_controller.ipt_item_get_list[position].itemno!,
                          int.parse(ipt_varietycard_controller.ipt_qty_controller.text),ipt_varietycard_controller.ipt_lot_no_controller.text );
                      Navigator.pop(context);

                      // todo  Your onPressed logic...
                    },
                    child: Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: Text(ipt_varietycard_controller.flag_lot.value =="Update"? 'Update':'Ok',
                        style: GoogleFonts.poppins(
                          color: AllColors.customDarkerWhite,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        AllColors.primaryDark1,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                     width: 60,
                      alignment: Alignment.center,
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: AllColors.customDarkerWhite,
                          fontSize: AllFontSize.fourtine,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],)
              ],
            ),
          ) ,
         /* actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  AllColors.primaryDark1,
                ),
              ),
              onPressed: () {
                print("Qty.........${ipt_varietycard_controller.ipt_qty_controller.text}");
                print("Lot.........${ipt_varietycard_controller.ipt_lot_no_controller.text}");
                print("iptNo${ipt_varietycard_controller.ipt_header_create[0].iptNo!}");
                print("item_no${ipt_varietycard_controller.ipt_item_get_list[position].itemno!}");
                print("category...ssdss.${ipt_varietycard_controller.category_code}");
                print("group......"+  ipt_varietycard_controller.group_code);

                ipt_varietycard_controller.IptItemLineInsert(ipt_varietycard_controller.ipt_header_create[0].iptNo!,
                    ipt_varietycard_controller.ipt_item_get_list[position].itemno!,
                    int.parse(ipt_varietycard_controller.ipt_qty_controller.text),ipt_varietycard_controller.ipt_lot_no_controller.text );
                Navigator.pop(context);

                // todo  Your onPressed logic...
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(ipt_varietycard_controller.flag_lot.value =="Update"? 'Update':'Ok',
                  style: GoogleFonts.poppins(
                    color: AllColors.customDarkerWhite,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  AllColors.primaryDark1,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(

                alignment: Alignment.center,
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    color: AllColors.customDarkerWhite,
                    fontSize: AllFontSize.fourtine,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],*/
          // Set the content of the dialog
      /*    child: Container(
            color: AllColors.whiteColor,
            height: size.height * 0.35,
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView( // Wrap with SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Fill Actual Details',
                    style: GoogleFonts.poppins(
                      fontSize: AllFontSize.sisxteen,
                      fontWeight: FontWeight.w700,
                      color: AllColors.primaryDark1,
                    ),
                  ),
                  //  Obx(
                    //  () {
                      //  return

                          Container(
                            child:Column(
                              children: [
                                Obx(
                                (){
                                  return Visibility(
                                      visible : ipt_varietycard_controller.isUpdateLayout.value ?true:false ,
                                      child: bindLotDropDown(context,position));}

                                 // child:
                                ),
                                Obx(() {
                                  return Visibility(
                                    visible: ipt_varietycard_controller.isAddUpdate.value ?true:false ,
                                    child: TextFormField(
                                      controller: ipt_varietycard_controller.ipt_lot_no_controller,
                                   //   keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Enter Lot No. ",
                                        labelStyle: TextStyle(color: AllColors.primaryDark1),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AllColors.primaryDark1),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AllColors.primaryDark1),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                  //child:
                                ),

                                TextFormField(
                                  controller: ipt_varietycard_controller.ipt_qty_controller,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: "Enter Quantity",
                                    labelStyle: TextStyle(color: AllColors.primaryDark1),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AllColors.primaryDark1),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: AllColors.primaryDark1),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 20, // Consider removing or reducing the height of this SizedBox
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   // SizedBox(height: 30.0), // This SizedBox seems unnecessary, consider removing it
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                          AllColors.primaryDark1,
                                        ),
                                      ),
                                      onPressed: () {
                                        print("Qty.........${ipt_varietycard_controller.ipt_qty_controller.text}");
                                        print("Lot.........${ipt_varietycard_controller.ipt_lot_no_controller.text}");
                                        print("iptNo${ipt_varietycard_controller.ipt_header_create[0].iptNo!}");
                                        print("item_no${ipt_varietycard_controller.ipt_item_get_list[position].itemno!}");
                                        print("category...ssdss.${ipt_varietycard_controller.category_code}");
                                        print("group......"+  ipt_varietycard_controller.group_code);

                                        ipt_varietycard_controller.IptItemLineInsert(ipt_varietycard_controller.ipt_header_create[0].iptNo!,
                                            ipt_varietycard_controller.ipt_item_get_list[position].itemno!,
                                           int.parse(ipt_varietycard_controller.ipt_qty_controller.text),ipt_varietycard_controller.ipt_lot_no_controller.text );
                                        Navigator.pop(context);

                                        // todo  Your onPressed logic...
                                      },
                                      child: Container(
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: Text(ipt_varietycard_controller.flag_lot.value =="Update"? 'Update':'Ok',
                                          style: GoogleFonts.poppins(
                                            color: AllColors.customDarkerWhite,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(
                                          AllColors.primaryDark1,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.poppins(
                                            color: AllColors.customDarkerWhite,
                                            fontSize: AllFontSize.fourtine,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ) ,
                          ),
                    //  },
                      //child:
                  //  ),


                ],
              ),
            ),
          ),*/
        );

      },
    );
  }

  Widget bindLotDropDown(context, int position) {
    return Autocomplete<LotNoModel>(
      displayStringForOption: _displayLotNoForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {

          return ipt_varietycard_controller.get_lot_no_list;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return ipt_varietycard_controller.get_lot_no_list
            .where((LotNoModel option) {
          return option.lotNo
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (LotNoModel selection) {
        print(selection.lotNo);
        ipt_varietycard_controller.ipt_lot_no_controller.text=
            _displayLotNoForOption(selection).toString();

        //ipt_varietycard_controller.ipt_qty_controller.text=ipt_varietycard_controller.ipt_item_get_list[position].orderqty.toString();
        ipt_varietycard_controller.ipt_qty_controller.text=selection.qty.toString();


        FocusScope.of(context).unfocus();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          onChanged: (value) {
            ipt_varietycard_controller.ipt_lot_no_controller.text=value;
          },
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = ipt_varietycard_controller.ipt_lot_no_controller.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Ipt Lot No.',
            labelText: 'Ipt Lot No.',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
               // fontWeight: FontWeight.w300,
              //  fontSize: AllFontSize.ten
        ),
            labelStyle: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
               // fontWeight: FontWeight.w700,
                fontSize: AllFontSize.sisxteen),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: AllColors.primaryDark1), // Change the color to green
            ),
          ),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<LotNoModel> onSelected,
          Iterable<LotNoModel> suggestions) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: Container(
              color: AllColors.whiteColor,
              width: size.width*.3,
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final LotNoModel option = suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.lotNo.toString(),
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


  showAddMenu(BuildContext context, int position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(size.width*.55, size.height*.36, size.width, 0),
      items: [
        PopupMenuItem(
          value: 1,
          // row has two child icon and text.
          child: Row(
            children: [
              Icon(Icons.add,color: AllColors.primaryDark1 ,),
              SizedBox(
                // sized box with width 10
                width: 10,
              ),
              Text("Add",style: GoogleFonts.poppins(color: AllColors.primaryDark1,
                   fontWeight: FontWeight.w500
              ),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          // row has two child icon and text
          child: Row(
            children: [
              Icon(Icons.update_rounded,color: AllColors.primaryDark1),
              SizedBox(
                // sized box with width 10
                width: 10,
              ),
              Text(
                "Update", style: GoogleFonts.poppins(color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w500

              ),
              )
            ],
          ),
        ),
      ],
    ).then((value) {
      // Handle menu item selection here
      if (value != null) {
        switch (value) {
          case 1:
            ipt_varietycard_controller.isAddUpdate.value=true;
            ipt_varietycard_controller.isUpdateLayout.value=false;
            showLotNoQuantityDialog(context,position);
            break;
          case 2:
            ipt_varietycard_controller.ipt_lot_no_controller.text='';
            ipt_varietycard_controller.ipt_qty_controller.text='';
            ipt_varietycard_controller.getLotNo(ipt_varietycard_controller
                .ipt_header_create[0].iptNo!,ipt_varietycard_controller.ipt_item_get_list[0].itemno!);
            ipt_varietycard_controller.isAddUpdate.value=false;
           ipt_varietycard_controller.isUpdateLayout.value=true;
            showLotNoQuantityDialog(context,position);

          // Handle action for "About"
            break;
        }
      }
    });
  }


}
