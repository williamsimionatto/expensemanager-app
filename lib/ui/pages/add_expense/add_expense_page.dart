import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/mixins/mixins.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

import './components/components.dart';

class AddExpensePage extends StatelessWidget
    with KeyboardManager, UIErrorManager, SuccessManager, LoadingManager {
  final AddExpensePresenter presenter;

  AddExpensePage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Builder(builder: (context) {
        handleMainError(context, presenter.mainErrorStream);
        handleSuccessMessage(context, presenter.successMessageStream);
        handleLoading(context, presenter.isLoadingStream);

        return GestureDetector(
          onTap: () => hideKeyboard(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: ListenableProvider(
                    create: (_) => presenter,
                    child: Form(
                      child: Column(
                        children: const <Widget>[
                          PeriodInput(),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: CategoryInput(),
                          ),
                          DescriptionInput(),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: AmountInput(),
                          ),
                          DateInput(),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 32),
                            child: AddExpenseButton(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
