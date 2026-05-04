import 'package:equatable/equatable.dart';

class MachineEntity extends Equatable {
  final int machineId;
  final String machineName;
  final String? tipo;
  final int? manufacturingYear;
  final int? companyId;

  const MachineEntity({
    required this.machineId,
    required this.machineName,
    this.tipo,
    this.manufacturingYear,
    this.companyId,
  });

  @override
  List<Object?> get props => [
    machineId,
    machineName,
    tipo,
    manufacturingYear,
    companyId,
  ];
}
