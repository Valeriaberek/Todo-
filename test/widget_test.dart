import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:todo/main.dart';
import 'package:todo/theme/theme_provider.dart';

void main() {
  testWidgets('todo page shows the input field', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MyApp(),
      ),
    );

    expect(find.text('Nouvelle tâche'), findsOneWidget);
  });
}
