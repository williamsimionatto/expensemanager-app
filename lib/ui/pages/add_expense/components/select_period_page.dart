import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import 'components.dart';

class SelectPeriodPage extends StatelessWidget {
  const SelectPeriodPage({
    super.key,
    required this.controller,
    required this.presenter,
  });

  final PageController controller;
  final AddExpensePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListenableProvider(
                create: (_) => presenter,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      const PeriodInput(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ContinueButton(
                          controller: controller,
                          presenter: presenter,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
