import '../entities/history_entity.dart';

abstract interface class HistoryRepository {
  Future<List<HistoryEntity>> fetchAll({int? operatorId, int? machineId});
}
