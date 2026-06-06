import 'package:flutter/material.dart';
import 'telas/tela_lista.dart';
import 'utils/constantes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MeuAcervoApp());
}

class MeuAcervoApp extends StatelessWidget {
  const MeuAcervoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constantes.appNome,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          primary: Colors.brown,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const TelaLista(),
    );
  }
}
