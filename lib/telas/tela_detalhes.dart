import 'package:flutter/material.dart';
import '../banco_de_dados/banco_de_dados_helper.dart';
import '../modelos/livro.dart';
import '../utils/constantes.dart';
import 'tela_cadastro.dart';

/// Tela que exibe os detalhes de um livro específico.
class TelaDetalhes extends StatefulWidget {
  final int livroId;

  const TelaDetalhes({super.key, required this.livroId});

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  final BancoDeDadosHelper _dbHelper = BancoDeDadosHelper();
  late Future<Livro?> _futureLivro;

  @override
  void initState() {
    super.initState();
    _carregarLivro();
  }

  /// Inicia o carregamento do livro pelo ID.
  void _carregarLivro() {
    setState(() {
      _futureLivro = _dbHelper.buscarPorId(widget.livroId);
    });
  }

  /// Navega para a tela de edição e recarrega os dados ao retornar.
  void _editarLivro(Livro livro) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaCadastro(livroParaEditar: livro),
      ),
    );

    if (resultado == true) {
      _carregarLivro();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constantes.detalhesFragmentLabel),
      ),
      body: FutureBuilder<Livro?>(
        future: _futureLivro,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Livro não encontrado.'));
          }

          final livro = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  livro.titulo,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Autor: ${livro.autor}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(height: 32),
                const Text(
                  'Descrição:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  livro.descricao.isEmpty
                      ? 'Nenhuma descrição informada.'
                      : livro.descricao,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _editarLivro(livro),
                    icon: const Icon(Icons.edit),
                    label: const Text(Constantes.botaoEditar),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
