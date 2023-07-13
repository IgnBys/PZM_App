import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/app_firebase_info_repository.dart';

class CheckAppValuesUsecase{
  final AppFirebaseInfoRepository _repository;
  CheckAppValuesUsecase(this._repository);
  Future<List<dynamic>> execute(order) {
    return  _repository.checkAppValues(order);
  }
}
