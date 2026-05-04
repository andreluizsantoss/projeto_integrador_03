import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import '../models/checklist_model.dart';
import '../../domain/repositories/checklist_repository.dart';

abstract interface class ChecklistRemoteDataSource {
  Future<ChecklistCreatedModel> create({
    required int operatorId,
    required int machineId,
  });

  Future<void> saveAnswers({
    required int checklistId,
    required List<AnswerInput> answers,
  });
}

class ChecklistRemoteDataSourceImpl implements ChecklistRemoteDataSource {
  final RestClient _client;

  ChecklistRemoteDataSourceImpl(this._client);

  @override
  Future<ChecklistCreatedModel> create({
    required int operatorId,
    required int machineId,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/checklists',
      data: {'id_operador': operatorId, 'id_maquina': machineId},
    );
    return ChecklistCreatedModel.fromJson(response.data!);
  }

  @override
  Future<void> saveAnswers({
    required int checklistId,
    required List<AnswerInput> answers,
  }) async {
    await _client.post<void>(
      '/checklists/$checklistId/respostas',
      data: {
        'respostas': answers
            .map(
              (r) => {
                'id_item': r.itemId,
                'id_status': r.statusId,
                if (r.note != null) 'observacao': r.note,
              },
            )
            .toList(),
      },
    );
  }
}
