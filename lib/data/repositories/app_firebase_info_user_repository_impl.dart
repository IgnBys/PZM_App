import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/app_firebase_auth_repository.dart';
import '../../domain/repositories/app_firebase_info_user_repository.dart';
import '../../main.dart';

class AppFirebaseInfoUserRepositoryImpl extends AppFirebaseInfoUserRepository {
  Future<void> addUserDocument(
      String userId, String email, String password) async {
    Map<String, dynamic> userData = {
      'email': email,
      'nickname': email.substring(0, 5),
      'telefonNumber': '',
      'password': password,
      'picture': '',
      // 'homePicture': 'https://foto.scigacz.pl/gallery/sport/motocross/Nowy_regulamin_w_motocrossie_stanowisko_dzialaczy/logo_pzm_nowy_regulamin_mistrzostw_polski_w_motocrossie.jpg',
      'ID': '',
    };
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      DocumentReference userDoc = usersCollection.doc(userId);
      CollectionReference nameCollection =
          userDoc.collection('userData'); // Использование имени коллекции

      DocumentReference docRef = await nameCollection.add(userData);
      String docId = docRef.id;
      await docRef.update({'ID': docId});
    } catch (error) {
      print('Error with adding data:  $error');
    }
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
      final picture = userData['picture'];
      // final homePicture = userData['homePicture'];

      // Используйте значения полей по вашему усмотрению
      print('Email: $email');
      print('Nickname: $nickname');
      print('Phone Number: $telefonNumber');
      print('Password: $password');

      return [email, nickname, telefonNumber, password,picture];
    } else {
      // Возвращаем пустой список или выполняем нужные действия в случае отсутствия данных
      return [];
    }
  }




  // Future<void> changeAppUserEmailOrPassword(String emailOrPassword,
  //     String newUserData, String currentPassword) async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   // String currentPassword = user.
  //   if (user != null) {
  //     try {
  //       if (emailOrPassword == 'email') {
  //         AuthCredential credential = EmailAuthProvider.credential(
  //             email: user.email!, password: currentPassword);
  //         // await user.reauthenticateWithCredential(credential);
  //         await user.reauthenticateWithCredential(credential);
  //         await user.updateEmail(newUserData);
  //       } else {
  //         AuthCredential credential = EmailAuthProvider.credential(
  //             email: user.email!, password: currentPassword);
  //         await user.reauthenticateWithCredential(credential);
  //         await user.updatePassword(newUserData);
  //       }
  //
  //       print('login was changed');
  //     } catch (e) {
  //       print('password was changed');
  //     }
  //   } else {
  //     print('Пользователь не аутентифицирован.');
  //   }
  // }

  Future<void> changeAppUserData(String firestoreData, String data, String currentPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? userEmail = user?.email;

      if (firestoreData == 'email') {
        AuthCredential credential = EmailAuthProvider.credential(
            email: userEmail!, password: currentPassword);
        await user?.reauthenticateWithCredential(credential);
        await user?.updateEmail(data);
      } else if (firestoreData == 'password'){
        AuthCredential credential = EmailAuthProvider.credential(
            email: userEmail!, password: currentPassword);
        await user?.reauthenticateWithCredential(credential);
        await user?.updatePassword(data);
      }

      String userId = user?.uid ?? '';
      QuerySnapshot userDataDocs = await FirebaseFirestore.instance
          .collection('users').doc(userId).collection('userData').get();
      DocumentSnapshot userDataDoc = userDataDocs.docs.first;
      String userDataId = userDataDoc['ID'];

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('userData')
          .doc(userDataId)
          .update({firestoreData: data});
    } catch (error) {
      print('Ошибка при обновлении данных пользователя: $error');
    }
  }

  // Future<void> changeAppUserData(
  //     String firestoreData, String data, String currentPassword) async {
  //   // Получаем текущего пользователя из Firebase Authentication
  //   User? user = FirebaseAuth.instance.currentUser;
  //
  //   if (user != null) {
  //     // Обновляем данные пользователя в Firebase Authentication
  //
  //     String userId = user?.uid ?? '';
  //     QuerySnapshot userDataDocs = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .collection('userData')
  //         .get();
  //     DocumentSnapshot userDataDoc = userDataDocs.docs.first;
  //     String userDataId = userDataDoc['ID'];
  //     // Обновляем данные в Firestore
  //     // String userId = user.uid;
  //     CollectionReference usersCollection =
  //         FirebaseFirestore.instance.collection('users');
  //     DocumentReference userDoc = usersCollection.doc(userId);
  //     CollectionReference userDataCollection = userDoc.collection('userData');
  //     DocumentSnapshot userDataSnapshot =
  //         await userDataCollection.doc(userDataId).get();
  //
  //     if (userDataSnapshot.exists) {
  //       // Обновляем поле в Firestore
  //       Map<String, dynamic> userData =
  //           userDataSnapshot.data() as Map<String, dynamic>;
  //       if (userData.containsKey(firestoreData)) {
  //         userData[firestoreData] = data;
  //         await userDataCollection.doc(userDataId).update(userData);
  //       }
  //     }
  //     if (firestoreData == 'email') {
  //       await user.updateEmail(data);
  //     } else if (firestoreData == 'password') {
  //       await user.updatePassword(data);
  //     }
  //   }
  // }
}
