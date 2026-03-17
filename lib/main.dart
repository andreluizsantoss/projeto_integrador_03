import 'package:flutter/material.dart';
import 'app_widget.dart';
import 'app/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa a Injeção de Dependências
  setupDependencies();

  runApp(const AppWidget());
}
