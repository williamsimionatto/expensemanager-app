import 'package:expensemanagerapp/ui/pages/add_expense/components/components.dart';
import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/mixins/mixins.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:provider/provider.dart';

class AddExpensePage extends StatelessWidget
    with KeyboardManager, UIErrorManager, SuccessManager, LoadingManager {
  final AddExpensePresenter presenter;

  AddExpensePage(this.presenter, {Key? key}) : super(key: key);

  final PageController controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: FutureBuilder(
        future: presenter.loadPeriods(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            handleMainError(context, presenter.mainErrorStream);
            handleSuccessMessage(context, presenter.successMessageStream);
            handleLoading(context, presenter.isLoadingStream);

            return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SelectPeriodPage(
                    controller: controller,
                    presenter: presenter,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('Back'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

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

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.controller,
    required this.presenter,
  });

  final PageController controller;
  final AddExpensePresenter presenter;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            } else if (states.contains(MaterialState.disabled)) {
              return Theme.of(context).primaryColor.withOpacity(0.5);
            } else {
              return Theme.of(context).primaryColor;
            }
          },
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.maxFinite, 50),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: presenter.isPeriodValid
          ? () {
              controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          : null,
      child: const Text(
        'Continue',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
