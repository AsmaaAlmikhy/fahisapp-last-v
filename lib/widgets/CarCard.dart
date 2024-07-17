import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:fahisapp/controllers/add_vehicle_controller.dart';
import 'package:fahisapp/models/add_car_model.dart';
import 'package:fahisapp/screens/VehicleDetails.dart';
import 'package:fahisapp/widgets/DeleteDropDown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../screens/services/main_services.dart';

//import 'package:percent_indicator/circular_percent_indicator.dart';

//import 'DeleteDropDown.dart';

class CarCardTest extends StatelessWidget {
  final VehicleModel vehicleModel;
  final double percent;
  const CarCardTest({
    Key? key,
    required this.percent,
    required this.vehicleModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.97,
      child: Container(
        height: 370,
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Positioned(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xA6F2CDAD),
                        Color(0x4DF9D4B7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 350,
                  height: 300,
                ),
              ),
            ),
            Positioned(
              bottom: 215,
              left: 30,
              child: Text(
                vehicleModel.carCompany ?? '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              bottom: 245,
              left: 30,
              child: Text(
                vehicleModel.carModel ?? '',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: 0,
              left: 0,
              child: CachedNetworkImage(
                imageUrl: vehicleModel.imageUrl ?? "",
                width: 30,
                height: 100,
                placeholder: (context, url) => const SizedBox(
                  width: 50,
                  child: LinearProgressIndicator(
                    color: Colors.orange,
                    backgroundColor: Color(0xffFFB775),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 45,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0x33FEC163),
                      Color(0xBFDE4313),
                    ],
                  ),
                ),
                height: 40,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 253, 229, 216),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  onPressed: () async {
                    final _ = Get.put(AddVehicleController());
                    _
                        .fetchAndUpdateVehicleData(vehicleModel)
                        .then((value) async {
                      final x = await Get.to(
                        () => VehicleDetails(
                          selectedVehicle: vehicleModel,
                        ),
                      );
                      log("xx $x");
                      if (x == null) {
                        Get.delete<AddVehicleController>();
                      }
                    });
                  },
                  child: const Text(
                    "التفاصيل",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 45,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0x33FEC163),
                      Color(0xBFDE4313),
                    ],
                  ),
                ),
                height: 40,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 253, 229, 216),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  onPressed: () {
                    final appDataController = Get.find<AppDataController>();
                    appDataController.selectedVehicle = vehicleModel;
                    Get.to(
                      () => const MainServices(),
                    );
                  },
                  child: const Text(
                    "الخدمات",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            if (vehicleModel.carPlate != null)
              Positioned(
                bottom: 160,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(31, 130, 66, 66),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                  ),
                  child: Text(
                    "${vehicleModel.carPlate?.plateNum ?? ""}-${vehicleModel.carPlate?.plateAlphabet?.toUpperCase() ?? ""}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: 70,
              right: 30,
              // ignore: unnecessary_new
              child: new CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 11.0,
                animation: true,
                percent: ((percent > 33 ? 33 : percent) / 33) < 0
                    ? 0
                    : ((percent > 33 ? 33 : percent) / 33),
                center: Text(
                  "${((percent > 33 ? 33 : percent / 33) * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: const Color(0xBF854B3A),
              ),
            ),
            Positioned(
              top: 30,
              right: 10,
              child: GetBuilder<AppDataController>(
                init: AppDataController(),
                builder: (_) {
                  return DropDownMenuFb1(
                    menuList: [
                      PopupMenuItem(
                        onTap: () => _.deleteVehicle(vehicleModel),
                        child: const ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 243, 55, 45),
                          ),
                          title: Text('حذف'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
