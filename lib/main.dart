import 'package:fahisapp/responsive/Mobile_Screen.dart';
import 'package:fahisapp/screens/AddFirstV.dart';
import 'package:fahisapp/screens/AddVehicle.dart';
import 'package:fahisapp/screens/HomePage.dart';
import 'package:fahisapp/screens/LoginPage.dart';
import 'package:fahisapp/screens/SignUpPage.dart';
import 'package:fahisapp/screens/my_services/MyServices.dart';
import 'package:fahisapp/start_view/splash/SplashView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

import 'ReminderPage.dart';
import 'utils/bindings.dart';
import 'utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // NotificationService().initNotification();
  NotificationService.instance().initializeFCM();
  tz.initializeTimeZones();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: const Color.fromARGB(255, 233, 195, 166),
      // ),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 230, 163, 109),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 230, 163, 109),
          ),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
          ),
        ),
      ),
      locale: const Locale('ar', 'SA'),
      fallbackLocale: const Locale('ar', 'SA'),
      initialBinding: GetXBindings(),

      // home:  Onbording(),

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const SplashView(),
        '/login': (context) => const loginpage(),
        '/signup': (context) => const SignupScreen(),
        '/NavigationScreen': (context) => const NavigationScreen(),
        '/homepage': (context) => const HomePage(),
        '/MyServices': (context) => const MyServices(),
        '/AddVehicle': (context) => const AddVehicle(),
        '/FirstAdd': (context) => const FirstAdd(),
      },
    ),
  );
}

