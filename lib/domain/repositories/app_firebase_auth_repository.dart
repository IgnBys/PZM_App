import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


abstract class AppFirebaseAuthRepository {
  Future signIn (String email, String password, BuildContext context);
  Future<void> signUp(String email, String password, BuildContext context);
  // Future addDataToNameCollection(String email);



}