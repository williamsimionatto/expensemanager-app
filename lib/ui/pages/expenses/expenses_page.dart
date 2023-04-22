import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expensemanagerapp/ui/components/components.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../../mixins/mixins.dart';
import './components/compoents.dart';

class ExpensesPage extends StatefulWidget {
  final ExpensesPresenter presenter;

  const ExpensesPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPage();
}

class _ExpensesPage extends State<ExpensesPage> with LoadingManager {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      handleLoading(context, widget.presenter.isLoadingStream);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: Builder(
        builder: (context) {
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
      children: expenses.map((viewModel) => ExpenseItem(viewModel)).toList(),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final ExpenseViewModel viewModel;

  const ExpenseItem(this.viewModel, {Key? key}) : super(key: key);

  void _showBottomSheet(BuildContext context, ExpenseViewModel data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetModal(expense: data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context, viewModel),
      behavior: HitTestBehavior.opaque,
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
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.info_outlined,
            color: Color(0XFFF64348),
          ),
        ),
      ),
    );
  }
}
