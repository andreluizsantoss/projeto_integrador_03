import 'package:flutter/material.dart';
import 'package:projeto_integrador_03/views/app_widget.dart';
import 'package:projeto_integrador_03/core/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa a Injeção de Dependências
  setupDependencies();

  runApp(const AppWidget());
}
