import 'package:flutter_aplication/domain/usescases/order_usecases/add_app_order_usecase.dart';
import 'package:flutter_aplication/domain/usescases/order_usecases/check_app_values_usecase.dart';
import 'package:flutter_aplication/domain/usescases/user_usecases/change_app_user_data_usecase.dart';
import 'package:flutter_aplication/domain/usescases/user_usecases/get_app_user_email_usecase.dart';
import 'package:flutter_aplication/domain/usescases/users_page_usecases/get_app_all_users_usecase.dart';
import 'package:get/get.dart';
import '../../../domain/usescases/order_usecases/change_app_order_status_usecase.dart';
import '../../../domain/usescases/order_usecases/get_app_all_orders_usecase.dart';
import '../../../domain/usescases/order_usecases/get_app_today_orders_usecase.dart';
import '../../../domain/usescases/remove_app_order_usecase.dart';
import '../menu/account_pages/account_settings_pages/account_page_controller.dart';
import '../menu/orders_pages/orders_page_controller.dart';
import '../menu/users_pages/users_page_controller.dart';
class MainPageBindings extends Bindings {
  void dependencies (){
    Get.put(AddAppOrderUsecase(Get.find()));
    // Get.put(GetAppOrdersUsecase(Get.find()));
    Get.put(RemoveAppOrderUsecase(Get.find()));
    Get.put(ChangeAppOrderStatusUsecase(Get.find()));
    Get.put(GetAppTodayOrdersUsecase(Get.find()));
    Get.put(GetAppAllOrdersUsecase(Get.find()));
    Get.put(GetAppUserDataUsecase(Get.find()));
    Get.put(ChangeAppUserDataUsecase(Get.find()));
    // Get.put(GetAppAllUsersUsecase(Get.find()));
    Get.put(CheckAppValuesUsecase(Get.find()));

    Get.lazyPut<OrdersPageController>(() =>OrdersPageController(
      addAppOrderUsecase: Get.find(),
      removeAppOrderUsecase: Get.find(),
      changeAppOrderStatusUsecase: Get.find(),
      getAppAllOrdersUsecase: Get.find(),
      getAppTodayOrdersUsecase: Get.find(),
      checkAppValuesUsecase: Get.find(),
    ));
    Get.lazyPut<AccountPageController>(() =>AccountPageController(
      getAppUserDataUsecase: Get.find(),
      changeAppUserDataUsecase: Get.find(),
    ));
    Get.lazyPut<UsersPageController>(() =>UsersPageController(
      // getAppAllUsersUsecase: Get.find(),
    ));

  }
}