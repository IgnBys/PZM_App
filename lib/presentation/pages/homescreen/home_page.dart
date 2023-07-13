import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/presentation/pages/menu/account_pages/account_settings_pages/account_page_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/presentation/pages/drawer/drawer.dart';

class HomePage extends StatelessWidget {
  TextEditingController textController = TextEditingController();
  final AccountPageController accountPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    var addedNickname;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/LogInPage');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Obx(() =>
            //     Image.network(
            //   // '${accountPageController.userHomePicture.value}',
            //   // '',
            //   'https://foto.scigacz.pl/gallery/sport/motocross/Nowy_regulamin_w_motocrossie_stanowisko_dzialaczy/logo_pzm_nowy_regulamin_mistrzostw_polski_w_motocrossie.jpg',
            //   width: 200,
            //   height: 200,
            // ),
      // ),
            SizedBox(height: 20),
            Text(
              "Welcome to PZM APP\nLet's go to make orders",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
