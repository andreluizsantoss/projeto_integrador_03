import 'package:flutter/material.dart';
import 'package:projeto_integrador_03/views/app_widget.dart';
import 'package:projeto_integrador_03/core/injection.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Inicializa a Injeção de Dependências
  setupDependencies();

  runApp(const AppWidget());
}
