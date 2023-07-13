import 'package:flutter_aplication/domain/usescases/order_usecases/add_app_order_usecase.dart';
import 'package:flutter_aplication/domain/usescases/order_usecases/check_app_values_usecase.dart';
import 'package:flutter_aplication/domain/usescases/remove_app_order_usecase.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import '../../../../domain/usescases/order_usecases/change_app_order_status_usecase.dart';
import '../../../../domain/usescases/order_usecases/get_app_all_orders_usecase.dart';
import '../../../../domain/usescases/order_usecases/get_app_today_orders_usecase.dart';
import 'orders_page_controller.dart';

class OrdersPageBindings extends Bindings {
  void dependencies() {
    Get.put(AddAppOrderUsecase(Get.find()));
    // Get.put(GetAppOrdersUsecase(Get.find()));
    Get.put(RemoveAppOrderUsecase(Get.find()));
    Get.put(ChangeAppOrderStatusUsecase(Get.find()));
    Get.put(GetAppTodayOrdersUsecase(Get.find()));
    Get.put(GetAppAllOrdersUsecase(Get.find()));
    Get.put(CheckAppValuesUsecase(Get.find()));


    Get.lazyPut<OrdersPageController>(() =>OrdersPageController(
        addAppOrderUsecase: Get.find(),
        checkAppValuesUsecase: Get.find(),
        // getAppOrdersUsecase: Get.find(),
        removeAppOrderUsecase: Get.find(),
      changeAppOrderStatusUsecase: Get.find(),
      getAppAllOrdersUsecase: Get.find(),
      getAppTodayOrdersUsecase: Get.find(),

    ));
  }
}
