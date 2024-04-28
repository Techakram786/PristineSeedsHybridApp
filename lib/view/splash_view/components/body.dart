
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pristine_seeds/constants/app_colors.dart';
import '../../../main.dart';
import '../../../resourse/routes/routes_name.dart';
import '../../../utils/app_utils.dart';
import '../../../view_model/services/splash_services.dart';
class Body extends StatefulWidget {
   Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
   SplashServices splashServices=SplashServices();

   final size =Get.size.height;

   bool isLoading = true;
 // Added to track whether images are loading
   late ImageProvider backgroundImage,logoImage;

   @override
   void didChangeDependencies() async{
     backgroundImage = AssetImage("assets/images/splash_background_image.jpg");
     //logoImage = AssetImage("assets/images/pristine_pfulfilll.png");
     logoImage = AssetImage("assets/images/pristine_pfulfil.png");
     await precacheImage(backgroundImage,context);
     await precacheImage(logoImage,context);
     super.didChangeDependencies();
   }

   @override
   void dispose() {
    // _enableRotation();
     super.dispose();

}

   @override
   void initState() {
     super.initState();

     /*Future.delayed(Duration.zero, () {
       this.showApproveDialog();
     });*/

     Future.delayed(Duration.zero, () async {
       bool locationPermissionGranted = await checkLocationPermission();
       bool notificationPermissionGranted = await checkNotificationPermission();
       bool cameraPermissionGranted = await checkCameraPermission();
       if (!locationPermissionGranted && !notificationPermissionGranted &&
           !cameraPermissionGranted) {
         showDisclosureDialog(context);
       }
     });
   }

   Future<bool> checkLocationPermission() async {
     var permissionLocation = Permission.location;
     return await permissionLocation.isGranted;
   }



   Future<bool> checkNotificationPermission() async {
     var permissionLocation = Permission.notification;
     return await permissionLocation.isGranted;
   }


   Future<bool> checkCameraPermission() async {
     var permissionLocation = Permission.camera;
     return await permissionLocation.isGranted;
   }
   void showDisclosureDialog(BuildContext context) async {
     print('dialog...');

     showDialog(
       context: context,
       builder: (context) {
         return WillPopScope(
           onWillPop: () async => false, // Disable back button pop
           child: AlertDialog(
             title: Text(
               "Location Disclosure",
               style: TextStyle(color: AllColors.primaryDark1),
             ),
             content: Text(
               'Pristine Seeds app collects real-time Location Data to enable User to track their ride location, even when the app is closed...',
               style: TextStyle(color: AllColors.primaryDark1),
             ),
             actions: <Widget>[
               TextButton(
                 onPressed: () {
                   Utils.sanckBarError("Location Services: ", "All Permission Required for this App to Function Properly Please Enable All Permission ");

                   //  Navigator.of(context).pop();
                 },
                 child: Text(
                   "Decline",
                   style: TextStyle(color: AllColors.redColor),
                 ),
               ),
               TextButton(
                 onPressed: () {
                   requestPermission();
                   Navigator.of(context).pop();
                 },
                 child: Text(
                   "Allow",
                   style: TextStyle(color: AllColors.primaryDark1),
                 ),
               ),
             ],
           ),
         );
       },
     );
   }


   Future<void> requestPermission() async {
     var permission_location = Permission.location;
     var permission_notification = Permission.notification;
     var permission_camera = Permission.camera;


     if (await permission_location.isDenied) {
       await permission_location.request();
       if(await permission_location.isDenied){
         openAppSettings();
       }

     }
     if (await permission_notification.isDenied) {
       await permission_notification.request();
       if(await permission_notification.isDenied){
         openAppSettings();
       }

       openAppSettings();
     }

     if (await permission_camera.isDenied) {
       await permission_camera.request();
       if(await permission_camera.isDenied){
         openAppSettings();
       }

     }
     _isAndroidPermissionNotificationGranted();
     _requestPermissions_forNotification();
   }

