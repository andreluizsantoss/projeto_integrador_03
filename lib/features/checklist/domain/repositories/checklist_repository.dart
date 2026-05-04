import '../entities/checklist_entity.dart';
import '../entities/checklist_detail_entity.dart';

class AnswerInput {
  final int itemId;
  final int statusId;
  final String? note;

  const AnswerInput({required this.itemId, required this.statusId, this.note});
}

abstract interface class ChecklistRepository {
  Future<ChecklistCreatedEntity> create({
    required int operatorId,
    required int machineId,
  });

  Future<void> saveAnswers({
    required int checklistId,
    required List<AnswerInput> answers,
  });

  Future<ChecklistDetailEntity> getDetail(int checklistId);
}
