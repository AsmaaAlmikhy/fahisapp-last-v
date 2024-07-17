import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetNoti_Firebase extends StatelessWidget {
  final String documentId;

  const GetNoti_Firebase({Key? key, required this.documentId}) : super(key: key);

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
          return Column(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                " ${data['name']} : الاسم",
                style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${data['content']} : المحتوى ",
                style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                " ${data['date']} : التاريخ ",
                style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        }
        return const Text("loading");
      },
    );
  }
}
