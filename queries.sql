-- =====================================================================
-- Análise de Chamados de Suporte — SQL
-- Base: chamados.db (SQLite)
-- Tabelas: chamados, responsaveis
-- =====================================================================

-- 1. Chamados com prioridade Crítica
SELECT *
FROM chamados
WHERE prioridade = 'Crítica';


-- 2. Chamados ainda em aberto (Aberto ou Em andamento)
SELECT *
FROM chamados
WHERE status IN ('Aberto', 'Em andamento');


-- 3. Chamados abertos depois de 01/04/2026, do mais recente pro mais antigo
SELECT *
FROM chamados
WHERE data_abertura > '2026-04-01'
ORDER BY data_abertura DESC;


-- 4. Só id, categoria e status dos chamados de Hardware
SELECT id_chamado, categoria, status
FROM chamados
WHERE categoria = 'Hardware';


-- 5. Total de chamados cadastrados
SELECT COUNT(*) AS total_chamados
FROM chamados;


-- 6. Chamados sem data de resolução (ainda não fechados)
SELECT *
FROM chamados
WHERE data_resolucao IS NULL;


-- 7. Chamados que não são da categoria Rede
SELECT *
FROM chamados
WHERE categoria <> 'Rede';


-- 8. Chamado + nome do responsável (JOIN entre chamados e responsaveis)
SELECT c.id_chamado, c.categoria, r.nome AS responsavel
FROM chamados c
JOIN responsaveis r ON c.id_responsavel = r.id_responsavel;


-- 9. Chamados atendidos pela Ana Souza (JOIN + filtro pelo nome)
SELECT c.id_chamado, c.categoria, c.status
FROM chamados c
JOIN responsaveis r ON c.id_responsavel = r.id_responsavel
WHERE r.nome = 'Ana Souza';


-- 10. Quantidade de chamados por categoria
SELECT categoria, COUNT(*) AS qtd
FROM chamados
GROUP BY categoria
ORDER BY qtd DESC;


-- 11. Quantidade de chamados atendidos por cada responsável
SELECT r.nome, COUNT(*) AS qtd_atendida
FROM chamados c
JOIN responsaveis r ON c.id_responsavel = r.id_responsavel
GROUP BY r.nome
ORDER BY qtd_atendida DESC;


-- 12. Tempo médio de resolução (em dias), por prioridade
-- só considera chamados que já têm data de resolução
SELECT
    prioridade,
    ROUND(AVG(julianday(data_resolucao) - julianday(data_abertura)), 1) AS tempo_medio_dias
FROM chamados
WHERE data_resolucao IS NOT NULL
GROUP BY prioridade
ORDER BY tempo_medio_dias;


-- 13. Posição de cada chamado, em ordem de abertura, dentro da própria categoria
SELECT
    id_chamado,
    categoria,
    data_abertura,
    ROW_NUMBER() OVER (PARTITION BY categoria ORDER BY data_abertura) AS posicao_na_categoria
FROM chamados
ORDER BY categoria, posicao_na_categoria;


-- 14. Soma acumulada de chamados por categoria, ao longo do tempo
SELECT
    id_chamado,
    categoria,
    data_abertura,
    SUM(1) OVER (PARTITION BY categoria ORDER BY data_abertura) AS chamados_acumulados_categoria
FROM chamados
ORDER BY categoria, data_abertura;


-- 15. Top 3 categorias com mais chamados
SELECT categoria, COUNT(*) AS qtd
FROM chamados
GROUP BY categoria
ORDER BY qtd DESC
LIMIT 3;
