import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/core/rest_client/rest_client_exception.dart';
import '../../domain/repositories/history_repository.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryRepository _repository;

  HistoryCubit(this._repository) : super(const HistoryInitial());

  Future<void> fetchAll({int? operatorId, int? machineId}) async {
    emit(const HistoryLoading());
    try {
      final checklists = await _repository.fetchAll(
        operatorId: operatorId,
        machineId: machineId,
      );
      emit(HistoryLoaded(checklists));
    } catch (e) {
      emit(HistoryError(_errorMessage(e)));
    }
  }

  String _errorMessage(dynamic e) {
    if (e is RestClientException) return e.displayMessage;
    return 'Erro ao carregar histórico';
  }
}
