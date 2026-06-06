import 'package:flutter/material.dart';
import '../modelos/livro.dart';

/// Widget que exibe um item de livro na lista.
class ItemLivro extends StatelessWidget {
  final Livro livro;
  final VoidCallback aoTocar;

  const ItemLivro({
    super.key,
    required this.livro,
    required this.aoTocar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          livro.titulo,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(livro.autor),
        trailing: const Icon(Icons.chevron_right),
        onTap: aoTocar,
      ),
    );
  }
}
