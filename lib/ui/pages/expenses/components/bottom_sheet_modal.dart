import 'dart:io' show Platform;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

import '../components/compoents.dart';

class BottomSheetModal extends StatelessWidget {
  final ExpenseViewModel expense;
  final ExpensesPresenter presenter;
  final VoidCallback onDeleteSuccess;

  const BottomSheetModal({
    Key? key,
    required this.expense,
    required this.presenter,
    required this.onDeleteSuccess,
  }) : super(key: key);

  String formatDate(date) {
    final dateFormated = DateTime.parse(date);
    return DateFormat('dd/MM/yyy').format(dateFormated);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              expense.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Date:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatDate(expense.date),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Amount:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'R\$ ${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 16),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0XFFF64348),
              ),
              child: TextButton.icon(
                onPressed: () async {
                  final navigator = Navigator.of(context);

                  final confirmation = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return Platform.isAndroid
                          ? const DeleteConfirmationDialogAndroid()
                          : const DeleteConfirmationDialogIOS();
                    },
                  );

                  if (confirmation != null && confirmation) {
                    await presenter.deleteExpense(expense.id.toString());
                    onDeleteSuccess();
                    navigator.pop();
                  }
                },
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
