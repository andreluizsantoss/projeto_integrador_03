import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/core/rest_client/rest_client_exception.dart';
import '../../domain/entities/machine_entity.dart';
import '../../domain/repositories/machine_repository.dart';
import 'machine_state.dart';

class MachineCubit extends Cubit<MachineState> {
  final MachineRepository _repository;

  MachineCubit(this._repository) : super(const MachineInitial());

  Future<void> fetchAll() async {
    emit(const MachineLoading());
    try {
      final machines = await _repository.fetchAll();
      emit(MachineLoaded(machines: machines));
    } catch (e) {
      emit(MachineError(_errorMessage(e)));
    }
  }

  void select(MachineEntity machine) {
    final current = state;
    if (current is MachineLoaded) {
      emit(current.withSelected(machine));
    }
  }

  String _errorMessage(dynamic e) {
    if (e is RestClientException) return e.displayMessage;
    return 'Erro ao carregar máquinas';
  }
}
