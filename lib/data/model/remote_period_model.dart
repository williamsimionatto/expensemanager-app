import 'package:expensemanagerapp/data/http/http_error.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';

class RemotePeriodModel {
  final int id;
  final String name;
  final String startDate;
  final String endDate;
  final double budget;

  RemotePeriodModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.budget,
  });

  factory RemotePeriodModel.fromJson(Map json) {
    if (!json.keys
        .toSet()
        .containsAll(['id', 'name', 'startDate', 'endDate', 'budget'])) {
      throw HttpError.invalidData;
    }

    return RemotePeriodModel(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      budget: json['budget'],
    );
  }

  PeriodEntity toEntity() {
    return PeriodEntity(
      id: id,
      name: name,
      startDate: startDate,
      endDate: endDate,
      budget: budget,
    );
  }
}
