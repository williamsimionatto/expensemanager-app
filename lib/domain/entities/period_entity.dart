import 'package:equatable/equatable.dart';

class PeriodEntity extends Equatable {
  final int id;
  final String name;
  final String startDate;
  final String endDate;
  final double budget;

  @override
  List get props => [id, name, startDate, endDate, budget];

  const PeriodEntity({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.budget,
  });
}
