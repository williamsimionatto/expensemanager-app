import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expensemanagerapp/main/factories/pages/pages.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeObserserver = Get.put<RouteObserver>(RouteObserver<PageRoute>());

    return GetMaterialApp(
      title: 'Expense Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      navigatorObservers: [routeObserserver],
      initialRoute: '/expenses',
      getPages: [
        GetPage(
          name: '/expenses',
          page: makeExpensesPage,
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/expenses/add',
          page: makeAddExpensePage,
          transition: Transition.rightToLeftWithFade,
        ),
      ],
    );
  }
}
