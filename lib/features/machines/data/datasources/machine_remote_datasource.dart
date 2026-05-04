import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import '../models/machine_model.dart';

abstract interface class MachineRemoteDataSource {
  Future<List<MachineModel>> fetchAll();
}

class MachineRemoteDataSourceImpl implements MachineRemoteDataSource {
  final RestClient _client;

  MachineRemoteDataSourceImpl(this._client);

  @override
  Future<List<MachineModel>> fetchAll() async {
    final response = await _client.get<List<dynamic>>('/maquinas');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => MachineModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
