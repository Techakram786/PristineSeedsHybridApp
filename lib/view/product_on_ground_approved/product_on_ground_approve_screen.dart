import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/models/product_on_ground/pog_approval_modal.dart';
import '../../components/back_button.dart';
import '../../components/default_button.dart';
import '../../components/default_button_red.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../resourse/routes/routes_name.dart';
import '../../utils/app_utils.dart';
import '../../view_model/product_on_ground_vm/pog_aaproval_vm.dart';
class ProductOnGroundApprovalScreen extends StatelessWidget {

  Size size = Get.size;
  final productOnGround_controller = Get.put(ProductOnGroundApprovalVm());

  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Obx(() {
          if (productOnGround_controller.loading.value) {
            return Center(
              child:
              CircularProgressIndicator(color: AllColors
                  .primaryDark1,), // You can use any progress indicator here
            );
          }
          else {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, bottom: 0, top: 25),
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
                              Get.toNamed(RoutesName.homeScreen);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text('POG Approval',
                            style: GoogleFonts.poppins(
                                color: AllColors.primaryDark1,
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // Adjust as needed
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    width: (size.width - 20) * 0.40,
                                    child: bindDatePicker(context)),
                                Container(
                                  width: (size.width - 20) * 0.60,
                                  padding: EdgeInsets.only(left: 10),
                                  child: bindemployeeDropDown(context),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Flexible(
                                    child: TextButton.icon(
                                      label: Text(
                                        "Pending: ${productOnGround_controller
                                            .pending_count}",
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.twelve,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      icon: SizedBox.shrink(),
                                      //Icon(Icons.pending,),
                                      onPressed: () async {
                                        productOnGround_controller.selection_type = "";
                                        productOnGround_controller
                                            .getApprovalList();
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: TextButton.icon(
                                      label: Text(
                                        "Approved: ${productOnGround_controller
                                            .like_count}",
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.twelve,
                                            color: AllColors.primaryDark1,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      icon: SizedBox.shrink(),
                                      //Icon(Icons.thumb_up, color: Colors.green,),
                                      onPressed: () async {
                                        productOnGround_controller
                                            .selection_type = "Approved";
                                        //productOnGround_controller.
                                        productOnGround_controller
                                            .getApprovalList();
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: TextButton.icon(
                                      label: Text(
                                        "Rejected: ${productOnGround_controller
                                            .dislike_count}",
                                        style: GoogleFonts.poppins(
                                            fontSize: AllFontSize.twelve,
                                            color: AllColors.redColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      icon: SizedBox.shrink(),
                                      //Icon(Icons.thumb_down, color: Colors.red),
                                      onPressed: () async {
                                        productOnGround_controller
                                            .selection_type = "Rejected";
                                        productOnGround_controller
                                            .getApprovalList();
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          Obx((){
                            return  bindListLayout();
                          }),

                        ],
                      ),
                    ),
                  ),
                ),
                //),
              ],
            );
          }
        }),

      ),
    );
  }

  bindListLayout() {
    if (productOnGround_controller.pogApprovalList == null ||
        productOnGround_controller.pogApprovalList.isEmpty || productOnGround_controller.pogApprovalList[0].condition=='False') {
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('No Records Found.', style: TextStyle(
            fontSize: 20,
            color: AllColors.primaryColor
        ),),
      );
    } else {
      return Container(
        height: size.height * .7,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) =>
                Divider(
                  height: .05,
                  color: AllColors.primaryDark1,
                ),
            itemCount: productOnGround_controller.pogApprovalList.length,
            itemBuilder: (context, index) {
              var item = productOnGround_controller.pogApprovalList[index];
              return BindListView(context, item, index);
            }),
      );
    }
  }

  Widget BindListView(context, ProductOnGroundApprovalModal item, int position) {
    var date=item.createdon??"";
    var orderDate = StaticMethod.dateTimeToDate(date);
    return InkWell(
      child: ListTile(
        onTap: () {
         /* productOnGround_controller.*/showBottomSheetOpen(context, item);
        },
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                ' ${productOnGround_controller
                    .pogApprovalList[position].pogcode ?? ''}',
                style: GoogleFonts.poppins(
                  color: AllColors.primaryDark1,
                  fontWeight: FontWeight.w700,
                  fontSize: AllFontSize.sisxteen,
                )),
          ],
        ),

        subtitle: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             /* Text(
                  'Emp Name : ${productOnGround_controller
                      .pogApprovalList[position].empname ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),*/
              Text(
                  'Zone : ${productOnGround_controller.pogApprovalList[position]
                      .zone ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w300,
                    fontSize: AllFontSize.fourtine,
                  )),
              Text(
                  'Season : ${productOnGround_controller
                      .pogApprovalList[position].season ?? ''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                        'Remark : ${productOnGround_controller
                            .pogApprovalList[position].remarks ??''}',
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontWeight: FontWeight.w400,
                          fontSize: AllFontSize.twelve,
                        )),
                  ),
                 /* Text(
                      ' ${orderDate.toString()??''}',
                      style: GoogleFonts.poppins(
                        color: AllColors.primaryDark1,
                        fontWeight: FontWeight.w400,
                        fontSize: AllFontSize.twelve,
                      )
                  ),*/
                ],
              ),
              Text(
                  ' ${orderDate.toString()??''}',
                  style: GoogleFonts.poppins(
                    color: AllColors.primaryDark1,
                    fontWeight: FontWeight.w400,
                    fontSize: AllFontSize.twelve,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bindDatePicker(context) {
    return TextFormField(
      controller: productOnGround_controller.filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: AllFontSize.two, horizontal: AllFontSize.one),
        hintText: "Select Date",
        labelText: 'Select Date',
        hintStyle: GoogleFonts.poppins(
            color: AllColors.lightblackColor,
            fontWeight: FontWeight.w300,
            fontSize: AllFontSize.ten
        ),
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
                primaryColor: AllColors.primaryDark1, // Header background color
                //accentColor: AllColors.primaryDark1, // Color of the buttons
                colorScheme: ColorScheme.light(primary: AllColors.primaryDark1),
                buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },


        );
        var outputFormat = DateFormat('yyyy-MM-dd');
        if (date != null && date != "")
          productOnGround_controller.filter_date_controller.text =
              outputFormat.format(date);
        else
          productOnGround_controller.filter_date_controller.text = "";
        productOnGround_controller.getApprovalList();
      },
    );
  }

  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return productOnGround_controller.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return productOnGround_controller.employess_List
            .where((EmpMasterResponse option) {
          return option.loginEmailId
              .toString()
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        }).toList();
      },
      onSelected: (EmpMasterResponse selection) {
        print(selection.loginEmailId);
        // Update the TextField with the selected
        productOnGround_controller.typeAheadControllerEmployee.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller
            ..text = productOnGround_controller.typeAheadControllerEmployee
                .text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: AllFontSize.two, horizontal: AllFontSize.one),
            hintText: 'Select Employee',
            labelText: 'Employee',
            hintStyle: GoogleFonts.poppins(
                color: AllColors.lightblackColor,
                fontWeight: FontWeight.w300,
                fontSize: AllFontSize.ten
            ),
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
          AutocompleteOnSelected<EmpMasterResponse> onSelected,
          Iterable<EmpMasterResponse> suggestions) {
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
                  final EmpMasterResponse option =
                  suggestions.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        option.loginEmailId.toString(),
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

  Future<void> showBottomSheetOpen(context, ProductOnGroundApprovalModal item) async {
    Size size=Get.size;
    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return  Container(
          width: double.infinity,
          height: size.height/2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      child: CircleBackButton(
                        press: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        "POG Details",
                        style: GoogleFonts.poppins(
                          color: AllColors.primaryDark1,
                          fontSize: AllFontSize.twentee,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(child: Divider(height: 1,color: AllColors.primaryDark1,)),
              // Obx(() {
              //  return
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Zone :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(' ${item.zone ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Emp Name:",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' ${item.empname ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300

                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Season :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${item.season ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Category Code :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${item.categorycode ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item Group Code :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' ${item.itemgroupcode ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item No. :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' ${item.itemno ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Customer/Distributor :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: size.width*.3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Tooltip(
                                        message:item.customerordistributor ?? '' ,
                                        child: Text(
                                          ' ${item.customerordistributor ?? ''}',
                                          style: GoogleFonts.poppins(
                                              color: AllColors.primaryDark1,
                                              fontSize: AllFontSize.fourtine,
                                              fontWeight: FontWeight.w300
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "POG Qty :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' ${item.pogqty ?? ''}',
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.fourtine,
                                        fontWeight: FontWeight.w300
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Remark :",
                                    style: GoogleFonts.poppins(
                                        color: AllColors.primaryDark1,
                                        fontSize: AllFontSize.sisxteen,
                                        fontWeight: FontWeight.w700),
                                  ),
                                Text(
                                  ' ${item.remarks ?? ''}',
                                      style: GoogleFonts.poppins(
                                          color: AllColors.primaryDark1,
                                          fontSize: AllFontSize.fourtine,
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),

                                ],
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              Container(
                  child:  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Visibility(
                      visible:  (productOnGround_controller.selection_type == "Approved" || productOnGround_controller.selection_type == "Rejected") ?
                      productOnGround_controller.isshowBottom.value ==true :  productOnGround_controller.isshowBottom.value == false,
                      child: Container(
                        // padding: EdgeInsets.only(bottom: 80),
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * .4,
                              child: DefaultButton(
                                text: "Approve",
                                press: () {
                                  showApproveDialog(context,item.pogcode!);
                                },
                                //  loading: viewCartController.loading.value,
                              ),
                            ),
                            Container(
                              width: size.width * .4,
                              child: DefaultButtonRed(
                                text: "Reject",
                                press: () {
                                  showRemarkDialog(context, item);

                                },
                                //loading: viewCartController.loading.value,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
              //  })
            ],
          ),
        );
      },
    );
  }

  void showRemarkDialog(context, ProductOnGroundApprovalModal item) {
    productOnGround_controller.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reject...",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            cursorColor: AllColors.primaryDark1,
            controller:productOnGround_controller.remarks_controller,
            decoration: InputDecoration(labelText: "Enter Remarks",labelStyle: TextStyle(color: AllColors.primaryDark1,),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AllColors.primaryDark1,))


            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                if(productOnGround_controller.remarks_controller.text.isNotEmpty){
                  productOnGround_controller.markApproveReject(item.pogcode!, productOnGround_controller.remarks_controller.text,'Rejected');
                  Navigator.of(context).pop();
                  Get.offAllNamed(RoutesName.productOnGroundApproval);
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }

  void showApproveDialog(context, String pogCode) {
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Approve...",style: TextStyle(color: AllColors.primaryDark1,)),
          content:Text('Do you want to approve?',style: TextStyle(color: AllColors.primaryDark1),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor,)),
            ),
            TextButton(
              onPressed: () {
                productOnGround_controller.markApproveReject(pogCode, '','Approved');
                Navigator.of(context).pop();
                Get.offAllNamed(RoutesName.productOnGroundApproval);
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1,)),
            ),
          ],
        );
      },
    );
  }

}

