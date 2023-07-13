import 'package:flutter_aplication/domain/usescases/users_page_usecases/get_app_all_users_usecase.dart';
import 'package:flutter_aplication/presentation/pages/menu/users_pages/users_page_controller.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';

class UsersPageBindings extends Bindings {
  void dependencies() {
    // Get.put(GetAppAllUsersUsecase(Get.find()));



    Get.lazyPut<UsersPageController>(() =>UsersPageController(
      // getAppAllUsersUsecase: Get.find(),


    ));
  }
}
