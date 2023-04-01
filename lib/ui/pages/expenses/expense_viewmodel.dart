import 'package:equatable/equatable.dart';

class ExpenseViewModel extends Equatable {
  final int id;
  final String description;
  final double amount;
  final String date;

  @override
  List<Object?> get props => [id, description, amount, date];

  const ExpenseViewModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });
}
