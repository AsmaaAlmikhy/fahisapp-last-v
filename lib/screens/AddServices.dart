import 'package:fahisapp/controllers/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddServices extends StatelessWidget {
  const AddServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDataController>(
      init: AppDataController(),
      builder: (_) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 236, 142, 54),
                    Color.fromARGB(255, 233, 195, 166),
                    Color.fromARGB(255, 240, 229, 221)
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                //  textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  //Image.asset('images/login.png' )

                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    " إضافة الخدمة ",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      //  textDirection: TextDirection.rtl,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController(
                              text: _.selectedService?.name ?? "",
                            ),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              //  hintTextDirection: TextDirection.rtl,
                              labelText: "اسم الخدمة",

                              suffixIcon: Icon(
                                Icons.car_rental,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _.selectedService?.duration != null
                            ? SizedBox(
                                width: 250,
                                child: Center(
                                  child: TextField(
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    controller: _
                                        .lastTimeCheck, //editing controller of this TextField
                                    decoration: const InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                      ), //icon of text field
                                      hintText: "تاريخ اخر تغيير",
                                      //label text of field
                                    ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: _.onChangeCheckTime,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 250,
                                child: TextField(
                                  controller: _.lastMileageReached,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: const InputDecoration(
                                    //  hintTextDirection: TextDirection.rtl,
                                    labelText: " المسافة المقطوعة بالكيلومتر",

                                    suffixIcon: Icon(
                                      Icons.more_time_rounded,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _.addServiceToVehicle,
                          child: Container(
                            alignment: Alignment.center,
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.orange,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                ' إضافة الخدمة  ',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
