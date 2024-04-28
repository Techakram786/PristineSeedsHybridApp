import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/constants/font_weight.dart';
import 'package:pristine_seeds/models/orders/order_approver_model.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/orders_vm/order_approver_vm.dart';


class OrderApproverScreen extends StatelessWidget {
  OrderApproverScreen({super.key});

  final OrderApproverViewModel pageController = Get.put(OrderApproverViewModel());


  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;
  Future<bool> onWillPop() async {
    //Get.toNamed(RoutesName.orderItemCategoryScreen);
    Get.offAllNamed(RoutesName.homeScreen);
    return false;
  }
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Obx(() {
            if (pageController.loading.value) {
              // Show a progress indicator while loading
              return Center(
                child:
                CircularProgressIndicator(color: AllColors.primaryDark1,), // You can use any progress indicator here
              );
            } else {
              // Show the UI when not loading
              return Column(
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
                                //Get.back();
                                Get.offAllNamed(RoutesName.homeScreen);
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Order Approval",
                            style: TextStyle(
                              color: AllColors.primaryDark1,
                              fontWeight: AllFontWeight.title_weight,
                              fontSize:AllFontSize.titleSize,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start, // Adjust as needed
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
                            //todo like dislike button section
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: TextButton.icon(
                                        label: Text(
                                          "Pending: ${pageController.pending_count}",
                                          style: GoogleFonts.poppins(
                                              fontSize: AllFontSize.twelve, color: Colors.blue,fontWeight: FontWeight.w700),
                                        ),
                                        icon: SizedBox.shrink(),//Icon(Icons.pending,),
                                        onPressed: () async {
                                          pageController.selection_type = "";
                                          pageController.getApprovalList('');
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: TextButton.icon(
                                        label: Text(
                                          "Approved: ${pageController.like_count}",
                                          style: GoogleFonts.poppins(
                                              fontSize: AllFontSize.twelve, color: AllColors.primaryDark1,fontWeight: FontWeight.w700),
                                        ),
                                        icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
                                        onPressed: () async {
                                          pageController.selection_type = "Approved";
                                          pageController.getApprovalList('');
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: TextButton.icon(
                                        label: Text(
                                          "Rejected: ${pageController.dislike_count}",
                                          style: GoogleFonts.poppins(
                                              fontSize: AllFontSize.twelve, color: AllColors.redColor,fontWeight: FontWeight.w700),
                                        ),
                                        icon: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red),
                                        onPressed: () async {
                                          pageController.selection_type = "Rejected";
                                          pageController.getApprovalList('');
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                            bindListLayout(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  //todo date picker
  Widget bindDatePicker(context) {
    return TextFormField(
      controller: pageController.filter_date_controller,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
          borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
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
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },




        );
        var outputFormat = DateFormat('dd-MM-yyyy');
        if (date != null && date != "")
          pageController.filter_date_controller.text =
              outputFormat.format(date);
        else
          pageController.filter_date_controller.text = "";

        pageController.getApprovalList('');
      },
    );
  }

  //todo employee dropdown
  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return pageController.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return pageController.employess_List
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
        pageController.typeAheadControllerEmployee.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller..text=pageController.typeAheadControllerEmployee.text,
          focusNode: focusNode,
          //onSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: AllFontSize.two, horizontal: AllFontSize.one),
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
              borderSide: BorderSide(color: AllColors.primaryDark1), // Change the color to green
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
                            fontSize: AllFontSize.sisxteen// Change the text color here
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


  Widget bindListLayout() {
    if(pageController.approver_list_data==null || pageController.approver_list_data.isEmpty){
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('No Records Found.',style: TextStyle(
            fontSize: 20,
            color: AllColors.primaryColor
        ),),
      );
    }else{
      Size size = Get.size;
      return Container(
        height: size.height*.7,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => Divider(
              height: .05,
              color: AllColors.primaryDark1,
            ),
            itemCount: pageController.approver_list_data.length,
            itemBuilder: (context, index) {
              var item = pageController.approver_list_data[index];
              return BindListView(context, item, index);
            }),
      );
    }
  }

  //todo listview bind
  Widget BindListView(context, OrderApproverModel item, int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
          pageController.getOrderHeaderDetails(item.orderNo!);
        },
        title:   Text("Order : ${item.orderNo!} ",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontWeight: FontWeight.w700,
              fontSize: AllFontSize.fourtine,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.customerName!,style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twelve,fontWeight: FontWeight.w300
            ),),
            Text("Qty: ${item.totalQty.toString()}" ,
                style: GoogleFonts.poppins(
                  color: AllColors.blackColor,
                  fontWeight: FontWeight.w300,
                  fontSize: AllFontSize.twelve,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( pageController.selection_type== "Rejected"?"Rej. Qty: ${item.totalApproveQty.toString()}":
                "App.Qty: ${item.totalApproveQty.toString()}" ,
                    style: GoogleFonts.poppins(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.twelve,
                    )),

                Text(" ${item.orderDate!}" ,
                    style: GoogleFonts.poppins(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.twelve,
                    )),
              ],
            ),
          ],
        ),
        leading: bindAvatar(item),
        trailing: likeDislikeIconButtonUi(item),
      ),
    );
  }

  //todo list view left icon bind
  Widget bindAvatar(OrderApproverModel item) {
    if (item.imageUrl != null && item.imageUrl != "")
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes the container circular
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0,        // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
              backgroundColor: AllColors.grayColor,
              backgroundImage: NetworkImage(item.imageUrl.toString())),
        ),
      );
    else
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Makes the container circular
          border: Border.all(
            color: Colors.grey, // Border color
            width: 1.0,        // Border width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundColor: AllColors.grayColor,
            backgroundImage: AssetImage("assets/images/no_file.png"),
          ),
        ),
      );
  }

  //todo listview right icon bind
  Widget likeDislikeIconButtonUi(OrderApproverModel item) {
    if (pageController.selection_type == "Like") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 24,
            width: 24,
            child: IconButton(
              iconSize: 24,
              icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
              onPressed: () {
                // Handle the top icon button tap
              },
              splashColor: Colors.transparent,
              // Set the splash color to transparent
              highlightColor: Colors.transparent,
            ),
          )
        ],
      );
    }
    if (pageController.selection_type == "Dislike") {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 24,
            width: 24,
            child: IconButton(
              iconSize: 24,
              icon: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red,),
              onPressed: () {
                // Handle the top icon button tap
              },
              splashColor: Colors.transparent,
              // Set the splash color to transparent
              highlightColor: Colors.transparent,
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 24,
          width: 24,
          child: IconButton(
            iconSize: 24,
            icon: SizedBox.shrink(),//Icon(Icons.thumb_up),
            onPressed: () {
              // Handle the top icon button tap
            },
            splashColor: Colors.transparent,
            // Set the splash color to transparent
            highlightColor: Colors.transparent,
          ),
        ),
        Container(
          height: 24,
          width: 24,
          child: IconButton(
            iconSize: 24,
            icon: SizedBox.shrink(),//Icon(Icons.thumb_down),
            onPressed: () {
              // Handle the top icon button tap
            },
            splashColor: Colors.transparent,
            // Set the splash color to transparent
            highlightColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

}