import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:fahisapp/global/global.dart';
import 'package:fahisapp/responsive/Mobile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/add_car_model.dart';
import '../models/car_data_model.dart';
import '../models/car_plate_model.dart';
import '../utils/constants.dart';

class AddVehicleController extends GetxController {
  final fb = FirebaseFirestore.instance;

  final plateNumController = TextEditingController();
  final plateAlphabetController = TextEditingController();
  final carChassisController = TextEditingController();
  final carMileageController = TextEditingController();

  VehicleModel? addCarModel;
  List<CarDataModel> carDataModelList = [];
  List<String> vehicleCompanyList = [];
  List<String> vehicleModel = [];
  List<String> vehicleYear = [];

  bool isLoading = false;

  String selectedVehicleModel = "اختار موديل السيارة";
  String selectedVehicleCompany = "اختار شركة السيارة";
  String selectedVehicleYear = "اختار سنة السيارة";

  Future<void> addVehicle() async {
    if (selectedVehicleModel == "اختار موديل السيارة" ||
        selectedVehicleCompany == "اختار شركة السيارة" ||
        selectedVehicleYear == "اختار سنة السيارة") {
      Get.snackbar(
        "",
        "الرجاء ادخال جميع البيانات",
      );
      return;
    }
    final String vId = fb.collection(usersCollection).doc().id;
    final carChassis = carChassisController.text;
    final platAlph = plateNumController.text;
    final platNum = plateAlphabetController.text;
    addCarModel = VehicleModel(
      id: vId,
      carCompany: selectedVehicleCompany,
      carModel: selectedVehicleModel,
      carPlate: platAlph.isEmpty || platNum.isEmpty
          ? null
          : CarPlateModel(
              plateNum: plateNumController.text,
              plateAlphabet: plateAlphabetController.text,
            ),
      carProductionYear: selectedVehicleYear,
      carChassisNumber: carChassis.isEmpty ? null : carChassis,
      carMileage: carMileageController.text,
    );
    kUserData?.vehicle ??= [];
    kUserData!.vehicle!.add(addCarModel!);
    try {
      await fb.collection(usersCollection).doc(kUserData!.uid).update({
        "vehicle": kUserData!.vehicle!.map((e) => e.toJson()).toList(),
      }).then((value) async {
        Get.snackbar("", "تم اضافة السيارة بنجاح", duration: 2.seconds);
        await AppDataController().fetchUserData().then((value) {
          Get.delete<AddVehicleController>();
          Get.offAll(() => const NavigationScreen());
        });
      });
    } catch (error) {
      log("addVehicle $error");
    }
  }

  void onChangeVehicleYear(value) {
    selectedVehicleYear = value;
    update();
  }

  void onChangeVehicleModel(value) {
    selectedVehicleModel = value;
    update();
  }

  void onChangeVehicleCompany(value) {
    selectedVehicleModel = "اختار موديل السيارة";
    vehicleModel.clear();
    selectedVehicleCompany = value;
    checkAndGetAllModelForSelectedCompany();
    update();
  }

  void getYearsList() {
    vehicleYear.clear();
    vehicleYear.add("اختار سنة السيارة");
    DateTime now = DateTime.now();
    for (int i = 0; i < 20; i++) {
      vehicleYear.add((now.year - i).toString());
    }
    update();
  }

  void checkAndGetAllModelForSelectedCompany() {
    if (selectedVehicleCompany == "اختار شركة السيارة") {
      Get.snackbar("خطأ", "الرجاء اختيار الشركة أولاً");
      return;
    } else {
      vehicleModel = getModelData();
    }
    update();
  }

  //* get model data from company
  List<String> getModelData() {
    List<String> modelList = [];
    modelList.add("اختار موديل السيارة");
    for (var company in carDataModelList) {
      if (company.company == selectedVehicleCompany) {
        final carModel =
            modelList.firstWhereOrNull((element) => element == company.model!);
        if (carModel == null) {
          modelList.add(company.model!);
        }
      }
    }
    return modelList;
  }

