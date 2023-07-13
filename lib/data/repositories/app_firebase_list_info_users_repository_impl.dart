// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Future<void> fetchDataFromFirestore() async {
//   try {
//     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .get();
//
//     if (querySnapshot.docs.isNotEmpty) {
//       final List<Map<String, dynamic>> userDataList = [];
//
//       for (final QueryDocumentSnapshot documentSnapshot
//       in querySnapshot.docs) {
//         final String documentId = documentSnapshot.id;
//
//         final DocumentSnapshot userDataSnapshot = await FirebaseFirestore
//             .instance
//             .collection('users')
//             .doc(documentId)
//             .collection('userData')
//             .doc('data')
//             .get();
//
//         if (userDataSnapshot.exists) {
//           final Map<String, dynamic> userData = userDataSnapshot.data()!;
//           userDataList.add(userData);
//         }
//       }
//
//       // Доступ к данным из userDataList
//       for (final Map<String, dynamic> userData in userDataList) {
//         final String id = userData['ID'];
//         final String email = userData['email'];
//         final String nickname = userData['nickname'];
//         final String telefonNumber = userData['telefonNumber'];
//         final String password = userData['password'];
//
//         // Дальнейшая обработка данных
//         // ...
//       }
//     } else {
//       // Коллекция users пуста
//     }
//   } catch (e) {
//     // Обработка ошибок
//     print('Ошибка при получении данных из Firestore: $e');
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/app_firebase_list_info_users_repository.dart';
import '../../main.dart';

class AppFirebaseListInfoUsersRepositoryImpl extends AppFirebaseListInfoUsersRepository {
  @override
  Stream<List<Map<String, dynamic>>> getAppAllUsers() {
    var collectionName = 'ordersData';
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName);
      // print();
      return collection.snapshots().map((QuerySnapshot<Object?> snapshot) {
        List<Map<String, dynamic>> orders = snapshot.docs
            .map((QueryDocumentSnapshot<Object?> doc) => doc.data() as Map<String, dynamic>)
            .where((order) => order['status'] == 'true')
            .toList();
        print(orders);
        return orders;
      });
    } else {
      return Stream.value([]);
    }
  }

}

