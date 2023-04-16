import 'package:equatable/equatable.dart';

class PeriodViewModel extends Equatable {
  final int id;
  final String description;
  final String startDate;
  final String endDate;
  final double budget;

  @override
  List get props => [id, description, startDate, endDate, budget];

  const PeriodViewModel({
    required this.id,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.budget,
  });
}
