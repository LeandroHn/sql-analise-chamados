# Análise de Chamados de Suporte — SQL

**Projeto |**

## Sobre o projeto

Banco de dados relacional simulando um sistema de controle de chamados de
suporte técnico, construído em SQLite. O projeto reúne 15 consultas SQL
que cobrem desde filtros simples até window functions, demonstrando
domínio prático da linguagem aplicada a um cenário real de negócio.

## Estrutura do banco

- **`responsaveis`** — cadastro dos atendentes (id, nome)
- **`chamados`** — registros de chamados (id, categoria, prioridade,
  status, responsável, datas de abertura e resolução)

As duas tabelas se relacionam pela coluna `id_responsavel`.

## Consultas incluídas (`queries.sql`)

| # | O que a query resolve |
|---|---|
| 1-4 | Filtros básicos (prioridade, status, data, colunas específicas) |
| 5-7 | Contagem geral, chamados sem resolução, exclusão por categoria |
| 8-9 | JOIN entre `chamados` e `responsaveis` para trazer nome do atendente |
| 10-12 | Agregações (GROUP BY): volume por categoria, por atendente, tempo médio de resolução por prioridade |
| 13-14 | Window functions: posição do chamado dentro da categoria, soma acumulada por categoria |
| 15 | Ranking das categorias com mais chamados (bônus) |

Cada query está comentada no arquivo `queries.sql` explicando o que faz.

## Habilidades demonstradas

- Modelagem de dados relacional simples (chave estrangeira)
- SELECT com filtros e ordenação
- JOIN entre tabelas
- Agregação com GROUP BY (COUNT, AVG)
- Window functions (ROW_NUMBER, SUM OVER)
- Cálculo de intervalo entre datas

## Ferramentas

SQLite (via DB Browser for SQLite)

## Arquivos neste repositório

## Arquivos

- 📄 [queries.sql](queries.sql): as 15 consultas comentadas
- 🗃️ [chamados.db](chamados.db): banco SQLite com os dados

**Autor:** [Leandro]
