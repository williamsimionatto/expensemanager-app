import 'package:equatable/equatable.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class PeriodCategoryViewModel extends Equatable {
  final int id;
  final double budget;
  final CategoryViewModel category;

  @override
  List get props => [id, budget, category];

  const PeriodCategoryViewModel({
    required this.id,
    required this.budget,
    required this.category,
  });
}
