import '../../domain/entities/machine_entity.dart';

class MachineModel {
  final int machineId;
  final String machineName;
  final String? tipo;
  final int? manufacturingYear;
  final int? companyId;

  const MachineModel({
    required this.machineId,
    required this.machineName,
    this.tipo,
    this.manufacturingYear,
    this.companyId,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
    machineId: json['id_maquina'] as int,
    machineName: json['nome_maquina'] as String,
    tipo: json['tipo'] as String?,
    manufacturingYear: json['ano_fabricacao'] as int?,
    companyId: json['id_empresa'] as int?,
  );

  MachineEntity toEntity() => MachineEntity(
    machineId: machineId,
    machineName: machineName,
    tipo: tipo,
    manufacturingYear: manufacturingYear,
    companyId: companyId,
  );
}
