class ChecklistAnswerEntity {
  final int answerId;
  final int itemId;
  final int statusId;
  final String? observation;
  final String itemDescription;
  final String itemCategory;
  final String statusDescription;

  const ChecklistAnswerEntity({
    required this.answerId,
    required this.itemId,
    required this.statusId,
    this.observation,
    required this.itemDescription,
    required this.itemCategory,
    required this.statusDescription,
  });
}

class ChecklistDetailEntity {
  final int checklistId;
  final int operatorId;
  final int machineId;
  final int? shiftId;
  final String data;
  final String operatorName;
  final String machineName;
  final List<ChecklistAnswerEntity> answers;

  const ChecklistDetailEntity({
    required this.checklistId,
    required this.operatorId,
    required this.machineId,
    this.shiftId,
    required this.data,
    required this.operatorName,
    required this.machineName,
    required this.answers,
  });

  List<String> get categories {
    final seen = <String>{};
    return answers.map((a) => a.itemCategory).where(seen.add).toList();
  }

  List<ChecklistAnswerEntity> answersByCategory(String category) =>
      answers.where((a) => a.itemCategory == category).toList();
}
