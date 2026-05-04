import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/core/rest_client/rest_client_exception.dart';
import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';
import 'package:projeto_integrador_03/features/operators/domain/repositories/operator_repository.dart';
import 'operator_state.dart';

class OperatorCubit extends Cubit<OperatorState> {
  final OperatorRepository _repository;

  OperatorCubit(this._repository) : super(const OperatorInitial());

  Future<void> fetchAll() async {
    emit(const OperatorLoading());
    try {
      final operators = await _repository.fetchAll();
      emit(OperatorLoaded(operators: operators));
    } catch (e) {
      emit(OperatorError(_errorMessage(e)));
    }
  }

  void select(OperatorEntity operator) {
    final current = state;
    if (current is OperatorLoaded) {
      emit(current.withSelected(operator));
    }
  }

  String _errorMessage(dynamic e) {
    if (e is RestClientException) return e.displayMessage;
    return 'Erro ao carregar operadores';
  }
}
