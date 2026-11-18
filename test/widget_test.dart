import 'package:flutter_test/flutter_test.dart';
import 'package:assignment/main.dart';

void main() {
  testWidgets('Excess Baggage Calculator smoke test',
          (WidgetTester tester) async {
        await tester.pumpWidget(const BaggageCalculatorApp());

        expect(
          find.text('Excess Baggage Calculator'),
          findsOneWidget,
        );

        expect(
          find.text('Calculate Your Excess Baggage Fee'),
          findsOneWidget,
        );

        // Check the default selected class.
        expect(
          find.text('Economy (20kg allowance)'),
          findsOneWidget,
        );
      });
}