import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_aplication/data/repositories/app_firebase_auth_repository_impl.dart';
import 'package:get/get.dart';

import 'orders_page_controller.dart';

class OrdersAlertDialog extends StatelessWidget {

  final OrdersPageController ordersPageController = Get.find();

  void showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('WriteData'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'orderNumber',
                  ),
                  controller: ordersPageController.textController1,
                ),
                SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'typeOfOrder',
                  ),
                  controller: ordersPageController.textController2,
                ),
                SizedBox(height: 15),

                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'adress',
                  ),
                  controller: ordersPageController.textController3,
                ),
                SizedBox(height: 15),

                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'counterStatus',
                  ),
                  controller: ordersPageController.textController4,
                ),
              ],
            ),
          ),


          actions: [
            ElevatedButton(
              onPressed: () {
                // settingsPageController.addNicknameList();
                ordersPageController.addOrderList();
                // FirebaseFirestore.instance.collection('items').add({'item': settingsPageController.textController1.text});
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showSettingsDialog(context);
      },
      child: Icon(Icons.add_box, color: Colors.white),
    );
  }
}
