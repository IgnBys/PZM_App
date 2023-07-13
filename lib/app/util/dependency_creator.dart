import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/repositories/app_firebase_auth_repository_impl.dart';
import '../../data/repositories/app_firebase_info_repository_impl.dart';
import '../../data/repositories/app_firebase_info_user_repository_impl.dart';
import '../../domain/repositories/app_firebase_auth_repository.dart';
import '../../domain/repositories/app_firebase_info_repository.dart';
import '../../domain/repositories/app_firebase_info_user_repository.dart';

class DependencyCreator {
  static init(){
    Get.put<AppFirebaseAuthRepository>(AppFirebaseAuthRepositoryImpl());
    Get.put<AppFirebaseInfoRepository>(AppFirebaseInfoRepositoryImpl());
    Get.put<AppFirebaseInfoUserRepository>(AppFirebaseInfoUserRepositoryImpl());

  }
}