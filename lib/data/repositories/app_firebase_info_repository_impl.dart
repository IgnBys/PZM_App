import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/repositories/app_firebase_info_repository.dart';
import '../../main.dart';

class AppFirebaseInfoRepositoryImpl extends AppFirebaseInfoRepository {
  @override
  Future<void> addAppOrder(String orderNumber, String typeOfOrder,
      String adress, String counterStatus, String status) async {
    User? user = FirebaseAuth.instance.currentUser;
    // int age = 23;

    if (user != null) {
      String userId = user.uid;
      String collectionName =
          'ordersData'; // Получение первых 5 символов из email для имени коллекции

      // Данные для добавления в коллекцию name
      Map<String, dynamic> nameData = {
        'oderNumber': orderNumber,
        'typeOfOrder': typeOfOrder,
        'adress': adress,
        'counterStatus': counterStatus,
        'date': DateTime.now(),
        'status': status,
        'ID': null,
        // Другие поля
      };

      try {
        CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
        DocumentReference userDoc = usersCollection.doc(userId);
        CollectionReference nameCollection = userDoc.collection(collectionName); // Использование имени коллекции

        DocumentReference docRef = await nameCollection.add(nameData);
        String docId = docRef.id;
        await docRef.update({'ID': docId});
        print('Data was added to the collection name: $collectionName.');
      } catch (error) {
        print('Error with adding data:  $error');
      }
    }
  }

  Future<List<dynamic>> checkAppValues (order) {
    final oderNumber = order['oderNumber'] ??
        'N/A'; // Проверка на null и установка значения по умолчанию
    final typeOfOrder = order['typeOfOrder'] ??
        'N/A';
    final adress = order['adress'] ??
        'N/A';
    final counterStatus = order['counterStatus'] ??
        'N/A';
    final date = order['date'];

    String formattedDate = 'N/A';
    if (date != null && date is Timestamp) {
      DateTime dateTime = date.toDate();
      formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    }
    print('---------CHECKED VALUES---------------');
    print('---------orderNumber---------------');
    print(oderNumber);
    print('---------typeOfOrder---------------');
    print(typeOfOrder);
    print('---------address---------------');
    print(adress);
    print('---------counterStatus---------------');
    print(counterStatus);
    print('---------date---------------');
    print(date);
    return Future.value([oderNumber, typeOfOrder, adress, counterStatus, formattedDate]);

  }

  @override
  Future removeAppOrder(String nameOfOrder) async {
    print(nameOfOrder);
    await FirebaseFirestore.instance
        .collection('items')
        .doc(nameOfOrder)
        .delete();

    // throw UnimplementedError();
  }


  Future<List<Map<String, dynamic>>> changeAppOrderStatus(dynamic order) async {
    User? user = FirebaseAuth.instance.currentUser;

    try {
      final orderId = order['ID'];

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('ordersData')
          .doc(orderId)
          .update({'status': 'true'});

      print('Статус заказа обновлен.');

      // Возвращаем список результатов (в данном случае содержащий один элемент)
      return [order];
    } catch (error) {
      print('Ошибка при обновлении статуса заказа: $error');
      return []; // Возвращаем пустой список в случае ошибки
    }
  }




  Stream<List<Map<String, dynamic>>> getAllOrdersFromCollection() {
    var collectionName = 'ordersData';
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName);

      return collection.snapshots().map((QuerySnapshot<Object?> snapshot) {
        List<Map<String, dynamic>> orders = snapshot.docs
            .map((QueryDocumentSnapshot<Object?> doc) => doc.data() as Map<String, dynamic>)
            .where((order) => order['status'] == 'true')
            .toList();

        return orders;
      });
    } else {
      return Stream.value([]);
    }
  }

  Stream<List<Map<String, dynamic>>> getTodayOrdersFromCollection() {
    var collectionName = 'ordersData';
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection(collectionName);

      return collection.snapshots().map((QuerySnapshot<Object?> snapshot) {
        List<Map<String, dynamic>> orders = snapshot.docs
            .map((QueryDocumentSnapshot<Object?> doc) => doc.data() as Map<String, dynamic>)
            .where((order) => order['status'] == 'false')
            .toList();

        return orders;
      });
    } else {
      return Stream.value([]);
    }
  }
}


