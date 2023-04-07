import 'package:expensemanagerapp/domain/entities/entities.dart';

class RemoteCategoryModel {
  final int id;
  final String name;
  final String description;

  RemoteCategoryModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory RemoteCategoryModel.fromJson(Map json) {
    return RemoteCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
    );
  }
}
