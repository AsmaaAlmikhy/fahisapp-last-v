import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahisapp/global/global.dart';
import 'package:fahisapp/utils/utils.dart';
import 'package:fahisapp/widgets/NotifiService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/add_car_model.dart';
import '../models/service_model.dart';
import '../models/user.dart';
import '../responsive/Mobile_Screen.dart';
import '../utils/constants.dart';

class AppDataController extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final lastTimeCheck = TextEditingController();
  final lastMileageReached = TextEditingController();
  bool isLoading = false;
  List<ServiceModel>? allServices = [];
  List<ServiceModel>? allMyServices = [];
  VehicleModel? selectedVehicle;
  ServiceModel? selectedService;

  Future<void> removeServiceFromVehicle(ServiceModel serviceModel) async {
    try {
      kUserData!.vehicle!.firstWhere((element) {
        if (element.carCompany == serviceModel.carCompany) {
          element.services!.removeWhere(
            (element) =>
                element.carId == serviceModel.carId &&
                element.name == serviceModel.name &&
                element.duration == serviceModel.duration &&
                element.mileage == serviceModel.mileage &&
                element.nextCheckup == serviceModel.nextCheckup &&
                element.isPassed == serviceModel.isPassed &&
                element.mileagePassed == serviceModel.mileagePassed &&
                element.imageUrl == serviceModel.imageUrl &&
                element.carModel == serviceModel.carModel &&
                element.carCompany == serviceModel.carCompany,
          );
          return true;
        } else {
          return false;
        }
      });

      db.collection(usersCollection).doc(kUserData!.uid).update({
        "vehicle": kUserData!.vehicle!.map((e) => e.toJson()).toList(),
      });

      await fetchUserData();
    } catch (e) {
      log("removeServiceFromVehicle $e");
    }
    update();
  }

  List<ServiceModel>? durationBasedServices() {
    List<ServiceModel> durationBasedServices = [];
    for (var i in allServices!) {
      if (i.duration != null) {
        durationBasedServices.add(i);
      }
    }
    return durationBasedServices;
  }

  List<ServiceModel>? milageBasedServices() {
    List<ServiceModel> milageBasedServices = [];
    for (var i in allServices!) {
      if (i.mileage != null) {
        milageBasedServices.add(i);
      }
    }
    return milageBasedServices;
  }

  Future<void> fetchServices() async {
    List<ServiceModel> services = [];
    try {
      final response = await db.collection(servicesCollection).get();
      if (response.docs.isNotEmpty) {
        for (var i in response.docs) {
          services.add(
            ServiceModel.fromJson(
              i.data(),
            ),
          );
        }
      }
      allServices = services;
      log("fetchServices ${allServices!.length}");
      log("fetchServices ${allServices!}");
    } catch (e) {
      log("fetchServices $e");
    }
    update();
  }

  Future<void> fetchUserData() async {
    List<ServiceModel>? myServices = [];

    final uid = auth.currentUser!.uid;
    try {
      final response = await db.collection(usersCollection).doc(uid).get();

      if (response.exists) {
        kUserData = UserData.fromJson(response.data()!, uid);
        if (kUserData!.vehicle!.isNotEmpty) {
          for (var i = 0; i < kUserData!.vehicle!.length; i++) {
            String? imageUrl = await Utils.loadImage(
              "${kUserData!.vehicle![i].carCompany!}.png",
            );

            log("imageUrl $imageUrl");
            kUserData!.vehicle![i].imageUrl = imageUrl;
          }

          for (var i in kUserData!.vehicle!) {
            for (var j in i.services ?? []) {
              j.mileagePassed = i.carMileage;
            }
            myServices.addAll(i.services ?? []);
          }
        }
      }
      allMyServices = myServices;
    } catch (e) {
      log("fetchUserData $e");
    }
    update();
  }

  Future<void> deleteVehicle(vehicleModel) async {
    try {
      kUserData!.vehicle!.removeWhere(
        (element) => element.id == vehicleModel.id,
      );

      FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(kUserData!.uid)
          .update({
        "vehicle": kUserData!.vehicle!.map((e) => e.toJson()).toList(),
      });
      fetchUserData();
    } catch (e) {
      log("deleteVehicle $e");
    }
    update();
  }

  int getServiceDurationInDays(String value) {
    int days = 0;

    if (value.contains("w")) {
      days = int.tryParse(value[0]) == null ? 0 : int.tryParse(value[0])! * 7;
    } else if (value.contains("m")) {
      days = int.tryParse(value[0]) == null ? 0 : int.tryParse(value[0])! * 30;
    } else if (value.contains("y")) {
      days = int.tryParse(value[0]) == null ? 0 : int.tryParse(value[0])! * 365;
    }
    return days;
  }

  bool checkupTimePass(String lastCheckUpDate) {
    final days = getServiceDurationInDays(selectedService!.duration!);

    final lastCheckUp = DateTime.parse(lastCheckUpDate);

    final nextCheckUp = lastCheckUp.add(Duration(days: days));

    final now = DateTime.now();

    if (now.isAfter(nextCheckUp)) {
      return true;
    } else {
      return false;
    }
  }

  void onChangeCheckTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2000,
      ), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      print(
        pickedDate,
      ); //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(
        formattedDate,
      ); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      lastTimeCheck.text = formattedDate; //set output date to TextField value.

      final isPass = checkupTimePass(formattedDate);

      selectedService?.isPassed = isPass;
      selectedService?.nextCheckup = DateFormat('yyyy-MM-dd').format(
        pickedDate.add(
          Duration(
            days: getServiceDurationInDays(selectedService!.duration!),
          ),
        ),
      );

      log("isPass $isPass");
    } else {
      print("Date is not selected");
    }
    update();
  }

  Future<void> addServiceToVehicle() async {
    if (selectedService?.mileage != null) {
      if (lastMileageReached.text.isEmpty) {
        Get.snackbar(
          "تنبيه",
          "يحب اخال المسافة المقطوعة",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }
    } else if (selectedService?.duration != null) {
      if (selectedService?.isPassed == null ||
          selectedService?.nextCheckup == null) {
      } else if (selectedService?.isPassed == true) {
        Get.snackbar(
          "تنبيه",
          "تم تجاوز موعد الصيانة",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }
    }
    log("add");

    try {
      selectedService?.carId = selectedVehicle?.id;
      selectedService?.carCompany = selectedVehicle?.carCompany;
      selectedService?.carModel = selectedVehicle?.carModel;
      selectedVehicle?.carMileage = lastMileageReached.text;

      kUserData!.vehicle!.firstWhere((element) {
        if (element.carCompany == selectedVehicle!.carCompany) {
          element.services!.add(
            selectedService!,
          );
          return true;
        } else {
          return false;
        }
      });

      db.collection(usersCollection).doc(kUserData!.uid).update({
        "vehicle": kUserData!.vehicle!.map((e) => e.toJson()).toList(),
      });

      Get.snackbar(
        "تنبيه",
        "تم اضافة الخدمة بنجاح",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      // selectedService!.isPassed!
      //     ? NotificationService().showNotification(
      //         title: "تنبيه",
      //         body: "تم تجاوز موعد الصيانة",
      //       )
      //     : Future.delayed(const Duration(minutes: 2)).then((value) {
      //         NotificationService().showNotification(
      //           title: "تنبيه",
      //           body: "تم تجاوز موعد الصيانة",
      //         );
      //       });
      if (selectedService?.mileage == null) {
        if (selectedService?.isPassed == true) {
          NotificationService().scheduleNotification(
            scheduledNotificationDateTime:
                DateTime.now().add(const Duration(minutes: 2)),
            title: "اشعار خدمه ${selectedService?.name ?? ""}",
            body: "تم تجاوز موعد الصيانة لهذه الخدمه",
          );
        } else {
          final x = DateTime.tryParse(selectedService!.nextCheckup!);
          log("x $x");
          NotificationService().scheduleNotification(
            scheduledNotificationDateTime:
                DateTime.tryParse(selectedService!.nextCheckup!) ??
                    DateTime.now().add(const Duration(days: 1)),
            title: "اشعار خدمه ${selectedService?.name ?? ""}",
            body: "اليوم هو اليوم الخاص بعمل الصيان",
          );
        }
      }

      await fetchUserData().then(
        (value) {
          lastTimeCheck.text = "";
          lastMileageReached.text = "";
          return Get.offAll(
            () => const NavigationScreen(),
          );
        },
      );
    } catch (e) {
      log("addServiceToVehicle $e");
    }
  }

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }
}
