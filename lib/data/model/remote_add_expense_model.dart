import 'package:expensemanagerapp/domain/usecases/usecases.dart';

class RemoteAddExpenseModel {
  final String description;
  final double amount;
  final String date;
  final int categoryId;
  final int periodId;

  RemoteAddExpenseModel({
    required this.description,
    required this.amount,
    required this.date,
    required this.categoryId,
    required this.periodId,
  });

  factory RemoteAddExpenseModel.fromDomain(AddExpenseParams params) {
    return RemoteAddExpenseModel(
      description: params.description,
      amount: params.amount,
      date: params.date,
      categoryId: params.categoryId,
      periodId: params.periodId,
    );
  }

  Map toJson() => {
        'description': description,
        'amount': amount,
        'date': date,
        'category_id': categoryId,
        'period_id': periodId,
      };
}
