import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/view_model/ipt_vm/ipt_vm.dart';

import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/font_weight.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../models/ipt/ipt_approvar_list_model.dart';
import '../../resourse/routes/routes_name.dart';

class IptApproverScreen extends StatelessWidget{
  IptApproverScreen({super.key});

  final ipt_approver_list_controller=Get.put(IPTViewModel());

  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;

  Size size= Get.size;
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
     onWillPop: () async {

       return true;

     },

       child: Scaffold(
         backgroundColor: Colors.white,
         body: Container(
           width: double.infinity,
           height: size.height,
           child: Obx(() {
             if (ipt_approver_list_controller.loading.value) {
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
                             "IPT Approval",
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
                                           "Pending: ${ipt_approver_list_controller.pending_count}",
                                           style: GoogleFonts.poppins(
                                               fontSize: AllFontSize.twelve, color: Colors.blue,fontWeight: FontWeight.w700),
                                         ),
                                         icon: SizedBox.shrink(),//Icon(Icons.pending,),
                                         onPressed: () async {
                                           ipt_approver_list_controller.selection_type = "";
                                           ipt_approver_list_controller.getApproverList(ipt_approver_list_controller.selection_type,"");
                                         },
                                       ),
                                     ),
                                     Flexible(
                                       child: TextButton.icon(
                                         label: Text(
                                           "Approved: ${ipt_approver_list_controller.approve_count}",
                                           style: GoogleFonts.poppins(
                                               fontSize: AllFontSize.twelve, color: AllColors.primaryDark1,fontWeight: FontWeight.w700),
                                         ),
                                         icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
                                         onPressed: () async {
                                           ipt_approver_list_controller.selection_type = "Approved";
                                           ipt_approver_list_controller.getApproverList(ipt_approver_list_controller.selection_type,"");
                                         },
                                       ),
                                     ),
                                     Flexible(
                                       child: TextButton.icon(
                                         label: Text(
                                           "Rejected: ${ipt_approver_list_controller.rejected_count}",
                                           style: GoogleFonts.poppins(
                                               fontSize: AllFontSize.twelve, color: AllColors.redColor,fontWeight: FontWeight.w700),
                                         ),
                                         icon: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red),
                                         onPressed: () async {
                                           ipt_approver_list_controller.selection_type = "Rejected";
                                           ipt_approver_list_controller.getApproverList(ipt_approver_list_controller.selection_type,"");
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
      controller: ipt_approver_list_controller.filter_date_controller,
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
          ipt_approver_list_controller.filter_date_controller.text =
              outputFormat.format(date);
        else
          ipt_approver_list_controller.filter_date_controller.text = "";

        ipt_approver_list_controller.getApproverList(ipt_approver_list_controller.selection_type,"");
      },
    );
  }

  //todo employee dropdown
  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return ipt_approver_list_controller.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return ipt_approver_list_controller.employess_List
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
        ipt_approver_list_controller.ipt_emp_controller.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller..text=ipt_approver_list_controller.ipt_emp_controller.text,
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
    if(ipt_approver_list_controller.ipt_approver_list==null || ipt_approver_list_controller.ipt_approver_list.isEmpty){
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
            itemCount: ipt_approver_list_controller.ipt_approver_list.length,
            itemBuilder: (context, index) {
              var item = ipt_approver_list_controller.ipt_approver_list[index];
              return BindListView(context, item, index);
            }),
      );
    }

  }

  //todo listview bind
  Widget BindListView(context, IptApproverModel item, int position)
  {
    return InkWell(
      child: ListTile(
        onTap: () {
        ipt_approver_list_controller.getIptApproverDetails(item.iptno!);
        },
        title:     Text("${item.iptno!} (Qty: ${item.totalqty.toString()})",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: AllFontSize.fourtine,
            )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.fromcustomername!,style: GoogleFonts.poppins(
                color: AllColors.primaryDark1,
                fontSize: AllFontSize.twelve,fontWeight: FontWeight.w300
            ),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("App.Qty: ${item.totalapproveqty.toString()}" ,
                    style: GoogleFonts.poppins(
                      color: AllColors.blackColor,
                      fontWeight: FontWeight.w300,
                      fontSize: AllFontSize.twelve,
                    )),
                Text("${item.iptdate!}" ,
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
       // trailing: likeDislikeIconButtonUi(item),
      ),
    );
  }

  //todo list view left icon bind
  Widget bindAvatar(IptApproverModel item) {
    if (item.imageurl != null && item.imageurl != "")
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
              backgroundImage: NetworkImage(item.imageurl.toString())),
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
/*

  //todo listview right icon bind
  Widget likeDislikeIconButtonUi(IptApproverModel item) {
    if (ipt_approver_list_controller.selection_type == "Like") {
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
*/



}