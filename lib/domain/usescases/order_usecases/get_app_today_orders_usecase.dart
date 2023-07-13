import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/app_firebase_info_repository.dart';

class GetAppTodayOrdersUsecase{
  final AppFirebaseInfoRepository _repository;
  GetAppTodayOrdersUsecase(this._repository);
  Stream<List<Map<String, dynamic>>> execute() {
    return  _repository.getTodayOrdersFromCollection();
  }
}
