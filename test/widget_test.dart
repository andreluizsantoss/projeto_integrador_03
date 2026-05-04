import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador_03/core/injection.dart';
import 'package:projeto_integrador_03/views/app_widget.dart';

void main() {
  setUpAll(setupDependencies);

  testWidgets('app builds without crashing', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AppWidget());
    await tester.pump();
    expect(find.byType(AppWidget), findsOneWidget);
  });
}
