import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/my_service_based_on_duration_card.dart';
import 'widgets/my_service_based_on_mileage_card.dart';

class CurrentServices extends StatelessWidget {
  const CurrentServices({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDataController>(
      init: AppDataController(),
      builder: (_) {
        final durationServicers = _.allMyServices!
            .where(
              (element) =>
                  (element.isPassed == false || element.isPassed == null) &&
                  (element.mileage == null || element.mileagePassed == null),
            )
            .toList();

        final mileageServicers = _.allMyServices!.where((element) {
          if (element.mileage != null && element.mileagePassed != null) {
            double? mileage = double.tryParse(
                  element.mileage!.substring(0, element.mileage!.length - 1),
                )! *
                1000;
            double? mileagePassed = double.tryParse(element.mileagePassed!);

            if (mileagePassed != null) {
              if (mileagePassed < mileage) {
                return true;
              } else {
                return false;
              }
            } else {
              return false;
            }
          } else {
            return false;
          }
        }).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              if (durationServicers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("الخدمات القادمة بناء على المدة"),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: durationServicers.length,
                        itemBuilder: (context, index) {
                          return MyServicesDurationCard(
                            vehicleServices: durationServicers[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              if (mileageServicers.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("الخدمات القادمة بناء على المسافه"),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mileageServicers.length,
                        itemBuilder: (context, index) {
                          return MyServicesMileageCard(
                            vehicleServices: mileageServicers[index],
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
