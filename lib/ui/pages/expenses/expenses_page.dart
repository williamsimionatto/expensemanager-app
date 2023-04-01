import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../mixins/mixins.dart';
import '../../components/components.dart';

class ExpensesPage extends StatefulWidget {
  final ExpensesPresenter presenter;

  const ExpensesPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPage();
}

class _ExpensesPage extends State<ExpensesPage> with LoadingManager {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Builder(
        builder: (context) {
          // handleLoading(context, widget.presenter.isLoadingStream);
          widget.presenter.loadData();

          return StreamBuilder<List<ExpenseViewModel>?>(
            stream: widget.presenter.expensesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadScreen(
                  error: '${snapshot.error}',
                  reload: widget.presenter.loadData,
                );
              }

              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () => widget.presenter.loadData(),
                  child: ListenableProvider<ExpensesPresenter>(
                    create: (_) => widget.presenter,
                    child: ExpenseListView(expenses: snapshot.data!),
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}

class ExpenseListView extends StatelessWidget {
  final List<ExpenseViewModel> expenses;

  const ExpenseListView({
    Key? key,
    required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: expenses.map((viewModel) => UserItem(viewModel)).toList(),
    );
  }
}

class UserItem extends StatelessWidget {
  final ExpenseViewModel viewModel;

  const UserItem(this.viewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        shadowColor: Colors.black,
        child: ListTile(
          title: Text(
            viewModel.description,
            style: const TextStyle(
              color: Color(0XFFF64348),
              // fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Color(0XFFF64348),
          ),
        ),
      ),
    );
  }
}
