import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';
import '../datasources/operator_remote_datasource.dart';
import '../../domain/repositories/operator_repository.dart';

class OperatorRepositoryImpl implements OperatorRepository {
  final OperatorRemoteDataSource _dataSource;

  OperatorRepositoryImpl(this._dataSource);

  @override
  Future<List<OperatorEntity>> fetchAll() async {
    final models = await _dataSource.fetchAll();
    return models.map((m) => m.toEntity()).toList();
  }
}
