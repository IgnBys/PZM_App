import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/data/repositories/app_firebase_auth_repository_impl.dart';

import '../../../main.dart';

class LogInPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LogInPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebaseRepositoryImpl = AppFirebaseAuthRepositoryImpl();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('I AM HEREEEEEEEEEEEEEEEEEEEEEEE');
    return Scaffold(
        appBar: AppBar(
          title: const Text('LogInScreen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: 'Enter your name'),
            ),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
              obscureText: true,
//You can put it into another directory or file
            ),
            ElevatedButton(
              onPressed: () {
                // FirebaseAuth.instance.signOut();
                firebaseRepositoryImpl.signIn(emailController.text.trim(),
                    passwordController.text.trim(), context);
                emailController.clear();
                passwordController.clear();
                print('LOGGED IN------------------------');
                Navigator.pushReplacementNamed(context, '/HomePage');
              },
              child: Text('Log In'),
            ),
            SizedBox(
              height: 24,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 15),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignUp,
                    text: 'Sign Up',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),

            // Text('Dont have an accout?'),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, '/SignUpPage');
            //     },
            //     child: Text('Sign up'))
          ],
        ));
  }
}
