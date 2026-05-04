import '../datasources/checklist_remote_datasource.dart';
import '../../domain/entities/checklist_entity.dart';
import '../../domain/entities/checklist_detail_entity.dart';
import '../../domain/repositories/checklist_repository.dart';

class ChecklistRepositoryImpl implements ChecklistRepository {
  final ChecklistRemoteDataSource _dataSource;

  ChecklistRepositoryImpl(this._dataSource);

  @override
  Future<ChecklistCreatedEntity> create({
    required int operatorId,
    required int machineId,
  }) async {
    final model = await _dataSource.create(
      operatorId: operatorId,
      machineId: machineId,
    );
    return model.toEntity();
  }

  @override
  Future<void> saveAnswers({
    required int checklistId,
    required List<AnswerInput> answers,
  }) => _dataSource.saveAnswers(checklistId: checklistId, answers: answers);

  @override
  Future<ChecklistDetailEntity> getDetail(int checklistId) async {
    final model = await _dataSource.fetchById(checklistId);
    return model.toEntity();
  }
}
