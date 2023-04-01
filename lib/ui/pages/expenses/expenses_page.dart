import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  final ExpensesPresenter presenter;

  const ExpensesPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPage();
}

class _ExpensesPage extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Builder(
        builder: (context) {
          widget.presenter.loadData();
          return const Center(
            child: Text('Expenses'),
          );
        },
      ),
    );
  }
}
