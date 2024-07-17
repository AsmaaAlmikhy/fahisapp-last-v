// ignore: depend_on_referenced_packages
import 'package:fahisapp/screens/SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../responsive/Mobile_Screen.dart';
import '../start_view/splash/SplashView.dart';
import 'forget_password.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  Future signIn() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        )
        .then(
          (value) => Get.offAll(
            () => const SplashView(),
          ),
        );
    // ignore: use_build_context_synchronously
  }

  void openSignupScreen() {
    Get.to(() => const NavigationScreen());
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
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
                "تسجيل الدخول",
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
                height: 400,
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
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                        ),
                        controller: _passController,
                        obscureText: true,
                        textDirection: TextDirection.rtl,
                        decoration: const InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'الرقم السري',
                          suffixIcon: Icon(
                            Icons.lock,
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                    //forget pass

                    InkWell(
                      onTap: () {
                        Get.to(() => const ForgetPassword());
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '   هل نسيت كلمة المرور ؟ ',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.orangeAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: signIn,
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
                            'تسجيل الدخول ',
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

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SignupScreen());
                            },
                            child: const Text(
                              '   التسجيل ',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Text(
                            ' لاتملك حساب ؟',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.orangeAccent,
                            ),
                          ),
                        ],
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
