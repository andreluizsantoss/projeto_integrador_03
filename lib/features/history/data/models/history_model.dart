import '../../domain/entities/history_entity.dart';

class HistoryModel {
  final int checklistId;
  final int operatorId;
  final int machineId;
  final int? shiftId;
  final String data;
  final String operatorName;
  final String machineName;

  const HistoryModel({
    required this.checklistId,
    required this.operatorId,
    required this.machineId,
    this.shiftId,
    required this.data,
    required this.operatorName,
    required this.machineName,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    checklistId: json['id_checklist'] as int,
    operatorId: json['id_operador'] as int,
    machineId: json['id_maquina'] as int,
    shiftId: json['id_turno'] as int?,
    data: json['data'] as String,
    operatorName: (json['operador'] as Map<String, dynamic>)['nome'] as String,
    machineName:
        (json['maquina'] as Map<String, dynamic>)['nome_maquina'] as String,
  );

  HistoryEntity toEntity() => HistoryEntity(
    checklistId: checklistId,
    operatorId: operatorId,
    machineId: machineId,
    shiftId: shiftId,
    data: data,
    operatorName: operatorName,
    machineName: machineName,
  );
}
