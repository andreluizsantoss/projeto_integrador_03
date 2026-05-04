import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import '../models/history_model.dart';

abstract interface class HistoryRemoteDataSource {
  Future<List<HistoryModel>> fetchAll({int? operatorId, int? machineId});
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final RestClient _client;

  HistoryRemoteDataSourceImpl(this._client);

  @override
  Future<List<HistoryModel>> fetchAll({int? operatorId, int? machineId}) async {
    final queryParams = <String, dynamic>{};
    if (operatorId != null) queryParams['operador_id'] = operatorId;
    if (machineId != null) queryParams['maquina_id'] = machineId;

    final response = await _client.get<List<dynamic>>(
      '/checklists',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );
    final list = response.data as List<dynamic>;
    return list
        .map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
