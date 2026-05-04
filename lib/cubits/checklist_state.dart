import 'package:flutter/foundation.dart';
import 'package:projeto_integrador_03/features/items/domain/entities/checklist_item_entity.dart';

// Mapeamento: id_status da tabela status_inspecao
const int kStatusCompliant = 1;
const int kStatusNonCompliant = 2;
const int kStatusNeedsMaintenance = 3;

@immutable
class ChecklistState {
  final int operatorId;
  final String operatorName;
  final int machineId;
  final String machineName;

  // Itens carregados da API
  final List<ChecklistItemEntity> itens;

  // Respostas: itemId → statusId (null = não respondido)
  final Map<int, int?> respostas;

  // Nível de combustível selecionado na ChecklistFuelPage
  // (armazenado separadamente — não corresponde a item da API)
  final int? fuelLevel;

  // UI
  final bool isLoadingItens;
  final bool isSubmitting;
  final bool isSubmitSuccess;
  final String? error;

  const ChecklistState({
    this.operatorId = 0,
    this.operatorName = '',
    this.machineId = 0,
    this.machineName = '',
    this.itens = const [],
    this.respostas = const {},
    this.fuelLevel,
    this.isLoadingItens = false,
    this.isSubmitting = false,
    this.isSubmitSuccess = false,
    this.error,
  });

  // Normaliza strings para comparação de categoria (ignora acentos e maiúsculas)
  static String _norm(String s) => s
      .toLowerCase()
      .replaceAll(RegExp(r'[áàâã]'), 'a')
      .replaceAll(RegExp(r'[éèê]'), 'e')
      .replaceAll(RegExp(r'[íì]'), 'i')
      .replaceAll(RegExp(r'[óòôõ]'), 'o')
      .replaceAll(RegExp(r'[úùû]'), 'u')
      .replaceAll('ç', 'c')
      .trim();

  List<ChecklistItemEntity> itemsByCategory(String categoria) {
    final target = _norm(categoria);
    return itens.where((i) => _norm(i.category ?? '') == target).toList();
  }

  int? statusOf(int itemId) => respostas[itemId];

  bool isCategoryComplete(String categoria) {
    final items = itemsByCategory(categoria);
    if (items.isEmpty) return false;
    return items.every((i) => respostas[i.itemId] != null);
  }

  String sectionLevel(String categoria) {
    final items = itemsByCategory(categoria);
    if (items.isEmpty) return 'Nivel de situação';
    final statuses = items.map((i) => respostas[i.itemId]).toList();
    if (statuses.every((s) => s == null)) return 'Nivel de situação';
    if (statuses.any((s) => s == kStatusNonCompliant)) return 'Não Conforme';
    if (statuses.any((s) => s == kStatusNeedsMaintenance)) {
      return 'Precisa Manutenção';
    }
    return 'Conforme';
  }

  // Retorna o nível de combustível selecionado (independente dos itens da API)
  int? fuelStatus() => fuelLevel;

  String fuelLabel() {
    final status = fuelStatus();
    if (status == kStatusCompliant) return 'Cheio';
    if (status == kStatusNonCompliant) return 'Vazio';
    if (status == kStatusNeedsMaintenance) return 'Medio';
    return 'STATUS';
  }

  int completionPercent() {
    if (respostas.isEmpty) return 0;
    final preenchido = respostas.values.where((v) => v != null).length;
    return ((preenchido / respostas.length) * 100).round();
  }

  ChecklistState copyWith({
    int? operatorId,
    String? operatorName,
    int? machineId,
    String? machineName,
    List<ChecklistItemEntity>? itens,
    Map<int, int?>? respostas,
    Object? fuelLevel = _sentinel,
    bool? isLoadingItens,
    bool? isSubmitting,
    bool? isSubmitSuccess,
    Object? error = _sentinel,
  }) {
    return ChecklistState(
      operatorId: operatorId ?? this.operatorId,
      operatorName: operatorName ?? this.operatorName,
      machineId: machineId ?? this.machineId,
      machineName: machineName ?? this.machineName,
      itens: itens ?? this.itens,
      respostas: respostas ?? this.respostas,
      fuelLevel: identical(fuelLevel, _sentinel)
          ? this.fuelLevel
          : fuelLevel as int?,
      isLoadingItens: isLoadingItens ?? this.isLoadingItens,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitSuccess: isSubmitSuccess ?? this.isSubmitSuccess,
      error: identical(error, _sentinel) ? this.error : error as String?,
    );
  }

  static const _sentinel = Object();
}
