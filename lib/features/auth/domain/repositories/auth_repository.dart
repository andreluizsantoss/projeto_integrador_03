import '../entities/operator_entity.dart';

abstract interface class AuthRepository {
  Future<OperatorEntity> login({required int operatorId, required int pin});
}
