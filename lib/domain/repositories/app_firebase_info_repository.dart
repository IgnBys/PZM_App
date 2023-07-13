import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


abstract class AppFirebaseInfoRepository {

  Future addAppOrder(String orderNumber, String typeOfOrder, String adress, String counterStatus, String status);
  Stream<List<Map<String, dynamic>>> getAllOrdersFromCollection();
  Stream<List<Map<String, dynamic>>>getTodayOrdersFromCollection();
  Future removeAppOrder(String nameOfOrder);
  Future<List<Map<String, dynamic>>>changeAppOrderStatus(order);
  Future<List<dynamic>>checkAppValues(order);
// Future addDataToNameCollection(String email);



}