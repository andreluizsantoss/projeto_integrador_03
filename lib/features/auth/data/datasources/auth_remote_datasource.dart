import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import '../models/operator_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<OperatorModel> login({required int operatorId, required int pin});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final RestClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<OperatorModel> login({
    required int operatorId,
    required int pin,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'id_operador': operatorId, 'pin': pin},
    );
    final data = response.data!;
    return OperatorModel.fromJson(data['operador'] as Map<String, dynamic>);
  }
}
