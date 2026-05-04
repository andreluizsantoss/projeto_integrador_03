import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/core/rest_client/rest_client_exception.dart';
import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';
import 'package:projeto_integrador_03/features/checklist/domain/repositories/checklist_repository.dart';
import 'package:projeto_integrador_03/features/items/domain/repositories/item_repository.dart';
import 'package:projeto_integrador_03/features/machines/domain/entities/machine_entity.dart';
import 'checklist_state.dart';

class ChecklistCubit extends Cubit<ChecklistState> {
  final ChecklistRepository _checklistRepository;
  final ItemRepository _itemRepository;

  ChecklistCubit({
    required ChecklistRepository checklistRepository,
    required ItemRepository itemRepository,
  }) : _checklistRepository = checklistRepository,
       _itemRepository = itemRepository,
       super(const ChecklistState());

  Future<void> start(OperatorEntity operator, MachineEntity machine) async {
    emit(
      ChecklistState(
        operatorId: operator.operatorId,
        operatorName: operator.nome,
        machineId: machine.machineId,
        machineName: machine.machineName,
        isLoadingItens: true,
      ),
    );

    try {
      final itens = await _itemRepository.fetchAll();
      final respostas = <int, int?>{
        for (final item in itens) item.itemId: null,
      };

      emit(
        state.copyWith(
          itens: itens,
          respostas: respostas,
          isLoadingItens: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingItens: false, error: _errorMessage(e)));
    }
  }

  // Toggle: se mesmo status, desseleciona; senão, seleciona
  void setAnswer(int itemId, int statusId) {
    final updated = Map<int, int?>.from(state.respostas);
    updated[itemId] = updated[itemId] == statusId ? null : statusId;
    emit(state.copyWith(respostas: updated));
  }

  // Toggle do nível de combustível (Cheio/Medio/Vazio)
  void setFuelLevel(int level) {
    final newLevel = state.fuelLevel == level ? null : level;
    emit(state.copyWith(fuelLevel: newLevel));
  }

  Future<void> submit() async {
    emit(state.copyWith(isSubmitting: true, error: null));

    try {
      // 1. Cria o cabeçalho do checklist
      final checklist = await _checklistRepository.create(
        operatorId: state.operatorId,
        machineId: state.machineId,
      );

      // 2. Envia as respostas (apenas as preenchidas)
      final answers = state.respostas.entries
          .where((e) => e.value != null)
          .map((e) => AnswerInput(itemId: e.key, statusId: e.value!))
          .toList();

      if (answers.isNotEmpty) {
        await _checklistRepository.saveAnswers(
          checklistId: checklist.checklistId,
          answers: answers,
        );
      }

      emit(state.copyWith(isSubmitting: false, isSubmitSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: _errorMessage(e)));
    }
  }

  void reset() => emit(const ChecklistState());

  String _errorMessage(dynamic e) {
    if (e is RestClientException) return e.displayMessage;
    return 'Erro inesperado. Tente novamente.';
  }
}
