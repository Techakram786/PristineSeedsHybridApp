import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pristine_seeds/resourse/routes/app_routes.dart';
import 'constants/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
//todo notification section
class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
 StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();

/// A notification action which triggers a App navigation event
String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
String darwinNotificationCategoryPlain = 'plainCategory';

//todo end notification

/*void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == fetchLocationData) {
      if( MyApp.app_CurrentStatus=="Stop"){

        try {
          DatabaseHelper _databaseHelper = DatabaseHelper();
          Position userLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          List<Placemark> placemarks = await placemarkFromCoordinates(
            userLocation.latitude,
            userLocation.longitude,
          );

          if (placemarks.isNotEmpty) {
            Placemark placemark = placemarks[0];
            LocationData locationData = LocationData(
              latitude: userLocation.latitude,
              longitude: userLocation.longitude,
              area: placemark.street ?? "",
              locality: placemark.subLocality ?? "",
              postal_code: placemark.postalCode ?? "",
              country: placemark.country ?? "",
            );
            // Store the location data in the database
            await _databaseHelper.insertLocationData(locationData);
            print('Location Data: $locationData');
          }
        } catch (e) {
          print('Error getting location: $e');
        }
      }

    }
    return Future.value(true);
  });

}*/
final navigatorKey=GlobalKey<NavigatorState>();


Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   //await PushNotificationService().setupInteractedMessage();
   //await PushNotificationService().initNotifications();
 /* await PushNotificationService().initNotifications();

  await Permission.notification.isDenied.then(
        (bool value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );*/
  //todo for background service.........
 /* WidgetsFlutterBinding.ensureInitialized();
  try {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    await Workmanager().registerPeriodicTask(
      "1",
      fetchLocationData,
      initialDelay: Duration(seconds: 5),
      frequency: Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }catch(e)
  {
    print('exception is : '+e.toString());
  }*/

  // todo for Trust all certificates for network requests (for testing only).
  HttpOverrides.global = MyHttpOverrides();
  //await BackgroundService().initializeService();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  static String app_CurrentStatus="Running";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //requestPermission();
   // permissionDialog(context);


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pristine Seeds',
      theme: theme(),
      //home: ShowRoutesScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }

  Future<void> requestPermission() async {
    var permission_location = Permission.location;

    if (await permission_location.isDenied || await permission_location.isPermanentlyDenied ) {
      await permission_location.request();
    }

    var permission_notification = Permission.notification;

    if (await permission_notification.isDenied || await permission_notification.isPermanentlyDenied) {
      await permission_notification.request();
    }

    var permission_camera = Permission.camera;

    if (await permission_camera.isDenied || await permission_camera.isPermanentlyDenied) {
      await permission_camera.request();
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
  }




