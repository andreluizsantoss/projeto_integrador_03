import 'package:equatable/equatable.dart';

class OperatorEntity extends Equatable {
  final int operatorId;
  final String nome;
  final int? age;
  final int? companyId;

  const OperatorEntity({
    required this.operatorId,
    required this.nome,
    this.age,
    this.companyId,
  });

  @override
  List<Object?> get props => [operatorId, nome, age, companyId];
}
