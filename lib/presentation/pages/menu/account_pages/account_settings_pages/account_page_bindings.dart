import 'package:flutter_aplication/domain/usescases/order_usecases/change_app_order_status_usecase.dart';
import 'package:flutter_aplication/domain/usescases/user_usecases/change_app_user_data_usecase.dart';
import 'package:flutter_aplication/domain/usescases/user_usecases/get_app_user_email_usecase.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';

import 'account_page_controller.dart';

class AccountPageBindings extends Bindings {
  void dependencies() {

    Get.put(GetAppUserDataUsecase(Get.find()));
    Get.put(ChangeAppUserDataUsecase(Get.find()));


    Get.lazyPut<AccountPageController>(() =>AccountPageController(

      changeAppUserDataUsecase: Get.find(),
      getAppUserDataUsecase: Get.find(),

    ));
  }
}
