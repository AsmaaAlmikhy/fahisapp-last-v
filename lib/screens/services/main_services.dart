import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sub_service.dart';
import 'widgets/service_continer.dart';

class MainServices extends StatefulWidget {
  const MainServices({
    Key? key,
  }) : super(key: key);
  //final Services food;

  @override
  State<MainServices> createState() => _MainServicesState();
}

class _MainServicesState extends State<MainServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 230, 163, 109), // elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "الخدمات",
          //  ${allDataFromDB!.Name}

          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Get.to(
                  () => const SubServices(
                    serviceId: 0,
                  ),
                );
              },
              child: const ServicesContainer(
                textService: "الخدمات على أساس المدة",
                imageTextService: 'images/reward.png',
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => const SubServices(
                    serviceId: 1,
                  ),
                );
              },
              child: const ServicesContainer(
                textService: "الخدمات على أساس الأميال",
                imageTextService: 'images/reward.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
