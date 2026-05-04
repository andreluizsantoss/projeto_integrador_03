import '../../domain/entities/operator_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<OperatorEntity> login({
    required int operatorId,
    required int pin,
  }) async {
    final model = await _dataSource.login(operatorId: operatorId, pin: pin);
    return model.toEntity();
  }
}
