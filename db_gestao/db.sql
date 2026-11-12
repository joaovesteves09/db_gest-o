-- CREATE TABLE colaboradores (
--     id SERIAL PRIMARY KEY,
--     nome VARCHAR(100) NOT NULL,
--     email VARCHAR(100) UNIQUE NOT NULL,
--     senha TEXT NOT NULL,
--     ativo BOOLEAN DEFAULT TRUE
-- );

-- CREATE TABLE categorias (
--     id SERIAL PRIMARY KEY,
--     nome VARCHAR(50) UNIQUE NOT NULL
-- );

-- CREATE TABLE projetos (
--     id SERIAL PRIMARY KEY,
--     nome VARCHAR(100) NOT NULL,
--     descricao TEXT
-- );

-- CREATE TABLE tarefas (
--     id SERIAL PRIMARY KEY,
--     titulo VARCHAR(100) NOT NULL,
--     descricao TEXT,
--     colaborador_id INTEGER NOT NULL REFERENCES colaboradores(id),
--     categoria_id INTEGER NOT NULL REFERENCES categorias(id),
--     projeto_id INTEGER NOT NULL REFERENCES projetos(id),
--     prazo DATE NOT NULL,
--     status VARCHAR(30) DEFAULT 'Pendente'
--         CHECK (status IN ('Pendente', 'Em andamento', 'Concluída')),
--     data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- CREATE TABLE historico_tarefas (
--     id SERIAL PRIMARY KEY,
--     tarefa_id INTEGER NOT NULL REFERENCES tarefas(id),
--     descricao TEXT NOT NULL,
--     data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- INSERT INTO colaboradores (nome, email, senha, ativo)
-- VALUES
-- ('João Silva', 'joao@email.com', '123456', TRUE),
-- ('Maria Souza', 'maria@email.com', '654321', TRUE),
-- ('Pedro Santos', 'pedro@email.com', '123123', TRUE);


-- INSERT INTO categorias (nome)
-- VALUES
-- ('Desenvolvimento'),
-- ('Planejamento'),
-- ('Design');

-- -- PROJETOS

-- INSERT INTO projetos (nome, descricao)
-- VALUES
-- ('Sistema Web', 'Criação de um sistema web'),
-- ('Aplicativo', 'Desenvolvimento de aplicativo'),
-- ('Site Empresarial', 'Criação de site para empresa');


-- INSERT INTO tarefas
-- (titulo, descricao, colaborador_id, categoria_id, projeto_id, prazo, status)
-- VALUES
-- ('Criar página inicial', 'Desenvolver a tela inicial', 1, 1, 1, '2026-11-20', 'Pendente'),

-- ('Organizar cronograma', 'Definir datas do projeto', 2, 2, 2, '2026-11-15', 'Em andamento'),

-- ('Criar logotipo', 'Desenvolver identidade visual', 3, 3, 3, '2026-11-25', 'Concluída');


-- FUNÇÃO DE HISTÓRICO

-- CREATE OR REPLACE FUNCTION fn_registrar_historico()
-- RETURNS TRIGGER AS $$
-- BEGIN

--     INSERT INTO historico_tarefas (tarefa_id, descricao)
--     VALUES (
--         NEW.id,
--         'Tarefa cadastrada no sistema'
--     );

--     RETURN NEW;

-- END;
-- $$ LANGUAGE plpgsql;


-- CREATE TRIGGER trg_registrar_historico
-- AFTER INSERT ON tarefas
-- FOR EACH ROW
-- EXECUTE FUNCTION fn_registrar_historico();


-- CREATE OR REPLACE FUNCTION fn_buscar_colaboradores(termo TEXT)
-- RETURNS TABLE (
--     id INTEGER,
--     nome VARCHAR(100),
--     email VARCHAR(100)
-- )
-- AS $$
-- BEGIN

--     RETURN QUERY
--     SELECT c.id, c.nome, c.email
--     FROM colaboradores c
--     WHERE c.nome ILIKE '%' || termo || '%'
--        OR c.email ILIKE '%' || termo || '%';

-- END;
-- $$ LANGUAGE plpgsql;

-- -- CREATE OR REPLACE VIEW vw_painel_principal AS
-- -- SELECT
-- --     c.nome AS colaborador,
-- --     t.titulo AS tarefa,
-- --     ca.nome AS categoria,
-- --     t.prazo,
-- --     t.status
-- -- FROM tarefas t
-- -- JOIN colaboradores c ON t.colaborador_id = c.id
-- -- JOIN categorias ca ON t.categoria_id = ca.id;


-- CREATE OR REPLACE VIEW vw_cronograma_prazos AS
-- SELECT
--     t.titulo AS tarefa,
--     c.nome AS responsavel,
--     t.prazo,
--     t.status,
--     (t.prazo - CURRENT_DATE) AS dias_restantes
-- FROM tarefas t
-- JOIN colaboradores c ON t.colaborador_id = c.id
-- ORDER BY t.prazo ASC, t.id ASC;

