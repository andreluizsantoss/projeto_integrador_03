import 'package:projeto_integrador_03/core/rest_client/rest_client.dart';
import '../models/checklist_item_model.dart';

abstract interface class ItemRemoteDataSource {
  Future<List<ChecklistItemModel>> fetchAll();
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final RestClient _client;

  ItemRemoteDataSourceImpl(this._client);

  @override
  Future<List<ChecklistItemModel>> fetchAll() async {
    final response = await _client.get<List<dynamic>>('/itens');
    final list = response.data as List<dynamic>;
    return list
        .map((e) => ChecklistItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
