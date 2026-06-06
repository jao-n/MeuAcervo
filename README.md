# MeuAcervo - Versão Flutter

Este projeto é uma refatoração do aplicativo original Android para a tecnologia **Flutter**, atendendo aos requisitos da disciplina.

## Funcionalidades
- **Listagem**: Visualização de todos os livros cadastrados, ordenados por título.
- **Cadastro**: Adição de novos livros com título, autor e descrição.
- **Detalhes**: Visualização completa das informações de um livro.
- **Edição**: Alteração de dados de livros já existentes.
- **Exclusão**: Remoção de livros com diálogo de confirmação.
- **Persistência**: Armazenamento local utilizando SQLite (`sqflite`).

## Tecnologias Utilizadas
- **Dart** com Null Safety.
- **Flutter** (Material 3).
- **sqflite** para banco de dados local.
- **path_provider** para localização de arquivos.

## Requisitos Acadêmicos Atendidos
1. **Código em Português**: Todo o código-fonte (variáveis, classes, comentários, pastas e interface) está em português brasileiro.
2. **Correção de Problemas**: Foram resolvidos os 10 problemas identificados na versão original Android, incluindo:
   - Uso de `mounted` para callbacks seguros.
   - Navegação passando argumentos diretamente nos construtores.
   - Validação de formulários com `GlobalKey<FormState>`.
   - Uso de `FutureBuilder` para operações assíncronas.
   - Listas eficientes com `ListView.builder`.

## Como Rodar o Projeto

1. Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
2. Abra o terminal na raiz do projeto (`C:/develop/MeuAcervo-main/`).
3. Execute o comando para baixar as dependências:
   ```bash
   flutter pub get
   ```
4. Conecte um emulador ou dispositivo físico.
5. Execute o aplicativo:
   ```bash
   flutter run
   ```

## Estrutura de Pastas (`lib/`)
- `banco_de_dados/`: Contém o helper do SQLite.
- `modelos/`: Definição da classe `Livro`.
- `telas/`: Telas do aplicativo (lista, cadastro, detalhes).
- `utils/`: Constantes de texto e configurações.
- `widgets/`: Componentes visuais reutilizáveis.
