import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import 'package:pristine_seeds/constants/app_font_size.dart';
import 'package:pristine_seeds/view_model/profile_vm/profile_vm.dart';
import '../../resourse/routes/routes_name.dart';
import '../../view_model/dash_board_vm/DashboardVM.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  Size size = Get.size;
  final profileVM=Get.put(ProfileViewModel());
  final DashboardVM dashboardVM = Get.put(DashboardVM());

  // Add this section to override the onWillPop method
  Future<bool> onWillPop() async {
    Get.offAllNamed(RoutesName.homeScreen);
    return false; // Prevent the default back behavior
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AllColors.primaryDark1,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),

                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 2.0,top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: AllColors.customDarkerWhite,
                              fontWeight: FontWeight.w700,
                              fontSize: AllFontSize.twentee,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.logout, color: AllColors.customDarkerWhite, size: 26),
                            onPressed: () {
                              Get.defaultDialog(
                                title: "LOGOUT",
                                titleStyle: const TextStyle(
                                    color: AllColors.primaryDark1, fontSize: 18, fontWeight: FontWeight.bold),
                                content: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text("Do you want to Logout?",
                                    style: TextStyle(color: AllColors.primaryDark1,
                                        fontWeight: FontWeight.w600,fontSize: AllFontSize.fourtine),),
                                ),
                                confirm: OutlinedButton(
                                  onPressed: () => profileVM.logout(),
                                  child: const Text("Yes", style: TextStyle(color: Colors.red)),
                                ),
                                cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No",
                                  style: TextStyle(color: AllColors.primaryDark1),)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    /* GestureDetector(
                      child: Container(
                        width: 110,
                        height: 110,
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(color: AllColors.lightgreyColor),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: GetImageSection(profileVM.pickedImage.value,''),
                        //Image.asset('assets/images/pristine_pfulfil.png'),
                      ),
                      onTap: (){
                        profileVM.pickProfileImage(context: context);
                      },
                    ),*/
                    Obx(() {
                      return SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            CircleAvatar(
                              backgroundColor: AllColors.lightgreyColor,
                              child: setImage1(dashboardVM.pickedImagef.value,dashboardVM.imageUrl.value),
                            ),
                            Positioned(
                                bottom: 0,
                                right: -25,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                color: Colors.grey,
                                                margin:EdgeInsets.only(left: 0,right: 0,top: 15,bottom: 5),
                                                height: 5,
                                                width:40
                                            ),
                                            Text('Profile Photo',
                                              style: GoogleFonts.poppins(
                                                  color: AllColors.primaryDark1,
                                                  fontSize: AllFontSize.sisxteen,
                                                  fontWeight:
                                                  FontWeight.w500),
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.camera_alt,color: AllColors.primaryDark1,),
                                              title: Text('Camera'),
                                              onTap: () {
                                                dashboardVM.openImageSource(ImageSource.camera); // Open camera
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.photo_library,color: AllColors.primaryDark1,),
                                              title: Text('Gallery'),
                                              onTap: () {
                                                dashboardVM.openImageSource(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  elevation: 2.0,
                                  fillColor: AllColors.customDarkerWhite,
                                  child: Icon(Icons.camera_alt, color: AllColors.primaryDark1,size: 20,),
                                  padding: EdgeInsets.all(10.0),
                                  shape: CircleBorder(),
                                )),
                          ],
                        ),
                      );
                    }),
                    SizedBox(height: size.height*0.01,),
                    Text(
                      profileVM.email.toString(),
                      style: TextStyle(color: AllColors.customDarkerWhite, fontWeight: FontWeight.w500, fontSize: AllFontSize.fourtine),
                    ),
                    SizedBox(height: size.height*0.07,),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 220,
              left: 10,
              right: 10,
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: AllColors.customDarkerWhite,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AllColors.primaryliteColor, style: BorderStyle.solid),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Your content for the second container...
                      Column(
                        children: [
                          Text('Version',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          Text(profileVM.version_code!=null?profileVM.version_code!:''
                            ,style: GoogleFonts.poppins(
                                color: AllColors.lightblackColor,
                                fontSize: AllFontSize.twentee,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: AllColors.primaryliteColor,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text('V.Name',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          Text(profileVM.version_name!=null?profileVM.version_name!:'',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.twentee,
                              fontWeight: FontWeight.w700
                          ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: AllColors.primaryliteColor,
                        thickness: 1,
                      ),
                      Column(
                        children: [
                          Text('Service',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.fourtine,
                              fontWeight: FontWeight.w300
                          ),
                          ),
                          Text('24*7',style: GoogleFonts.poppins(
                              color: AllColors.lightblackColor,
                              fontSize: AllFontSize.twentee,
                              fontWeight: FontWeight.w700
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 300,
                left: 10,
                right: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height - 300,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        listTileWidget(profileVM.name=="" ?"":profileVM.name[0].toUpperCase(),"Name",profileVM.name),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.phone==""?"":dashboardVM.phone[0].toUpperCase(),"Mobile",dashboardVM.phone),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.designation==""? "":dashboardVM.designation[0].toUpperCase(),"Designation",dashboardVM.designation),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.department==""?"":dashboardVM.department[0].toUpperCase(),"Department",dashboardVM.department),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(profileVM.company_id==""?"":profileVM.company_id[0].toUpperCase(),"Company Id",profileVM.company_id),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(profileVM.userRole==""?"":profileVM.userRole[0].toUpperCase(),"Role Name",profileVM.userRole),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.employee_id==""?"":dashboardVM.emp_id[0].toUpperCase(),"Employee Id",dashboardVM.emp_id),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.grade==""?"":dashboardVM.grade[0].toUpperCase(),"Grade",dashboardVM.grade),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.shift==""?"":dashboardVM.shift[0].toUpperCase(),"Shift",dashboardVM.shift),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        listTileWidget(dashboardVM.manager_id==""?"":dashboardVM.manager_id[0].toUpperCase(),"Manager Id",dashboardVM.manager_id),
                        Divider(
                          height: 2,
                          color: AllColors.primaryliteColor,),
                        /* listTileWidget(dashboardVM.state[0].toUpperCase(),"State",dashboardVM.state),
                    Divider(
                      height: 2,
                      color: AllColors.primaryliteColor,),
                    listTileWidget(dashboardVM.country[0].toUpperCase(),"Country",dashboardVM.country),*/
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  //todo for show user details....................
  Widget listTileWidget(String letter,String title,String subtitle){
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AllColors.primaryliteColor,
        child: Text(letter,style: GoogleFonts.poppins(
          color: AllColors.primaryDark1, // Text color
          fontWeight: FontWeight.w700,
        ),
        ),
      ),
      title: Text(title,
        style: GoogleFonts.poppins(
          color: AllColors.primaryliteColor,
          fontSize: AllFontSize.twelve,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Text(subtitle,
        style: GoogleFonts.poppins(
          color: AllColors.primaryDark1,
          fontSize: AllFontSize.fourtine,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AllColors.primaryDark1
        ),
        child: Icon(Icons.check_outlined,
          color: AllColors.customDarkerWhite,
          size: 12,),
      ),
    );

  }

  Widget GetImageSection(String? path, String? imageUrl) {
    if (path != null && path.isNotEmpty) {
      print(path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(path.toString()),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else if (imageUrl != null && imageUrl.isNotEmpty) {
      print(imageUrl);
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl.toString(),
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else {
      return Image.asset('assets/images/pristine_pfulfil.png');
    }
  }

/*  Widget setImage(String web_image_path,String mobile_image_path,String  image_url){
    if (web_image_path != null && web_image_path.isNotEmpty) {
      print(web_image_path);
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.file(
          File(web_image_path.toString()),
          width: 100,
          height: 100,
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    }
    else if (image_url != null && image_url.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          image_url.toString(),
          width: 100,
          height: 100,
          fit: BoxFit.cover, // Use BoxFit.cover to make the image fit
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset('assets/images/pristine_pfulfil.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,),
      );
    }

  }*/

  Widget setImage1( File? manual_select_file ,String image_url){
    print( 'url....'+image_url);
    if (manual_select_file != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: kIsWeb?Image.memory(dashboardVM.webImagef.value,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            // If there's an error loading the image, display a default image
            return Image.asset(
              "assets/images/no_file.png",
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            );
          },):
        Image.file(
          File(dashboardVM.picked_pic.value),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // If there's an error loading the image, display a default image
            return ImageNetwork(
              image: image_url,
              height: 100,
              width: 100,
              duration: 1500,
              curve: Curves.easeIn,
              onPointer: true,
              debugPrint: false,
              fullScreen: false,
              fitAndroidIos: BoxFit.cover,
              fitWeb: BoxFitWeb.cover,
              borderRadius: BorderRadius.circular(70),
              onLoading: const CircularProgressIndicator(
                color: AllColors.primaryDark1,
              ),
              onError: const Icon(
                Icons.error,
                color: AllColors.redColor,
              ),
              onTap: () {
                //debugPrint("©gabriel_patrick_souza");
              },
            );
          },// Use BoxFit.cover to make the image fit
        ),
      );
    }
    else if (image_url != null && image_url.isNotEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: !kIsWeb?Image.network(
            image_url.toString(),
            width: 100,
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
          ):
          ImageNetwork(
            image: image_url,
            height: 100,
            width: 100,
            duration: 1500,
            curve: Curves.easeIn,
            onPointer: true,
            debugPrint: false,
            fullScreen: false,
            fitAndroidIos: BoxFit.cover,
            fitWeb: BoxFitWeb.cover,
            borderRadius: BorderRadius.circular(70),
            onLoading: const CircularProgressIndicator(
              color: AllColors.primaryDark1,
            ),
            onError: const Icon(
              Icons.error,
              color: AllColors.redColor,
            ),
            onTap: () {
              //debugPrint("©gabriel_patrick_souza");
            },
          )
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset('assets/images/pristine_pfulfil.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,),
      );
    }

  }

}