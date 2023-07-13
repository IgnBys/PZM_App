import 'package:flutter_aplication/presentation/pages/drawer/drawer.dart';
import 'package:flutter_aplication/presentation/pages/mainscreen/main_page_bindings.dart';
import 'package:flutter_aplication/presentation/pages/menu/account_pages/account_settings_pages/account_page_bindings.dart';
import 'package:flutter_aplication/presentation/pages/menu/users_pages/users_page_bindings.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../presentation/pages/auth_pages/log_in_page.dart';
import '../../presentation/pages/homescreen/home_page.dart';
import '../../presentation/pages/auth_pages/sign_up_page.dart';
import '../../presentation/pages/mainscreen/main_page.dart';
import '../../presentation/pages/menu/account_pages/account_settings_pages/account_page.dart';
import '../../presentation/pages/menu/account_pages/account_settings_pages/picture_page.dart';
import '../../presentation/pages/menu/orders_pages/orders_page.dart';
import '../../presentation/pages/menu/orders_pages/orders_page_bindings.dart';
import '../../presentation/pages/menu/users_pages/users_page.dart';

List<GetPage<dynamic>> get AppRouter {
  return [
    GetPage(
      name: '/MainPage',
      page: () => MainPage(),
      transition: Transition.fadeIn,
      binding:MainPageBindings(),
    ),
    GetPage(
      name: '/LogInPage',
      page: () => LogInPage(onClickedSignUp: () {  },),
      // transition: Transition.fadeIn,
      // binding:MainPageBindings(),
    ),
    GetPage(
      name: '/OrdersPage',
      page: () => OrdersPage(),
      transition: Transition.fadeIn,
      binding: OrdersPageBindings(),
    ),
    GetPage(
        name: '/SignUpPage',
        page: () => SignUpPage(onClickedSignIn: () {  },)
    ),
    GetPage(
      name: '/HomePage',
      page: () => HomePage(),
      transition: Transition.fadeIn,
      bindings:[MainPageBindings()]
    ),
    GetPage(
        name: '/AccountPage',
        page: () => AccountPage(),
      transition: Transition.fadeIn,
      binding: AccountPageBindings(),
    ),

    GetPage(
        name: '/UsersPage',
        page: () => UsersPage(),
      // transition: Transition.fadeIn,
      // binding: UsersPageBindings(),
    ),
    // GetPage(
    //     name: '/PicturePage',
    //     page: () => PicturePage(),
    //   transition: Transition.fadeIn,
    //   binding: MainPageBindings(),
    // ),


  ];

}
