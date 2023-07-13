import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/app_firebase_info_repository.dart';

class GetAppAllOrdersUsecase{
  final AppFirebaseInfoRepository _repository;
  GetAppAllOrdersUsecase(this._repository);
  Stream<List<Map<String, dynamic>>>execute() {
    return  _repository.getAllOrdersFromCollection();
  }
}
