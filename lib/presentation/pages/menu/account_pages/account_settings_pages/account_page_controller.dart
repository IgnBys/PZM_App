import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/usescases/user_usecases/change_app_user_data_usecase.dart';
import '../../../../../domain/usescases/user_usecases/get_app_user_email_usecase.dart';


// with SingleGetTickerProviderMixin
class AccountPageController extends GetxController with SingleGetTickerProviderMixin {
  GetAppUserDataUsecase getAppUserDataUsecase;
  ChangeAppUserDataUsecase changeAppUserDataUsecase;
  // SaveSelectedImageUsacase saveSelectedImage;



  AccountPageController({required this.getAppUserDataUsecase,
  required this.changeAppUserDataUsecase,
  // required this.saveSelectedImage
  });

  final textController = TextEditingController();
  final textController2 = TextEditingController();
  // final user = FirebaseAuth.instance.currentUser!;
  // RxString userEmail = RxString('');
  RxList<String> userData = <String>[].obs;
  RxString userEmail = ''.obs;
  RxString userNickname = ''.obs;
  RxString userTelefonNumber = ''.obs;
  RxString userPassword = ''.obs;
  // RxString userPicture = ''.obs;
  // RxString userHomePicture = ''.obs;


  @override
  void onInit() async {
    super.onInit();
    final email = await getAppUserDataUsecase.execute();
    // userData.clear();
    userData.addAll(email);
    userEmail.value = userData[0];
    userNickname.value = userData[1];
    userTelefonNumber.value = userData[2];
    userPassword.value = userData[3];
    // userPicture.value = userData[4];
    // userHomePicture.value = userData[5];


    print('-------email--------');
    print(userEmail);
    print('-------nick--------');
    print(userNickname);
    print('-------tel--------');
    print(userTelefonNumber);
    print('-------password--------');
    print(userPassword.value);
    print('-------picture--------');
    // print(userPicture.value);

  }
  //


  Future<void> changeAppUserData (String firestoreData, String data) async {

    await changeAppUserDataUsecase.execute(firestoreData, data, userPassword.value);
    // textController2.clear();
    // textController.clear();
  }

  void saveSelectedImages(String selectedImage) {
    print('+++++was saved selected image--------------');
    print(selectedImage);
    // Сохраните выбранные изображения в базе данных Firebase
    // Пример кода для сохранения изображений в Firestore:
    // Firestore.instance.collection('users').document(user.uid).updateData({
    //   'selectedImages': selectedImages,
    // });
  }

}
