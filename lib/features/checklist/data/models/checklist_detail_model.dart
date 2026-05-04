import '../../domain/entities/checklist_detail_entity.dart';

class ChecklistAnswerModel {
  final int answerId;
  final int itemId;
  final int statusId;
  final String? observation;
  final String itemDescription;
  final String itemCategory;
  final String statusDescription;

  const ChecklistAnswerModel({
    required this.answerId,
    required this.itemId,
    required this.statusId,
    this.observation,
    required this.itemDescription,
    required this.itemCategory,
    required this.statusDescription,
  });

  factory ChecklistAnswerModel.fromJson(Map<String, dynamic> json) {
    final item = json['item_checklist'] as Map<String, dynamic>;
    final status = json['status_inspecao'] as Map<String, dynamic>;
    return ChecklistAnswerModel(
      answerId: json['id_resposta'] as int,
      itemId: json['id_item'] as int,
      statusId: json['id_status'] as int,
      observation: json['observacao'] as String?,
      itemDescription: item['descricao'] as String,
      itemCategory: item['categoria'] as String,
      statusDescription: status['descricao'] as String,
    );
  }

  ChecklistAnswerEntity toEntity() => ChecklistAnswerEntity(
    answerId: answerId,
    itemId: itemId,
    statusId: statusId,
    observation: observation,
    itemDescription: itemDescription,
    itemCategory: itemCategory,
    statusDescription: statusDescription,
  );
}

class ChecklistDetailModel {
  final int checklistId;
  final int operatorId;
  final int machineId;
  final int? shiftId;
  final String data;
  final String operatorName;
  final String machineName;
  final List<ChecklistAnswerModel> answers;

  const ChecklistDetailModel({
    required this.checklistId,
    required this.operatorId,
    required this.machineId,
    this.shiftId,
    required this.data,
    required this.operatorName,
    required this.machineName,
    required this.answers,
  });

  factory ChecklistDetailModel.fromJson(
    Map<String, dynamic> json,
  ) => ChecklistDetailModel(
    checklistId: json['id_checklist'] as int,
    operatorId: json['id_operador'] as int,
    machineId: json['id_maquina'] as int,
    shiftId: json['id_turno'] as int?,
    data: json['data'] as String,
    operatorName: (json['operador'] as Map<String, dynamic>)['nome'] as String,
    machineName:
        (json['maquina'] as Map<String, dynamic>)['nome_maquina'] as String,
    answers: (json['resposta_checklist'] as List<dynamic>)
        .map((e) => ChecklistAnswerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  ChecklistDetailEntity toEntity() => ChecklistDetailEntity(
    checklistId: checklistId,
    operatorId: operatorId,
    machineId: machineId,
    shiftId: shiftId,
    data: data,
    operatorName: operatorName,
    machineName: machineName,
    answers: answers.map((a) => a.toEntity()).toList(),
  );
}
