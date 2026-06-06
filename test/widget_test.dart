import 'package:flutter_test/flutter_test.dart';
import 'package:meu_acervo/main.dart';

void main() {
  testWidgets('Teste básico de fumaça', (WidgetTester tester) async {
    await tester.pumpWidget(const MeuAcervoApp());
    expect(find.text('Meus Livros'), findsOneWidget);
  });
}
