import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final int checklistId;
  final int operatorId;
  final int machineId;
  final int? shiftId;
  final String data;
  final String operatorName;
  final String machineName;

  const HistoryEntity({
    required this.checklistId,
    required this.operatorId,
    required this.machineId,
    this.shiftId,
    required this.data,
    required this.operatorName,
    required this.machineName,
  });

  @override
  List<Object?> get props => [checklistId, operatorId, machineId, data];
}
