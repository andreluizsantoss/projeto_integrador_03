import '../../domain/entities/checklist_entity.dart';

class ChecklistCreatedModel {
  final int checklistId;
  final int operatorId;
  final int machineId;
  final int? shiftId;
  final String data;

  const ChecklistCreatedModel({
    required this.checklistId,
    required this.operatorId,
    required this.machineId,
    this.shiftId,
    required this.data,
  });

  factory ChecklistCreatedModel.fromJson(Map<String, dynamic> json) =>
      ChecklistCreatedModel(
        checklistId: json['id_checklist'] as int,
        operatorId: json['id_operador'] as int,
        machineId: json['id_maquina'] as int,
        shiftId: json['id_turno'] as int?,
        data: json['data'] as String,
      );

  ChecklistCreatedEntity toEntity() => ChecklistCreatedEntity(
    checklistId: checklistId,
    operatorId: operatorId,
    machineId: machineId,
    shiftId: shiftId,
    data: data,
  );
}
