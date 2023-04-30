import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget makePage({required String path, required Widget Function() page}) {
  final getPages = [
    GetPage(name: path, page: page),
    GetPage(
      name: '/any_route',
      page: () => const Scaffold(body: Text('fake page')),
    ),
  ];

  if (path != '/login') {
    getPages.add(GetPage(
      name: '/login',
      page: () => const Scaffold(body: Text('Login')),
    ));
  }

  return GetMaterialApp(
    initialRoute: path,
    navigatorObservers: [Get.put<RouteObserver>(RouteObserver<PageRoute>())],
    getPages: getPages,
  );
}

String get currentRoute => Get.currentRoute;
