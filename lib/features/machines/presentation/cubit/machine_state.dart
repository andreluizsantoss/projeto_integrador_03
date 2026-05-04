import 'package:equatable/equatable.dart';
import '../../domain/entities/machine_entity.dart';

sealed class MachineState extends Equatable {
  const MachineState();
  @override
  List<Object?> get props => [];
}

class MachineInitial extends MachineState {
  const MachineInitial();
}

class MachineLoading extends MachineState {
  const MachineLoading();
}

class MachineLoaded extends MachineState {
  final List<MachineEntity> machines;
  final MachineEntity? selected;

  const MachineLoaded({required this.machines, this.selected});

  MachineLoaded withSelected(MachineEntity m) =>
      MachineLoaded(machines: machines, selected: m);

  @override
  List<Object?> get props => [machines, selected];
}

class MachineError extends MachineState {
  final String message;
  const MachineError(this.message);
  @override
  List<Object?> get props => [message];
}
