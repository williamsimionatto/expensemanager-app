import 'package:equatable/equatable.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';

abstract class AddExpense {
  Future<ExpenseEntity> add(AddExpenseParams params);
}

class AddExpenseParams extends Equatable {
  final String description;
  final double amount;
  final String date;
  final int categoryId;
  final int periodId;

  @override
  List<Object?> get props => [
        description,
        amount,
        date,
        categoryId,
        periodId,
      ];

  const AddExpenseParams({
    required this.description,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.periodId,
  });
}
