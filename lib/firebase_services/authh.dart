import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fahisapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  register({
    required emailll,
    required passworddd,
    required context,
    required titleee,
    required usernameee,
    required imgName,
    required imgPath,
  }) async {
    // String message = "ERROR => Not starting the code";

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailll,
        password: passworddd,
      );

      // message = "ERROR => Registered only";

// ______________________________________________________________________

      // String urlll = await getImgURL(imgName: imgName, imgPath: imgPath);

// _______________________________________________________________________
// firebase firestore (Database)
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');

      UserData userr = UserData(
        email: emailll,

        uid: credential.user!.uid,
        vehicle: [], name: usernameee, address: 'Address', phone: "",
        // uid: credential.user!.uid,
      );

      users
          .doc(credential.user!.uid)
          .set(userr.toJson())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      // message = " Registered & User Added 2 DB ♥";
    } catch (e) {
      print(e);
    }
  }

  // functoin to get user details from Firestore (Database)
  getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return UserData.fromJson(snap.data() as Map<String, dynamic>, snap.id);
  }
}
