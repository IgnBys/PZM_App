import 'package:flutter_aplication/domain/repositories/app_firebase_info_user_repository.dart';

import '../../repositories/app_firebase_info_repository.dart';

class ChangeAppUserDataUsecase{
  final AppFirebaseInfoUserRepository _repository;
  ChangeAppUserDataUsecase(this._repository);
  Future<void> execute(String firestoreData,String data,String currentPassword) async {
    return await _repository.changeAppUserData(firestoreData, data, currentPassword);
  }
}