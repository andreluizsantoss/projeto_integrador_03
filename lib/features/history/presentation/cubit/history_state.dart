import 'package:equatable/equatable.dart';
import '../../domain/entities/history_entity.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> checklists;
  const HistoryLoaded(this.checklists);
  @override
  List<Object?> get props => [checklists];
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  List<Object?> get props => [message];
}
