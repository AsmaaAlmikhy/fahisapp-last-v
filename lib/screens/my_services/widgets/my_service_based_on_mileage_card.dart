import 'package:fahisapp/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/add_data_controller.dart';

class MyServicesMileageCard extends StatefulWidget {
  final ServiceModel vehicleServices;
  const MyServicesMileageCard({super.key, required this.vehicleServices});

  @override
  State<MyServicesMileageCard> createState() => _MyServicesMileageCardState();
}

class _MyServicesMileageCardState extends State<MyServicesMileageCard> {
  late ServiceModel vehicleServices = widget.vehicleServices;

  bool isExpanded = false;

  double getValue() {
    final mileage = double.tryParse(
      vehicleServices.mileage!
          .substring(0, vehicleServices.mileage!.length - 1),
    );
    final mileagePassed = double.tryParse(vehicleServices.mileagePassed!);

    return (mileagePassed! / mileage!);
  }

  double normalizer(int min, int max, int value) {
    return (value - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final mileagePassed = (double.parse(vehicleServices.mileagePassed!) / 1000)
        .toStringAsFixed(0);
    final normalizedValue = normalizer(0, 1000, getValue().toInt());

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
                    value: normalizedValue,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xffFFC107),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "$mileagePassed/${vehicleServices.mileage}",
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
