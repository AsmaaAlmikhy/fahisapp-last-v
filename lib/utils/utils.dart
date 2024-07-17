import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';

class Utils {
  static Future<String?> loadImage(String logo) async {
    String imageUrl = "";
    try {
      imageUrl = await FirebaseStorage.instance
          .ref()
          .child('car-logos')
          .child(logo)
          .getDownloadURL();
    } catch (e) {
      log("loadImage $e");
    }
    return imageUrl;
  }
}
