import 'package:expensemanagerapp/domain/entities/entities.dart';

abstract class LoadExpenses {
  Future<List<ExpenseEntity>> load();
}
