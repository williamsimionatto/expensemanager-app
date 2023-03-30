import 'package:equatable/equatable.dart';

class ExpenseEntity extends Equatable {
  final int id;
  final String description;
  final double amount;
  final String date;

  @override
  List get props => [id, description, amount, date];

  const ExpenseEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
