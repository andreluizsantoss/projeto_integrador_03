import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';

abstract interface class OperatorRepository {
  Future<List<OperatorEntity>> fetchAll();
}
