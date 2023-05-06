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

class _ExpensesPage extends State<ExpensesPage>
    with LoadingManager, SuccessManager {
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
          handleSuccessMessage(context, widget.presenter.successMessageStream);
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
                  onRefresh: () async => await widget.presenter.loadData(),
                  child: ListenableProvider<ExpensesPresenter>(
                    create: (_) => widget.presenter,
                    child: ExpenseListView(
                      expenses: snapshot.data!,
                      presenter: widget.presenter,
                    ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/expenses/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ExpenseListView extends StatelessWidget {
  final List<ExpenseViewModel> expenses;
  final ExpensesPresenter presenter;

  const ExpenseListView(
      {Key? key, required this.expenses, required this.presenter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: expenses
          .map((viewModel) => ExpenseItem(viewModel, presenter))
          .toList(),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final ExpenseViewModel viewModel;
  final ExpensesPresenter presenter;

  const ExpenseItem(this.viewModel, this.presenter, {Key? key})
      : super(key: key);

  void _showBottomSheet(BuildContext context, ExpenseViewModel data) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      barrierColor: Colors.grey.withOpacity(0.5),
      builder: (BuildContext context) {
        return BottomSheetModal(
          expense: data,
          presenter: presenter,
          onDeleteSuccess: () {
            Navigator.pop(context);
          },
        );
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
