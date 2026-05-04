class RestClientException implements Exception {
  final String? message;
  final String? apiMessage; // extraído de {"error": "..."} no body da resposta
  final int? statusCode;
  final dynamic error;
  final dynamic response;

  const RestClientException({
    this.message,
    this.apiMessage,
    this.statusCode,
    this.error,
    this.response,
  });

  /// Mensagem amigável para exibir ao usuário
  String get displayMessage => apiMessage ?? message ?? 'Erro desconhecido';

  @override
  String toString() =>
      'RestClientException(statusCode: $statusCode, apiMessage: $apiMessage, message: $message)';
}
