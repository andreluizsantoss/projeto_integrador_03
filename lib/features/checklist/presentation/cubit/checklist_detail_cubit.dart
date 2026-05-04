import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projeto_integrador_03/features/checklist/domain/repositories/checklist_repository.dart';
import 'checklist_detail_state.dart';

class ChecklistDetailCubit extends Cubit<ChecklistDetailState> {
  final ChecklistRepository _repository;

  ChecklistDetailCubit(this._repository) : super(ChecklistDetailInitial());

  Future<void> fetchById(int checklistId) async {
    emit(ChecklistDetailLoading());
    try {
      final detail = await _repository.getDetail(checklistId);
      emit(ChecklistDetailLoaded(detail));
    } catch (e) {
      emit(ChecklistDetailError(e.toString()));
    }
  }
}
