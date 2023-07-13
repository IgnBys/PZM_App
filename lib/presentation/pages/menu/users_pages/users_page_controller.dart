import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/domain/usescases/remove_app_order_usecase.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/usescases/order_usecases/add_app_order_usecase.dart';
import '../../../../domain/usescases/order_usecases/change_app_order_status_usecase.dart';
import '../../../../domain/usescases/order_usecases/check_app_values_usecase.dart';
import '../../../../domain/usescases/order_usecases/get_app_all_orders_usecase.dart';
import '../../../../domain/usescases/order_usecases/get_app_today_orders_usecase.dart';
import '../../../../domain/usescases/users_page_usecases/get_app_all_users_usecase.dart';

class UsersPageController extends GetxController
    with SingleGetTickerProviderMixin {
  // GetAppAllUsersUsecase getAppAllUsersUsecase;
  //
  // UsersPageController({
  //       required this.getAppAllUsersUsecase,
  //     });

  checkValues(order) {
    final oderNumber = order['oderNumber'] ??
        'N/A'; // Проверка на null и установка значения по умолчанию
    final typeOfOrder = order['typeOfOrder'] ?? 'N/A';
    final adress = order['adress'] ?? 'N/A';
    final counterStatus = order['counterStatus'] ?? 'N/A';
    final date = order['date'];

    String formattedDate = 'N/A';
    if (date != null && date is Timestamp) {
      DateTime dateTime = date.toDate();
      formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }
    return [oderNumber, typeOfOrder, adress, counterStatus, formattedDate];
  }


  Future<List<String>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    var userId = user!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final userDataRef = userRef.collection('userData');

    final querySnapshot = await userDataRef.limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      final userDataDoc = querySnapshot.docs.first;
      final userData = userDataDoc.data();
      final email = userData['email'];
      final nickname = userData['nickname'];
      final telefonNumber = userData['telefonNumber'];
      final password = userData['password'];

      // Используйте значения полей по вашему усмотрению
      print('Email: $email');
      print('Nickname: $nickname');
      print('Phone Number: $telefonNumber');
      print('Password: $password');

      return [email, nickname, telefonNumber, password];
    } else {
      // Возвращаем пустой список или выполняем нужные действия в случае отсутствия данных
      return [];
    }
  }

  Stream<List<Map<String, dynamic>>> fetchDataFromFirestore() {
    final StreamController<List<Map<String, dynamic>>> streamController =
    StreamController<List<Map<String, dynamic>>>();

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        final List<Map<String, dynamic>> userDataList = [];

        for (final QueryDocumentSnapshot documentSnapshot
        in querySnapshot.docs) {
          final String documentId = documentSnapshot.id;



          final DocumentSnapshot userDataSnapshot = (await FirebaseFirestore
              .instance
              .collection('users')
              .doc(documentId)
              .collection('userData')
              .limit(1)
              .get()
              .then((QuerySnapshot querySnapshot) {
              return querySnapshot.docs.first;
          }));

          if (userDataSnapshot.exists) {
            final Map<String, dynamic>? userData = userDataSnapshot.data() as Map<String, dynamic>?;
            final List<Map<String, dynamic>?> userDataList = [];

            userDataList.add(userData);
            print('----------userDataList-----------');
            print(userDataList);
          }
        }
        streamController.add(userDataList);
      } else {
        // Коллекция users пуста
        streamController.add([]);
      }
    }).catchError((error) {
      // Обработка ошибок
      print('Ошибка при получении данных из Firestore: $error');
      streamController.addError(error);
    });

    return streamController.stream;
  }

  Stream<List<Map<String, dynamic>>> getAllOrdersFromCollection() {
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
            .map((QueryDocumentSnapshot<Object?> doc) =>
                doc.data() as Map<String, dynamic>)
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
