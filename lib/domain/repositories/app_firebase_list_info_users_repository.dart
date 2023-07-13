import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


abstract class AppFirebaseListInfoUsersRepository {
  Stream<List<Map<String, dynamic>>> getAppAllUsers();


}