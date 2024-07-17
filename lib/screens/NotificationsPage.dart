// ignore_for_file: prefer_const_constructors

// import 'dart:html';

// import 'dart:ffi';

// ignore: depend_on_referenced_packages
import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:flutter/material.dart';
// import 'package:fahisapp/app-bar.dart';
// import 'package:fahisapp/bottom-bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

import 'my_services/widgets/my_service_card.dart';
//import 'package:customizable_counter/customizable_counter.dart';

DateTime scheduleTime = DateTime.now();

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        // return SafeArea(
        child: GetBuilder<AppDataController>(
          builder: (_) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: const Color(0xffFFF8F1),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  title: Text(
                    "الاشعارات",
                    style: TextStyle(color: Colors.black),
                  ),
                ),

                // bottomNavigationBar: FABBottomAppBarItem(iconData: Icons.access_alarm, text: "h",),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: _.allMyServices!.length,
                    itemBuilder: (context, index) {
                      if (_.allMyServices![index].duration == null ||
                          _.allMyServices![index].nextCheckup == null) {
                        return SizedBox();
                      }
                      return MyServicesCard(
                        vehicleServices: _.allMyServices![index],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );
}
