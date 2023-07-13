import '../../repositories/app_firebase_info_repository.dart';

class ChangeAppOrderStatusUsecase{
  final AppFirebaseInfoRepository _repository;
  ChangeAppOrderStatusUsecase(this._repository);
  Future <List<Map<String, dynamic>>> execute(order) async {
    return await _repository.changeAppOrderStatus(order);
  }
}