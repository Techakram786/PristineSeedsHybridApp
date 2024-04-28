import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pristine_seeds/constants/font_weight.dart';
import 'package:pristine_seeds/resourse/routes/routes_name.dart';
import 'package:pristine_seeds/utils/app_utils.dart';
import '../../components/back_button.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_font_size.dart';
import '../../constants/static_methods.dart';
import '../../models/checkin_approver/check_in_approve_entity.dart';
import '../../models/dash_board/emp_master_response.dart';
import '../../view_model/check_in_approver_vm/check_in_approver_vm.dart';
class CheckInApproverScreen extends StatelessWidget {
  CheckInApproverScreen({super.key});

  final CheckInApproverViewModel checkInpageController = Get.put(CheckInApproverViewModel());

  static String _displayemployeeForOption(EmpMasterResponse option) =>
      option.loginEmailId!;
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return WillPopScope(
      onWillPop: () async {
       //Get.toNamed(RoutesName.homeScreen);
        Get.offAllNamed(RoutesName.homeScreen);//todo for close all previous screens
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Obx(() {
            if (checkInpageController.loading.value) {
              // Show a progress indicator while loading
              return Center(
                child:
                CircularProgressIndicator(color: AllColors.primaryDark1), // You can use any progress indicator here
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
                                // Get.back();
                                Get.toNamed(RoutesName.homeScreen);
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            "Check In Approval",
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
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: Column(
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
                                    //child: bindEmployeeDropDown(context),
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
                                          "Pending : ${checkInpageController.pending_count}",
                                          style: GoogleFonts.poppins(
                                              fontSize: AllFontSize.twelve, color: Colors.blue,fontWeight: FontWeight.w700),
                                        ),
                                        icon: SizedBox.shrink(),//Icon(Icons.pending,),
                                        onPressed: () async {
                                          checkInpageController.selection_type = "";
                                          checkInpageController.getApprovalList();
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: TextButton.icon(
                                        label: Text(
                                          "Approved : ${checkInpageController.like_count}",
                                          style: GoogleFonts.poppins(
                                              fontSize: AllFontSize.twelve, color: AllColors.primaryDark1,fontWeight: FontWeight.w700),
                                        ),
                                        icon: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green,),
                                        onPressed: () async {
                                          checkInpageController.selection_type = "Like";
                                          checkInpageController.getApprovalList();
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: TextButton.icon(
                                        label: Text(
                                          "Rejected : ${checkInpageController.dislike_count}",
                                          style: GoogleFonts.poppins(
                                              fontSize: AllFontSize.twelve, color: AllColors.redColor,fontWeight: FontWeight.w700),
                                        ),
                                        icon:SizedBox.shrink(), //Icon(Icons.thumb_down, color: Colors.red),
                                        onPressed: () async {
                                          checkInpageController.selection_type =
                                          "Dislike";
                                          checkInpageController.getApprovalList();
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
      controller: checkInpageController.filter_date_controller,
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
          checkInpageController.filter_date_controller.text =
              outputFormat.format(date);
        else
          checkInpageController.filter_date_controller.text = "";

        checkInpageController.getApprovalList();
      },
    );
  }

  //todo employee dropdown
  Widget bindemployeeDropDown(context) {
    return Autocomplete<EmpMasterResponse>(
      displayStringForOption: _displayemployeeForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return checkInpageController.employess_List;
          // return const Iterable<VehicleTypeResponse>.empty();
        }
        return checkInpageController.employess_List
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
        checkInpageController.typeAheadControllerEmployee.text =
            _displayemployeeForOption(selection).toString();
      },
      fieldViewBuilder: (BuildContext context, TextEditingController controller,
          FocusNode focusNode, VoidCallback onFieldSubmitted) {
        return TextField(
          cursorColor: AllColors.primaryDark1,
          controller: controller..text=checkInpageController.typeAheadControllerEmployee.text,
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
    if(checkInpageController.approver_list_data==null || checkInpageController.approver_list_data.isEmpty){
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
            itemCount: checkInpageController.approver_list_data.length,
            itemBuilder: (context, index) {
              var item = checkInpageController.approver_list_data[index];
              return BindListView(context, item, index);
            }),
      );
    }

  }

  //todo listview bind
  Widget BindListView(context, CheckInApproveEntity item, int position)
  {
    var orderDate = StaticMethod.dateTimeToDate(item.completed_on!);
    return InkWell(
      child: ListTile(
        onTap: () {

          if (checkInpageController.selection_type == "") {
            //_showGenderSelectionDialog(context, item);
            checkInpageController.currentRunningCheckInData(context,item.documentNo!);
          }
          else{
            checkInpageController.currentRunningCheckInData(context,item.documentNo!);
          }
        },
        title: Text('${item.documentNo!}${' ('}${item.empName!})',style: GoogleFonts.poppins(
            color: AllColors.blackColor,
            fontSize: AllFontSize.fourtine,fontWeight: FontWeight.w500
        ),),
        subtitle: Text("${item.placeToVisit!} ( ${orderDate.toString()} )",
            style: GoogleFonts.poppins(
              color: AllColors.blackColor,
              fontWeight: FontWeight.w300,
              fontSize: AllFontSize.twelve,
            )),
        leading: bindAvatar(item),
        trailing: likeDislikeIconButtonUi(item),
      ),
    );
  }

  //todo list view left icon bind
  Widget bindAvatar(CheckInApproveEntity item) {
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
  Widget likeDislikeIconButtonUi(CheckInApproveEntity item) {
    if (checkInpageController.selection_type == "Like") {
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
    if (checkInpageController.selection_type == "Dislike") {
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

  void _showGenderSelectionDialog(context, CheckInApproveEntity item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Approve Type',style: TextStyle(color: AllColors.primaryDark1)),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                checkInpageController.markApproveReject(item.documentNo,item.documentType, "Like",'');
                Navigator.pop(context);
              },
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: SizedBox.shrink(),//Icon(Icons.thumb_up, color: Colors.green),
                title: Text(
                  'Approved',//'Like',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                //showRemarkDialog(context,item.documentNo,item.documentType,"Dislike");

              },
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red),
                title: Text(
                  'Rejected',//'Dislike',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                //checkInpageController.currentRunningCheckInData(context,item.documentNo!);
                // checkInpageController.showLineDetailsPopup(context);
                //showRemarkDialog(context,item.documentNo,item.documentType,"Dislike");

              },
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: SizedBox.shrink(),//Icon(Icons.thumb_down, color: Colors.red),
                title: Text(
                  'View Details',//'Dislike',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _title(String text) {
    return Text(text);
  }

  void showRemarkDialog(BuildContext context, String documentNo,String documentType, String dislike) {
    Navigator.pop(context);
    checkInpageController.remarks_controller.clear();
    print('dialog...');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Enter Remarks",style: TextStyle(color: AllColors.primaryDark1,)),
          content: TextFormField(
            controller: checkInpageController.remarks_controller,
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
              child: Text("Cancel",style: TextStyle(color: AllColors.redColor)),
            ),
            TextButton(
              onPressed: () {
                if(checkInpageController.remarks_controller.text.isNotEmpty){
                  checkInpageController.markApproveReject(documentNo, documentType,dislike,checkInpageController.remarks_controller.text);
                  Navigator.of(context).pop();
                }
                else
                  Utils.sanckBarError('Remark!', 'Please Enter Remarks');
              },
              child: Text("Submit",style: TextStyle(color: AllColors.primaryDark1)),
            ),
          ],
        );
      },
    );
  }
}






