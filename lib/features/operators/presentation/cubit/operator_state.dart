import 'package:equatable/equatable.dart';
import 'package:projeto_integrador_03/features/auth/domain/entities/operator_entity.dart';

sealed class OperatorState extends Equatable {
  const OperatorState();
  @override
  List<Object?> get props => [];
}

class OperatorInitial extends OperatorState {
  const OperatorInitial();
}

class OperatorLoading extends OperatorState {
  const OperatorLoading();
}

class OperatorLoaded extends OperatorState {
  final List<OperatorEntity> operators;
  final OperatorEntity? selected;

  const OperatorLoaded({required this.operators, this.selected});

  OperatorLoaded withSelected(OperatorEntity op) =>
      OperatorLoaded(operators: operators, selected: op);

  @override
  List<Object?> get props => [operators, selected];
}

class OperatorError extends OperatorState {
  final String message;
  const OperatorError(this.message);
  @override
  List<Object?> get props => [message];
}
