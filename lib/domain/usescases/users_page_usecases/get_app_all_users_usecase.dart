import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/app_firebase_list_info_users_repository.dart';


class GetAppAllUsersUsecase{
  final AppFirebaseListInfoUsersRepository _repository;
  GetAppAllUsersUsecase(this._repository);
  Stream<List<Map<String, dynamic>>>execute() {
    return  _repository.getAppAllUsers();
  }
}
