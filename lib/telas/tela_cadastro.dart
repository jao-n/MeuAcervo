import 'package:flutter/material.dart';
import '../banco_de_dados/banco_de_dados_helper.dart';
import '../modelos/livro.dart';
import '../utils/constantes.dart';

/// Tela de formulário para cadastrar ou editar um livro.
class TelaCadastro extends StatefulWidget {
  final Livro? livroParaEditar;

  const TelaCadastro({super.key, this.livroParaEditar});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final BancoDeDadosHelper _dbHelper = BancoDeDadosHelper();

  late TextEditingController _tituloController;
  late TextEditingController _autorController;
  late TextEditingController _descricaoController;

  bool get _estaEditando => widget.livroParaEditar != null;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.livroParaEditar?.titulo ?? '');
    _autorController = TextEditingController(text: widget.livroParaEditar?.autor ?? '');
    _descricaoController = TextEditingController(text: widget.livroParaEditar?.descricao ?? '');
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  /// Valida o formulário e salva ou atualiza o livro no banco de dados.
  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: widget.livroParaEditar?.id,
        titulo: _tituloController.text,
        autor: _autorController.text,
        descricao: _descricaoController.text,
      );

      if (_estaEditando) {
        await _dbHelper.atualizarLivro(livro);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Constantes.msgAtualizado)),
        );
      } else {
        await _dbHelper.inserirLivro(livro);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Constantes.msgAdicionado)),
        );
      }

      Navigator.pop(context, true);
    }
  }

  /// Exibe um diálogo de confirmação e exclui o livro se confirmado.
  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constantes.dialogoExcluirTitulo),
        content: const Text(Constantes.dialogoExcluirMsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(Constantes.botaoCancelar),
          ),
          TextButton(
            onPressed: () async {
              await _dbHelper.excluirLivro(widget.livroParaEditar!.id!);
              if (!mounted) return;

              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context); // Fecha o diálogo
              Navigator.pop(context, true); // Volta para a tela anterior (lista)

              messenger.showSnackBar(
                const SnackBar(content: Text(Constantes.msgExcluido)),
              );
            },
            child: const Text(Constantes.botaoConfirmar),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_estaEditando ? Constantes.edicaoFragmentLabel : Constantes.cadastroFragmentLabel),
        actions: [
          if (_estaEditando)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _confirmarExclusao,
              tooltip: Constantes.botaoExcluir,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: Constantes.dicaTitulo,
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return Constantes.msgPreencherCampos;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _autorController,
                decoration: const InputDecoration(
                  labelText: Constantes.dicaAutor,
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return Constantes.msgPreencherCampos;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: Constantes.dicaDescricao,
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(Constantes.botaoSalvar),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
