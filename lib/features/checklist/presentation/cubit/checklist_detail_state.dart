import 'package:projeto_integrador_03/features/checklist/domain/entities/checklist_detail_entity.dart';

sealed class ChecklistDetailState {}

final class ChecklistDetailInitial extends ChecklistDetailState {}

final class ChecklistDetailLoading extends ChecklistDetailState {}

final class ChecklistDetailLoaded extends ChecklistDetailState {
  final ChecklistDetailEntity detail;
  ChecklistDetailLoaded(this.detail);
}

final class ChecklistDetailError extends ChecklistDetailState {
  final String message;
  ChecklistDetailError(this.message);
}
