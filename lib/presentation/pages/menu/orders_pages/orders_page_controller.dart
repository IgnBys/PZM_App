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

class OrdersPageController extends GetxController with SingleGetTickerProviderMixin {
  AddAppOrderUsecase addAppOrderUsecase;
  GetAppAllOrdersUsecase getAppAllOrdersUsecase;
  GetAppTodayOrdersUsecase getAppTodayOrdersUsecase;
  RemoveAppOrderUsecase removeAppOrderUsecase;
  ChangeAppOrderStatusUsecase changeAppOrderStatusUsecase;
  CheckAppValuesUsecase checkAppValuesUsecase;

  OrdersPageController(
      {required this.addAppOrderUsecase,
      required this.getAppAllOrdersUsecase,
        required this.getAppTodayOrdersUsecase,
      required this.removeAppOrderUsecase,
      required this.changeAppOrderStatusUsecase,
      required this.checkAppValuesUsecase
      });

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();
  final textController4 = TextEditingController();

  RxList<List<Map<String, dynamic>> >appAllOrdersList = RxList(<List<Map<String, dynamic>>>[].obs);
  RxList<List<Map<String, dynamic>> >appTodayOrdersList = RxList(<List<Map<String, dynamic>>>[].obs);

  // Stream<List<String>> appOrdersStream = <String>[].obs as Stream<List<String>>;
  RxList<List<dynamic>> checkAppValues = <List<dynamic>>[].obs;



  void addOrderList() async {
    await addAppOrderUsecase.execute(textController1.text, textController2.text,
        textController3.text, textController4.text, 'false');
    textController1.clear();
    textController2.clear();
    textController3.clear();
    textController4.clear();
  }

  // Future<List<dynamic>> checkValues(dynamic order) async {
  //   List<dynamic> orderValues = await checkAppValuesUsecase.execute(order);
  //   var orderNumber = orderValues[0];
  //   var typeOfOrder = orderValues[1];
  //   var address = orderValues[2];
  //   var counterStatus = orderValues[3];
  //   var date = orderValues[4];
  //   print('===============qqqqqqqqqqqqqqqqqqqq====');
  //   print('---------orderNumber---------------');
  //   print(orderNumber);
  //   print('---------typeOfOrder---------------');
  //   print(typeOfOrder);
  //   print('---------address---------------');
  //   print(address);
  //   print('---------counterStatus---------------');
  //   print(counterStatus);
  //   print('---------date---------------');
  //   print(date);
  //   return Future.value([orderNumber, typeOfOrder, address, counterStatus, date]);
  // }




  checkValues (order) {
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
    return [oderNumber, typeOfOrder, adress, counterStatus, formattedDate];

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


  // @override
  // void onInit() async {
  //   super.onInit();
  //   final allOrders = await getAppAllOrdersUsecase.execute();
  //   final todayOrders = await getAppTodayOrdersUsecase.execute();
  //   appTodayOrdersList.addAll(todayOrders as Iterable<List<Map<String, dynamic>>>);
  //   appAllOrdersList.addAll(allOrders as Iterable<List<Map<String, dynamic>>>);
  // }



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
        print(orders);

        return orders;
      });
    } else {
      return Stream.value([]);
    }
  }





  void removeOrder(String orderName) async {
    // print(orderName);
    await removeAppOrderUsecase.execute(orderName);
  }

  void changeAppOrderStatus (order) async {
    await changeAppOrderStatusUsecase.execute(order);
  }

}
