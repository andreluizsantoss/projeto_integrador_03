import '../entities/checklist_item_entity.dart';

abstract interface class ItemRepository {
  Future<List<ChecklistItemEntity>> fetchAll();
}
