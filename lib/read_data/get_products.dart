import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetProduct extends StatelessWidget {
  final String documentID;

  GetProduct({required this.documentID});

  @override
  Widget build(BuildContext context) {
    //get collection

    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    return FutureBuilder<DocumentSnapshot>(
        future: products.doc(documentID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              '${data['productName']}' + '\nRp ' + '${data['price']}',
              style: const TextStyle(
                fontSize: 14,
              ),
            );
          }
          return const Text('No data');
        });
  }
}
