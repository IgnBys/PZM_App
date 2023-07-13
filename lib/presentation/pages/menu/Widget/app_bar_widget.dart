import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  final String currentPage;
  final VoidCallback onLogoutPressed;

  AppBarWidget({required this.currentPage, required this.onLogoutPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$currentPage'),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: onLogoutPressed,
        ),
      ],
    );
  }
}
