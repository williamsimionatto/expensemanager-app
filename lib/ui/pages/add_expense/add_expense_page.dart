import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/mixins/mixins.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:provider/provider.dart';

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

class Step2Page extends StatelessWidget {
  const Step2Page({
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListenableProvider(
                create: (_) => presenter,
                child: Form(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CategoryInput(),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DescriptionInput(),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AmountInput(),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: DateInput(),
                      ),
                      Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AddExpenseButton(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                controller.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Text('Back'),
                            ),
                          ),
                        ],
                      )
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
