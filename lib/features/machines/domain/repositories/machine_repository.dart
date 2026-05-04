import '../entities/machine_entity.dart';

abstract interface class MachineRepository {
  Future<List<MachineEntity>> fetchAll();
}
