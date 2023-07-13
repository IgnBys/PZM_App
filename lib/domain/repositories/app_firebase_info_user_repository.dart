import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


abstract class AppFirebaseInfoUserRepository {
  Future<List<String>>  getUserData();
  Future<void> changeAppUserData(String firestoreData,String data,String currentPassword);
  // Future<void> saveImage(String selectedImage);

}