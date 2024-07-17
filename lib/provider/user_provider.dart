import 'package:fahisapp/firebase_services/authh.dart';
import 'package:flutter/material.dart';

import 'package:fahisapp/models/user.dart';

class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await AuthMethods().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
}
