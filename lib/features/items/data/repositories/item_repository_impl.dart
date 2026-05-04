import '../datasources/item_remote_datasource.dart';
import '../../domain/entities/checklist_item_entity.dart';
import '../../domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource _dataSource;

  ItemRepositoryImpl(this._dataSource);

  @override
  Future<List<ChecklistItemEntity>> fetchAll() async {
    final models = await _dataSource.fetchAll();
    return models.map((m) => m.toEntity()).toList();
  }
}
