import 'package:bibliotheca_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Bibliotheca home page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BibliothecaApp());
    await tester.pumpAndSettle();

    expect(find.text('Bienvenue sur Bibliotheca'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Livres'), findsOneWidget);
    expect(find.text('Auteurs'), findsOneWidget);
  });
}