  Future<void> fetchCarData() async {
    isLoading = true;
    update();
    try {
      final response = await fb.collection(carDataCollection).get();
      if (response.docs.isEmpty) {
        isLoading = false;
        update();
        return;
      } else {
        vehicleCompanyList.clear();
        vehicleCompanyList.add(selectedVehicleCompany);
        for (var element in response.docs) {
          //* add all data object to list
          carDataModelList.add(
            CarDataModel.fromJson(
              element.data(),
            ),
          );

          //* add company data to list first drop down
          if (vehicleCompanyList.contains(element.data()['company'])) {
            log("company already exist");
          } else {
            vehicleCompanyList.add(element.data()['company']);
          }
          // //* add model data to list
          // if (!vehicleModel.contains(element.data()['model'])) {
          //   vehicleModel.add(element.data()['model']);
          // }
        }
        isLoading = false;
        update();
      }
    } catch (e) {
      log("fetchCarData $e");
    }
  }

  Future<void> updateVehicle(VehicleModel vehicle) async {
    if (selectedVehicleModel == "اختار موديل السيارة" ||
        selectedVehicleCompany == "اختار شركة السيارة" ||
        selectedVehicleYear == "اختار سنة السيارة" ||
        carMileageController.text.isEmpty) {
      Get.snackbar("", "الرجاء ادخال جميع البيانات");
      return;
    }
    final String vId = fb.collection(usersCollection).doc().id;
    final carChassis = carChassisController.text;
    final platAlph = plateNumController.text;
    final platNum = plateAlphabetController.text;
    addCarModel = VehicleModel(
      id: vId,
      carCompany: selectedVehicleCompany,
      carModel: selectedVehicleModel,
      carPlate: platAlph.isEmpty || platNum.isEmpty
          ? null
          : CarPlateModel(
              plateNum: plateNumController.text,
              plateAlphabet: plateAlphabetController.text,
            ),
      carProductionYear: selectedVehicleYear,
      carChassisNumber: carChassis.isEmpty ? null : carChassis,
      carMileage: carMileageController.text,
    );

    //* remove old vehicle and add new one
    kUserData!.vehicle!.removeWhere((element) => element.id == vehicle.id);

    kUserData!.vehicle!.add(addCarModel!);
    try {
      await fb.collection(usersCollection).doc(kUserData!.uid).update({
        "vehicle": kUserData!.vehicle!.map((e) => e.toJson()).toList(),
      }).then((value) async {
        Get.snackbar("", "تم تعديل السيارة بنجاح", duration: 2.seconds);
        await AppDataController().fetchUserData().then((value) {
          Get.delete<AddVehicleController>();
          Get.offAll(() => const NavigationScreen());
        });
      });
    } catch (error) {
      log("addVehicle $error");
    }
  }

  Future<void> fetchAndUpdateVehicleData(VehicleModel vehicle) async {
    vehicleModel.clear();
    selectedVehicleCompany = vehicle.carCompany!;
    vehicleModel.add(vehicle.carModel!);
    for (var company in carDataModelList) {
      if (company.company == selectedVehicleCompany) {
        final carModel = vehicleModel
            .firstWhereOrNull((element) => element == company.model!);
        if (carModel == null) {
          vehicleModel.add(company.model!);
        }
      }
    }
    selectedVehicleModel = vehicle.carModel!;
    selectedVehicleYear = vehicle.carProductionYear!;
    plateNumController.text = vehicle.carPlate?.plateNum ?? "";
    plateAlphabetController.text = vehicle.carPlate?.plateAlphabet ?? "";
    carChassisController.text = vehicle.carChassisNumber ?? "";
    carMileageController.text = vehicle.carMileage!;

    update();
  }

  @override
  void onInit() {
    fetchCarData();
    getYearsList();
    super.onInit();
  }

  @override
  void onClose() {
    plateNumController.dispose();
    plateAlphabetController.dispose();
    carChassisController.dispose();
    carMileageController.dispose();
    super.onClose();
  }
}
