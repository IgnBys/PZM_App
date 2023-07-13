import '../../repositories/app_firebase_info_repository.dart';

class AddAppOrderUsecase{
  final AppFirebaseInfoRepository _repository;
  AddAppOrderUsecase(this._repository);
  Future execute(String orderNumber, String typeOfOrder, String adress, String counterStatus, String status) async {
    return await _repository.addAppOrder( orderNumber, typeOfOrder,  adress, counterStatus, status);
  }
}