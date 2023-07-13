
import '../repositories/app_firebase_info_repository.dart';

class RemoveAppOrderUsecase{
  final AppFirebaseInfoRepository _repository;
  RemoveAppOrderUsecase(this._repository);
  Future execute(String nameOfOrder) async {
    return await _repository.removeAppOrder(nameOfOrder);
  }
}