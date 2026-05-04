import '../datasources/machine_remote_datasource.dart';
import '../../domain/entities/machine_entity.dart';
import '../../domain/repositories/machine_repository.dart';

class MachineRepositoryImpl implements MachineRepository {
  final MachineRemoteDataSource _dataSource;

  MachineRepositoryImpl(this._dataSource);

  @override
  Future<List<MachineEntity>> fetchAll() async {
    final models = await _dataSource.fetchAll();
    return models.map((m) => m.toEntity()).toList();
  }
}
