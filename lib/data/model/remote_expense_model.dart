import 'package:expensemanagerapp/domain/entities/entities.dart';

class RemoteExpenseModel {
  final int id;
  final String description;
  final double amount;
  final String date;

  RemoteExpenseModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory RemoteExpenseModel.fromJson(Map json) {
    return RemoteExpenseModel(
      id: json['id'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
    );
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      id: id,
      description: description,
      amount: amount,
      date: date,
    );
  }
}
