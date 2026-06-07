import 'package:flutter/material.dart';
import '../banco_de_dados/banco_de_dados_helper.dart';
import '../modelos/livro.dart';
import '../utils/constantes.dart';
import '../widgets/item_livro.dart';
import 'tela_cadastro.dart';
import 'tela_detalhes.dart';

/// Tela principal que exibe a lista de livros cadastrados.
class TelaLista extends StatefulWidget {
  const TelaLista({super.key});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  final BancoDeDadosHelper _dbHelper = BancoDeDadosHelper();
  List<Livro> _livros = [];
  bool _carregando = true;
  String? _erro;

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  /// Busca os livros no banco de dados e atualiza o estado da tela.
  Future<void> _atualizarLista() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      final livros = await _dbHelper.buscarTodos();
      if (!mounted) return;
      setState(() {
        _livros = livros;
        _carregando = false;
        _erro = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _livros = [];
        _carregando = false;
        _erro = e.toString();
      });
    }
  }

  /// Navega para a tela de cadastro e atualiza a lista ao retornar.
  void _navegarParaCadastro() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TelaCadastro()),
    );
    _atualizarLista();
  }

  /// Navega para a tela de detalhes e atualiza a lista ao retornar.
  void _navegarParaDetalhes(int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaDetalhes(livroId: id)),
    );
    _atualizarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constantes.listaFragmentLabel),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _erro != null
              ? Center(child: Text('Erro: ${_erro}'))
              : _livros.isEmpty
                  ? const Center(child: Text(Constantes.listaVazia))
                  : ListView.builder(
                      itemCount: _livros.length,
                      itemBuilder: (context, indice) {
                        final livro = _livros[indice];
                        return ItemLivro(
                          livro: livro,
                          aoTocar: () => _navegarParaDetalhes(livro.id!),
                        );
                      },
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaCadastro,
        tooltip: Constantes.descAdicionar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
