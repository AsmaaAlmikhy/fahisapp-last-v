import 'package:fahisapp/models/service_model.dart';
import 'package:flutter/material.dart';

class MyServicesCard extends StatelessWidget {
  final ServiceModel vehicleServices;
  const MyServicesCard({super.key, required this.vehicleServices});

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
      final nextCheckUp = DateTime.parse(vehicleServices.nextCheckup!);
      final now = DateTime.now();
      deference = now.difference(nextCheckUp).inDays;
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
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              vehicleServices.name ?? "No Name",
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Text(
              vehicleServices.carModel ?? "No Date",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              vehicleServices.nextCheckup != null
                  ? "${getDeference()}/${getValueByDays()}"
                  : vehicleServices.mileagePassed != null &&
                          vehicleServices.mileage != null
                      ? "${(double.tryParse(vehicleServices.mileagePassed!) ?? 1 / 1000).toStringAsFixed(0)}/${vehicleServices.mileage}"
                      : "No Name",
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
