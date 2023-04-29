import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/mixins/mixins.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

import './components/components.dart';

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
                  Step2Page(
                    controller: controller,
                    presenter: presenter,
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
