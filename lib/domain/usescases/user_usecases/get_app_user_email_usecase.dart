import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_aplication/domain/repositories/app_firebase_info_user_repository.dart';

import '../../repositories/app_firebase_info_repository.dart';

class GetAppUserDataUsecase{
  final AppFirebaseInfoUserRepository _repository;
  GetAppUserDataUsecase(this._repository);
  Future<List<String>>  execute() {
    return  _repository.getUserData();
  }
}
