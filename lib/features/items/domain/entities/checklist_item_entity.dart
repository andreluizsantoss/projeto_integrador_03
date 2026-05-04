import 'package:equatable/equatable.dart';

class ChecklistItemEntity extends Equatable {
  final int itemId;
  final String description;
  final String? category;
  final int? categoryId;

  const ChecklistItemEntity({
    required this.itemId,
    required this.description,
    this.category,
    this.categoryId,
  });

  @override
  List<Object?> get props => [itemId, description, category, categoryId];
}
