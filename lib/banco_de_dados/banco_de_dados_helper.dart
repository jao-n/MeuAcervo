import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../modelos/livro.dart';

/// Helper para gerenciar as operações do banco de dados SQLite.
class BancoDeDadosHelper {
  static final BancoDeDadosHelper _instancia = BancoDeDadosHelper._interno();
  factory BancoDeDadosHelper() => _instancia;
  BancoDeDadosHelper._interno();

  Database? _banco;

  /// Retorna a instância do banco de dados, inicializando-a se necessário.
  Future<Database> get banco async {
    if (_banco != null) return _banco!;
    _banco = await _inicializarBanco();
    return _banco!;
  }

  /// Inicializa o banco de dados SQLite.
  Future<Database> _inicializarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, 'meu_acervo.db');

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBanco,
    );
  }

  /// Cria a tabela de livros no banco de dados.
  Future _criarBanco(Database db, int versao) async {
    await db.execute('''
      CREATE TABLE livros(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        autor TEXT NOT NULL,
        descricao TEXT
      )
    ''');
  }

  /// Insere um novo livro no banco de dados.
  Future<int> inserirLivro(Livro livro) async {
    final db = await banco;
    return await db.insert('livros', livro.paraMapa());
  }

  /// Atualiza um livro existente no banco de dados.
  Future<int> atualizarLivro(Livro livro) async {
    final db = await banco;
    return await db.update(
      'livros',
      livro.paraMapa(),
      where: 'id = ?',
      whereArgs: [livro.id],
    );
  }

  /// Exclui um livro do banco de dados pelo ID.
  Future<int> excluirLivro(int id) async {
    final db = await banco;
    return await db.delete(
      'livros',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Busca todos os livros cadastrados, ordenados por título.
  Future<List<Livro>> buscarTodos() async {
    final db = await banco;
    final List<Map<String, dynamic>> mapas = await db.query(
      'livros',
      orderBy: 'titulo ASC',
    );
    return mapas.map((mapa) => Livro.deMapa(mapa)).toList();
  }

  /// Busca um livro específico pelo seu ID.
  Future<Livro?> buscarPorId(int id) async {
    final db = await banco;
    final List<Map<String, dynamic>> mapas = await db.query(
      'livros',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (mapas.isNotEmpty) {
      return Livro.deMapa(mapas.first);
    }
    return null;
  }
}
