import 'package:expensemanagerapp/domain/entities/entities.dart';

abstract class AddExpense {
  Future<ExpenseEntity> add(AddExpenseParams params);
}

class AddExpenseParams {
  final String description;
  final double amount;
  final String date;
  final int categoryId;
  final int periodId;

  const AddExpenseParams({
    required this.description,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.periodId,
  });
}
