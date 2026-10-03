import 'package:flutter_test/flutter_test.dart';
import 'package:fitflow/main.dart';

void main() {
  testWidgets('shows the FitFlow Daily Flow', (tester) async {
    await tester.pumpWidget(const FitFlowApp());

    expect(find.text('Good morning, Alex'), findsOneWidget);
    expect(find.text('Strength express'), findsOneWidget);
    expect(find.text('Start workout'), findsOneWidget);
  });
}
