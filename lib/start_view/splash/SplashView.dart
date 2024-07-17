import 'package:fahisapp/start_view/splash/Splashbody.dart';
import 'package:flutter/material.dart';
//import 'package:fruits_market/core/constants.dart';


class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SplashViewBody(),
    );
  }
}
