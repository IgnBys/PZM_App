import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/data/repositories/app_firebase_info_user_repository_impl.dart';

import '../../domain/repositories/app_firebase_auth_repository.dart';
import '../../main.dart';

class AppFirebaseAuthRepositoryImpl extends AppFirebaseAuthRepository {
  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('items');

  Future signIn(String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> signUp(String email, String password, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      // Получите текущего пользователя Firebase
      final currentUser = FirebaseAuth.instance.currentUser;

      // Добавьте документ пользователя в Firestore
      if (currentUser != null) {
        final userId = currentUser.uid;
        final firestoreRepository = AppFirebaseInfoUserRepositoryImpl();
        await firestoreRepository.addUserDocument(userId, email, password);
      }
    } on FirebaseAuthException catch (e) {
      print('mistake');
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

}
