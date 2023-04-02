import 'package:equatable/equatable.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';

class PeriodCategoryEntity extends Equatable {
  final int id;
  final CategoryEntity category;
  final double budget;

  @override
  List get props => [id, category, budget];

  const PeriodCategoryEntity({
    required this.id,
    required this.category,
    required this.budget,
  });
}
