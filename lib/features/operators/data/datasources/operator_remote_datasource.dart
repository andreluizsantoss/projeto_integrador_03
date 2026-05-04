import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import 'package:projeto_integrador_03/features/auth/data/models/operator_model.dart';

abstract interface class OperatorRemoteDataSource {
  Future<List<OperatorModel>> fetchAll();
}

class OperatorRemoteDataSourceImpl implements OperatorRemoteDataSource {
  final RestClient _client;

  OperatorRemoteDataSourceImpl(this._client);

  @override
  Future<List<OperatorModel>> fetchAll() async {
    final response = await _client.get<List<dynamic>>('/operadores');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => OperatorModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
