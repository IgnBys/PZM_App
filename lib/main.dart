import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication/app/util/dependency_creator.dart';
import 'package:get/get.dart';
import 'package:flutter_aplication/app/config/routes.dart';
import 'package:get_storage/get_storage.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await GetStorage.init();

  DependencyCreator.init();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Named Routes Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)
      ),
      initialRoute: '/MainPage',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: AppRouter,
    );
  }
}
