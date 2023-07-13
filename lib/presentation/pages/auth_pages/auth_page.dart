import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/presentation/pages/auth_pages/sign_up_page.dart';
import 'package:flutter_aplication/presentation/pages/auth_pages/log_in_page.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/data/repositories/app_firebase_auth_repository_impl.dart';

import '../../../main.dart';


class AuthPage extends StatefulWidget {
  _AuthPageState createState() => _AuthPageState();
}



class _AuthPageState extends State<AuthPage> {
 bool isLogin = true;

  @override
  Widget build(BuildContext context)  => isLogin
      ? LogInPage(onClickedSignUp: toggle)
      : SignUpPage(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);



}
