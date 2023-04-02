import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String description;

  @override
  List get props => [id, name, description];

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
  });
}
