import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/presentation/pages/homescreen/home_page.dart';
import 'package:get/get.dart';

import '../auth_pages/auth_page.dart';
import '../auth_pages/log_in_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError){
            return Center(child: Text('Something went wrong'));
          }
          else if (snapshot.hasData){
            print('LETS GO TO HOME PAGE!!!!!!!!!!!!!!');
            return HomePage();
          }
          else {
            print('LETS GO TO LOGIN PAGE!!!!!!!!!!!!!!');
            return AuthPage();
          }
        }
      ),

  );


}
