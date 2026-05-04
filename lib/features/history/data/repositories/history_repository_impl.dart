import '../datasources/history_remote_datasource.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource _dataSource;

  HistoryRepositoryImpl(this._dataSource);

  @override
  Future<List<HistoryEntity>> fetchAll({
    int? operatorId,
    int? machineId,
  }) async {
    final models = await _dataSource.fetchAll(
      operatorId: operatorId,
      machineId: machineId,
    );
    return models.map((m) => m.toEntity()).toList();
  }
}
