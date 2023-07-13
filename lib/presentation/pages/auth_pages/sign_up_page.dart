import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';
import '../../../data/repositories/app_firebase_auth_repository_impl.dart';

class SignUpPage extends StatefulWidget {

  final Function() onClickedSignIn;

  const SignUpPage ({
    Key? key,
    required this.onClickedSignIn,
  }): super(key:key);
  State<SignUpPage> createState() => _SignUpPageState();

}



class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context){
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final firebaseRepositoryImpl = AppFirebaseAuthRepositoryImpl();
    // TextEditingController datePickerController = TextEditingController();
    // final appUsersInfoRepositoryImpl = AppUsersInfoRepositoryImpl();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUpPage'),

      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Enter your name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email)=>
                    email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Enter your password'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: true,
              validator: (value)=>
              value != null && value.length < 6
                  ? 'Enter min 6 characters'
                  : null,
            ),
            ElevatedButton(
                onPressed: () {
                  firebaseRepositoryImpl.signUp(emailController.text.trim(), passwordController.text.trim(),context);
                  Navigator.pushNamed(context, '/MainPage');
                },
                child: Text('Sign Up')),
            SizedBox(height: 24,),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 15),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    text: 'Log In',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

