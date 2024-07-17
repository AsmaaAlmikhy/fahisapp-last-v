import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:fahisapp/models/service_model.dart';
import 'package:fahisapp/screens/AddServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubServices extends StatelessWidget {
  final int serviceId;
  const SubServices({
    super.key,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 230, 163, 109), // elevation: 1,
        // elevation: 1,
        toolbarHeight: 80,

        title: Text(
          serviceId == 0
              ? "الخدمات على أساس المدة"
              : "الخدمات على أساس المسافة",
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<AppDataController>(
        init: AppDataController(),
        builder: (_) {
          List<ServiceModel>? service = serviceId == 0
              ? _.durationBasedServices()
              : _.milageBasedServices();

          List<ServiceModel>? serviceBasedOnWeek = _
              .durationBasedServices()!
              .where((element) => element.duration!.contains("w"))
              .toList();

          List<ServiceModel>? serviceBasedOnMonth = _
              .durationBasedServices()!
              .where((element) => element.duration!.contains("m"))
              .toList();

          List<ServiceModel>? serviceBasedOnYear = _
              .durationBasedServices()!
              .where((element) => element.duration!.contains("y"))
              .toList();

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (serviceBasedOnWeek.isNotEmpty && serviceId == 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("خدمات اسبوعيه"),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: serviceBasedOnWeek.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                bottom: 10,
                                right: 10,
                                left: 10,
                              ),
                              child: ListTile(
                                onTap: () {
                                  _.selectedService = serviceBasedOnWeek[index];
                                  _.lastTimeCheck.text = "";
                                  Get.to(() => const AddServices());
                                },
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        serviceBasedOnWeek[index].imageUrl!,
                                  ),
                                ),
                                title: Row(
                                  textDirection: TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        serviceBasedOnWeek[index].name ??
                                            "not given",
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "${serviceBasedOnWeek[index].duration![0]} اسبوع",
                                ),
                                trailing: const Icon(
                                  Icons.car_rental,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (serviceBasedOnMonth.isNotEmpty && serviceId == 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("خدمات شهريه"),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: serviceBasedOnMonth.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                bottom: 10,
                                right: 10,
                                left: 10,
                              ),
                              child: ListTile(
                                onTap: () {
                                  _.selectedService =
                                      serviceBasedOnMonth[index];
                                  _.lastTimeCheck.text = "";

                                  Get.to(() => const AddServices());
                                },
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        serviceBasedOnMonth[index].imageUrl!,
                                  ),
                                ),
                                title: Row(
                                  textDirection: TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        serviceBasedOnMonth[index].name ??
                                            "not given",
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "${serviceBasedOnMonth[index].duration![0]}  شهر",
                                ),
                                trailing: const Icon(
                                  Icons.car_rental,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (serviceBasedOnYear.isNotEmpty && serviceId == 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("خدمات سنويه"),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: serviceBasedOnYear.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                bottom: 10,
                                right: 10,
                                left: 10,
                              ),
                              child: ListTile(
                                onTap: () {
                                  _.selectedService = serviceBasedOnYear[index];
                                  _.lastTimeCheck.text = "";
                                  Get.to(() => const AddServices());
                                },
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.amber,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        serviceBasedOnYear[index].imageUrl!,
                                  ),
                                ),
                                title: Row(
                                  textDirection: TextDirection.ltr,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        serviceBasedOnYear[index].name ??
                                            "not given",
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "${serviceBasedOnYear[index].duration![0]}  سنه",
                                ),
                                trailing: const Icon(
                                  Icons.car_rental,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (_.milageBasedServices() != null &&
                    _.milageBasedServices()!.isNotEmpty &&
                    serviceId == 1)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _.milageBasedServices()!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          bottom: 10,
                          right: 10,
                          left: 10,
                        ),
                        child: ListTile(
                          onTap: () async {
                            _.selectedService = _.milageBasedServices()![index];
                            _.lastTimeCheck.text = "";

                            _.lastMileageReached.text =
                                _.selectedVehicle?.carMileage ?? "";
                            final response = Get.to(() => const AddServices());
                            if (response == null) {
                              _.lastTimeCheck.text = "";
                            }
                          },
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                            child: CachedNetworkImage(
                              imageUrl:
                                  _.milageBasedServices()![index].imageUrl!,
                            ),
                          ),
                          title: Row(
                            textDirection: TextDirection.ltr,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _.milageBasedServices()![index].name ??
                                      "not given",
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            (
                                    // serviceId == 0
                                    //       ? (service[index].duration!.contains("w")
                                    //           ? "${service[index].duration![0]} اسبوع"
                                    //           : service[index]
                                    //                   .duration!
                                    //                   .contains("m")
                                    //               ? "${service[index].duration![0]} شهر"
                                    //               : service[index]
                                    //                       .duration!
                                    //                       .contains("y")
                                    //                   ? "${service[index].duration![0]} سنه"
                                    //                   : service[index].duration)
                                    //       :
                                    _.milageBasedServices()![index].mileage) ??
                                "not given",
                          ),
                          trailing: const Icon(
                            Icons.car_rental,
                          ),
                        ),
                      );
                    },
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
