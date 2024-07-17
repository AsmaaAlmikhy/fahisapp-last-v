// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  Future forgetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(
          email: _emailController.text.trim(),
        )
        .then(
          (value) =>
              Get.snackbar("تم الارسال بنجاح", "تم ارسال الرابط الى الايميل"),
        );
    // ignore: use_build_context_synchronously
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              const SizedBox(
                height: 80,
              ),
//Image.asset('images/login.png' )

              const SizedBox(
                height: 40,
              ),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
                color: Colors.white,
              ),
              const Text(
                " نسيت كلمة المرور ",
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
                height: 200,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //  textDirection: TextDirection.rtl,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                        ),
                        controller: _emailController,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'الايميل',
                          suffixIcon: Icon(
                            Icons.mail,
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                    //forget pass

                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: forgetPassword,
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
                            '   إرسال ',
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
  }
}
