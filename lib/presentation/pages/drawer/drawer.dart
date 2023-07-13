import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/data/repositories/app_firebase_auth_repository_impl.dart';

import '../menu/account_pages/account_settings_pages/account_page_controller.dart';

class MainDrawer extends StatefulWidget {
  // MainDrawer(ListView listView);

  // Drawer({required Key key}) : super (key: key);
  State<MainDrawer> createState() => _MainDrawer();
}

class _MainDrawer extends State<MainDrawer> {
  final AccountPageController accountPageController = Get.find();


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print('-------------THIS IS MY PICTURE---------');
    // print(accountPageController.userPicture.value);
    return Drawer(
      child:Obx(() =>ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/HomePage');
            },
            child: UserAccountsDrawerHeader(
              accountName: Text('Hello'),
              accountEmail: Text('${accountPageController.userNickname.value}'),
              // currentAccountPicture: CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       '${accountPageController.userPicture.value}'),
              // ),

              otherAccountsPictures: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/AccountPage');
                  },
                  child: Icon(Icons.settings),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/UsersPage');
            },
            child: ListTile(
              title: Text('Users'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/OrdersPage');
            },
            child: ListTile(
              title: Text('Orders'),
            ),
          ),
        ],
      ), )
    );
  }
}
