import 'package:flutter/material.dart';

class AppVersion {
  static const String version = '1.0.0';
  static const String buildNumber = '1';
  static const String appName = 'Projeto Integrador 03';
}

class AppConfig {
  static const String title = AppVersion.appName;
  static final navigatorKey = GlobalKey<NavigatorState>();
}
