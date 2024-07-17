import 'dart:developer';

import 'package:fahisapp/global/global.dart';
import 'package:fahisapp/widgets/CarCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_data_controller.dart';
// import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return GetBuilder<AppDataController>(
      builder: (_) {
        return SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  Image.asset(
                    "images/fahis_logo.png",
                  )
                ],
                backgroundColor: Colors.transparent,
                // elevation: 1,
                toolbarHeight: 80,
                title: Row(
                  children: [
                    const Text(
                      "مرحبًا",
                      //  ${allDataFromDB!.Name}

                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      kUserData?.name ?? "",
                      //  ${allDataFromDB!.Name}

                      style: const TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ],
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
              // floatingActionButton: BtmNavBar(),
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                    alignment: AlignmentDirectional.topStart,
                    child: const Text(
                      "مركباتي",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (kUserData?.vehicle != null &&
                      kUserData!.vehicle!.isNotEmpty)
                    Expanded(
                      // Wrap the ListView with Expanded
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          // print(userData['vehicle'][0].companyName);
                          double percent =
                              kUserData!.vehicle![index].services == null
                                  ? 0
                                  : kUserData!.vehicle![index].services!.length
                                      .toDouble();

                          final imageUrl = kUserData?.vehicle?[index].imageUrl;
                          log("message: $imageUrl");
                          return CarCardTest(
                            key: ValueKey(kUserData?.vehicle?[index].id),
                            vehicleModel: kUserData!.vehicle![index],
                            percent: percent,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: kUserData!.vehicle!.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
