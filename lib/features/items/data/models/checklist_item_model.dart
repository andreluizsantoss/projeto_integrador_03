import '../../domain/entities/checklist_item_entity.dart';

class ChecklistItemModel {
  final int itemId;
  final String description;
  final String? category;
  final int? categoryId;

  const ChecklistItemModel({
    required this.itemId,
    required this.description,
    this.category,
    this.categoryId,
  });

  factory ChecklistItemModel.fromJson(Map<String, dynamic> json) =>
      ChecklistItemModel(
        itemId: json['id_item'] as int,
        description: json['descricao'] as String,
        category: json['categoria'] as String?,
        categoryId: json['id_categoria'] as int?,
      );

  ChecklistItemEntity toEntity() => ChecklistItemEntity(
    itemId: itemId,
    description: description,
    category: category,
    categoryId: categoryId,
  );
}
