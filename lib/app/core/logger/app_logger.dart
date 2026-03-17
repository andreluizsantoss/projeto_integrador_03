import 'package:logger/logger.dart';

abstract interface class AppLogger {
  void d(String message, [dynamic error, StackTrace? stackTrace]);
  void i(String message, [dynamic error, StackTrace? stackTrace]);
  void w(String message, [dynamic error, StackTrace? stackTrace]);
  void e(String message, [dynamic error, StackTrace? stackTrace]);
  void f(String message, [dynamic error, StackTrace? stackTrace]);
}

class AppLoggerImpl implements AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  @override
  void d(String message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  @override
  void i(String message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  @override
  void w(String message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void e(String message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  @override
  void f(String message, [error, StackTrace? stackTrace]) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}
