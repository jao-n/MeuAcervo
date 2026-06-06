/// Classe que representa um Livro no sistema.
class Livro {
  final int? id;
  final String titulo;
  final String autor;
  final String descricao;

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    this.descricao = '',
  });

  /// Converte o objeto Livro em um Map para ser salvo no SQLite.
  Map<String, dynamic> paraMapa() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'descricao': descricao,
    };
  }

  /// Cria um objeto Livro a partir de um Map vindo do SQLite.
  factory Livro.deMapa(Map<String, dynamic> mapa) {
    return Livro(
      id: mapa['id'] as int?,
      titulo: mapa['titulo'] as String,
      autor: mapa['autor'] as String,
      descricao: mapa['descricao'] as String? ?? '',
    );
  }

  /// Cria uma cópia do Livro com a possibilidade de alterar campos específicos.
  Livro copiarCom({
    int? id,
    String? titulo,
    String? autor,
    String? descricao,
  }) {
    return Livro(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      autor: autor ?? this.autor,
      descricao: descricao ?? this.descricao,
    );
  }
}
