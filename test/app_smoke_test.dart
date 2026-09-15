import 'package:flutter_test/flutter_test.dart';
import 'package:good_food_scan/src/app.dart';

void main() {
  testWidgets('app starts', (tester) async {
    await tester.pumpWidget(const GoodFoodScanApp());
    await tester.pump();
    expect(find.text('Good Food Scan'), findsOneWidget);
  });
}
