import 'package:expensemanagerapp/data/http/http.dart';
import 'package:expensemanagerapp/data/model/model.dart';
import 'package:expensemanagerapp/domain/entities/entities.dart';

class RemotePeriodCategoryModel {
  final int id;
  final RemoteCategoryModel category;
  final double budget;

  RemotePeriodCategoryModel({
    required this.id,
    required this.category,
    required this.budget,
  });

  factory RemotePeriodCategoryModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'category', 'budget'])) {
      throw HttpError.invalidData;
    }

    return RemotePeriodCategoryModel(
      id: json['id'],
      category: RemoteCategoryModel.fromJson(json['category']),
      budget: json['budget'],
    );
  }

  PeriodCategoryEntity toEntity() {
    return PeriodCategoryEntity(
      id: id,
      category: category.toEntity(),
      budget: budget,
    );
  }
}