   Future<bool> _isAndroidPermissionNotificationGranted() async {
     if (Platform.isAndroid) {
       final bool granted = await flutterLocalNotificationsPlugin
           .resolvePlatformSpecificImplementation<
           AndroidFlutterLocalNotificationsPlugin>()
           ?.areNotificationsEnabled() ??
           false;

       return granted;
     }
     return false;
   }
   Future<void> _requestPermissions_forNotification() async {
     if (Platform.isIOS || Platform.isMacOS) {
       await flutterLocalNotificationsPlugin
           .resolvePlatformSpecificImplementation<
           IOSFlutterLocalNotificationsPlugin>()
           ?.requestPermissions(
         alert: true,
         badge: true,
         sound: true,
       );
       await flutterLocalNotificationsPlugin
           .resolvePlatformSpecificImplementation<
           MacOSFlutterLocalNotificationsPlugin>()
           ?.requestPermissions(
         alert: true,
         badge: true,
         sound: true,
       );
     } else
     if (Platform.isAndroid) {
       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
       flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
           AndroidFlutterLocalNotificationsPlugin>();

       // final bool? grantedNotificationPermission =
       await androidImplementation?.requestNotificationsPermission();
       // setState(() {
       //   _notificationsEnabled = grantedNotificationPermission ?? false;
       // });
     }
   }

  @override
  Widget build(BuildContext context) {
   // _portraitModeOnly();
    return Stack(
      children: [
        // Background Image
        Image.asset(
          "assets/images/splash_background_image2.jpg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: size * .15,
          left: 0,
          right: 0,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: Color.fromARGB(100, 22, 44, 33),
                  child: Text(
                    "Pristine Seeds",
                    style: TextStyle(
                      color: AllColors.whiteColor,
                      fontSize: 38,
                      fontFamily: "Ageo Persona",
                      //  decoration: TextDecoration.underline,
                      // backgroundColor: Color.fromARGB(100, 22, 44, 33),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Center(
          child: Container(
            margin: EdgeInsets.all(8.0),
            width: 180,
            // Set the desired container width
            height: 180,
            // Set the desired container height
            decoration: BoxDecoration(
              color: Color.fromARGB(121, 22, 44, 33),
              border: Border.all(color: Colors.white10, width: .5),
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Center(
              child: Container(
                width: 120, // Set the desired image width
                height: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: logoImage,
                        fit: BoxFit.fill)), // Set the desired image height
              ),
            ),
          ),
        ),

        Positioned(
            bottom: 60,
            left: 20.0,
            right: 20.0,
            child: OutlinedButton(
              onPressed: () async {
                bool locationPermissionGranted = await checkLocationPermission();
                bool notificationPermissionGranted = await checkNotificationPermission();
                bool cameraPermissionGranted = await checkCameraPermission();
                if(locationPermissionGranted &&  notificationPermissionGranted &&  cameraPermissionGranted ){
                  Get.toNamed(RoutesName.loginScreen);
                }else {
                  Utils.sanckBarError("Permission Required", "Please All Permission Allow  for use App");
                  requestPermission();
                }
                //Get.toNamed(RoutesName.loginScreen);
              },
              child: const Text('Get Started',style: TextStyle(fontSize: 20),),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    width: 1.0, color: Color.fromARGB(121, 22, 44, 33)),
                backgroundColor: Color.fromARGB(121, 22, 44, 33),
                foregroundColor: AllColors.whiteColor,

              ),
            ))
      ],
    );
  }
   void _portraitModeOnly() {
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
     ]);
   }

   void _enableRotation() {
     SystemChrome.setPreferredOrientations([
       DeviceOrientation.portraitUp,
       DeviceOrientation.portraitDown,
       DeviceOrientation.landscapeLeft,
       DeviceOrientation.landscapeRight,
     ]);
   }

}
