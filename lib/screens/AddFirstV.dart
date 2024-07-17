import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AddVehicle.dart';

class FirstAdd extends StatelessWidget {
  const FirstAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.bottomRight,
          color: const Color.fromARGB(255, 248, 248, 248),
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(40, 30, 20, 0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'اضافة مركبة',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Text(
                  'نصيحة: قم بتحديث الكيلومترات الخاصة بك بشكل متكرر للحصول على تذكير دقيق بالخدمة',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 146, 145, 145),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle button press
            Get.back();
            Get.to(() => const AddVehicle());
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
