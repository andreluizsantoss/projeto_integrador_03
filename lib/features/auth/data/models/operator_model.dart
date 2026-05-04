import '../../domain/entities/operator_entity.dart';

class OperatorModel {
  final int operatorId;
  final String nome;
  final int? age;
  final int? companyId;

  const OperatorModel({
    required this.operatorId,
    required this.nome,
    this.age,
    this.companyId,
  });

  factory OperatorModel.fromJson(Map<String, dynamic> json) => OperatorModel(
    operatorId: json['id_operador'] as int,
    nome: json['nome'] as String,
    age: json['idade'] as int?,
    companyId: json['id_empresa'] as int?,
  );

  OperatorEntity toEntity() => OperatorEntity(
    operatorId: operatorId,
    nome: nome,
    age: age,
    companyId: companyId,
  );
}
