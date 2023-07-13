import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_aplication/presentation/pages/menu/account_pages/alert_dialog/account_alert_dialog_controller.dart';
import 'package:get/get.dart';

import '../account_settings_pages/account_page_controller.dart';

class AccountAlertDialog extends StatelessWidget {
  final AccountPageController accountPageController = Get.find();
  final String initialText;
  final String firestoreDataToChange;

  AccountAlertDialog({
    required this.initialText,
    required this.firestoreDataToChange,
  });

  void showAccountDialog(BuildContext context) {
    accountPageController.textController.text = initialText;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Your Data'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Change Data',
                  ),
                  controller: accountPageController.textController,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return AccountAlertDialogToConfirm(
                //       initialText: accountPageController.textController.text,
                //       firestoreDataToChange: firestoreDataToChange,
                //     );
                //   },
                // );
                accountPageController.changeAppUserData(firestoreDataToChange,accountPageController.textController.text);
                Navigator.of(context).pop();
              },
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        showAccountDialog(context);
      },
    );
  }
}
