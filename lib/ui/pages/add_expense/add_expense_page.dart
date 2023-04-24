import 'package:expensemanagerapp/ui/pages/add_expense/components/date_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/mixins/mixins.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

import './components/components.dart';

class AddExpensePage extends StatefulWidget with KeyboardManager {
  final AddExpensePresenter presenter;

  const AddExpensePage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePage();
}

class _AddExpensePage extends State<AddExpensePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => widget.hideKeyboard(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: ListenableProvider(
                    create: (_) => widget.presenter,
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
