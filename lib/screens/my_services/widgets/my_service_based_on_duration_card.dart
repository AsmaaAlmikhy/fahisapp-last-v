import 'dart:developer';

import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:fahisapp/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyServicesDurationCard extends StatelessWidget {
  final ServiceModel vehicleServices;
  const MyServicesDurationCard({
    super.key,
    required this.vehicleServices,
  });

  int getValueByDays() {
    int duration = 0;
    if (vehicleServices.duration != null) {
      if (vehicleServices.duration!.contains('w')) {
        duration = int.parse(
              vehicleServices.duration!
                  .substring(0, vehicleServices.duration!.length - 1),
            ) *
            7;
      } else if (vehicleServices.duration!.contains('m')) {
        duration = int.parse(
              vehicleServices.duration!
                  .substring(0, vehicleServices.duration!.length - 1),
            ) *
            30;
      } else if (vehicleServices.duration!.contains('y')) {
        duration = int.parse(
              vehicleServices.duration!
                  .substring(0, vehicleServices.duration!.length - 1),
            ) *
            365;
      }
    }
    return duration;
  }

  int getDeference() {
    int deference = 0;
    if (vehicleServices.nextCheckup != null) {
      final lastCheckUp = DateTime.parse(vehicleServices.nextCheckup!);
      final now = DateTime.now();
      deference = lastCheckUp.difference(now).inDays;
    }
    return deference;
  }

  double getAverageValue() {
    final days = getValueByDays();
    final deference = getDeference();

    return deference / days;
  }

  @override
  Widget build(BuildContext context) {
    log("getValueByDays ${getValueByDays()}");
    log("getAverageValue ${getAverageValue()}");

    final _ = Get.put(AppDataController());

    return Stack(
      children: [
        Card(
          child: ListTile(
            title: Text(
              vehicleServices.name ?? "No Name",
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    value: getAverageValue(),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xffFFC107),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${getDeference()}/${getValueByDays()}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            trailing: Text(
              vehicleServices.carModel ?? "No Name",
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
        Positioned(
          top: -18,
          left: -18,
          child: IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text("حذف الخدمة"),
                  content: Text(
                    "هل تريد حذف الخدمة؟\n${vehicleServices.name} الخاصه \nبالسيارة ${vehicleServices.carModel}",
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        await _
                            .removeServiceFromVehicle(vehicleServices)
                            .then((value) {
                          Get.back();
                        });
                        Get.snackbar(
                          "تنبيه",
                          "تم حذف الخدمة بنجاح",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      },
                      child: const Text("نعم"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("لا"),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
