import 'package:expensemanagerapp/ui/pages/add_expense/components/components.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({
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
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListenableProvider(
                  create: (_) => presenter,
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Period: ${presenter.selectedPeriod?.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                        Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                controller.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(child: AddExpenseButton()),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
