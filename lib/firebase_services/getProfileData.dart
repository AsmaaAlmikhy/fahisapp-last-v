import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Read_Data extends StatelessWidget {
  final String documentId;

  const Read_Data({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String uName = data['name'] ?? data['Name'];

          return Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                " $uName : الاسم",
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${data['Email']} : الايميل ",
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                " ${data['Adress']} : العنوان ",
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                " ${data['PhoneNo']} : رقم الجوال ",
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          );
        }

        return const Text("loading");
      },
    );
  }
}
