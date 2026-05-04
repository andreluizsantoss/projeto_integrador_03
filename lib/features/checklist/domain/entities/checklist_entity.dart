import 'package:equatable/equatable.dart';

class ChecklistCreatedEntity extends Equatable {
  final int checklistId;
  final int operatorId;
  final int machineId;
  final int? shiftId;
  final String data;

  const ChecklistCreatedEntity({
    required this.checklistId,
    required this.operatorId,
    required this.machineId,
    this.shiftId,
    required this.data,
  });

  @override
  List<Object?> get props => [
    checklistId,
    operatorId,
    machineId,
    shiftId,
    data,
  ];
}
