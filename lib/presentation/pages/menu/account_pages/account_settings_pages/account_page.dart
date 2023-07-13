import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/presentation/pages/menu/account_pages/account_settings_pages/account_page_controller.dart';
import 'package:flutter_aplication/presentation/pages/menu/account_pages/alert_dialog/account_alert_dialog.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final AccountPageController accountPageController = Get.find();
  final User? user = FirebaseAuth.instance.currentUser;

  List<String> selectedImages = []; // Добавьте список для выбранных изображений


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),
      body: Stack(
        children: [
          Center(
            child: Text('Your content goes here'),
          ),
          Align(
            alignment: FractionalOffset.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 180.0),
              child: Obx(
                    () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('email:'),
                            Text('${accountPageController.userEmail.value}'),
                            AccountAlertDialog(
                              initialText: '${accountPageController.userEmail.value}',
                              firestoreDataToChange: 'email',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('nickname:'),
                            Text('${accountPageController.userNickname.value}'),
                            AccountAlertDialog(
                              initialText: '${accountPageController.userNickname.value}',
                              firestoreDataToChange: 'nickname',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('telefonNumber:'),
                            Text('${accountPageController.userTelefonNumber.value}'),
                            AccountAlertDialog(
                              initialText: '${accountPageController.userTelefonNumber.value}',
                              firestoreDataToChange: 'telefonNumber',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('password:'),
                            Text('${accountPageController.userPassword.value}'),
                            AccountAlertDialog(
                              initialText: '${accountPageController.userPassword.value}',
                              firestoreDataToChange: 'password',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, 'PicturePage');
              },
              child: Icon(Icons.edit),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Obx(() => Padding(
          //     padding: EdgeInsets.only(bottom: 420.0),
          //     child: accountPageController.userPicture.value.isNotEmpty
          //         ? Image.network(
          //       accountPageController.userPicture.value,
          //       width: 180,
          //       height: 180,
          //       fit: BoxFit.contain,
          //     )
          //         : Container(),
          //   )
          //     ),
          // ),
        ],
      ),
    );
  }
}
