--
-- Estrutura de Banco de Dados PostgreSQL para um projeto de investimento
-- (Versão com controle de usuários, categorias e permissões de acesso)
--

-- Tabela: Usuarios
-- Tabela para armazenar informações dos usuários do sistema.
CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_criacao TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    senha VARCHAR(255) NOT NULL
);

COMMENT ON TABLE Usuarios IS 'Tabela que armazena os usuários do sistema.';
COMMENT ON COLUMN Usuarios.id_usuario IS 'Identificador único do usuário.';
COMMENT ON COLUMN Usuarios.nome IS 'Nome completo do usuário.';
COMMENT ON COLUMN Usuarios.email IS 'Email do usuário (único).';
COMMENT ON COLUMN Usuarios.data_criacao IS 'Carimbo de data/hora de criação do registro do usuário.';
COMMENT ON COLUMN Usuarios.senha IS 'Hash da senha do usuário para autenticação.';


-- Tabela: Categorias_Investimento
-- Tabela para armazenar as categorias de investimento padronizadas.
CREATE TABLE Categorias_Investimento (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) UNIQUE NOT NULL
);

COMMENT ON TABLE Categorias_Investimento IS 'Tabela que armazena as categorias de investimento (ex: FIIs, Ações).';
COMMENT ON COLUMN Categorias_Investimento.id_categoria IS 'Identificador único da categoria.';
COMMENT ON COLUMN Categorias_Investimento.nome_categoria IS 'Nome da categoria (ex: Ações, Fundos Imobiliários).';

-- Tabela: Ativos
-- A tabela `Ativos` agora se relaciona com `Usuarios` e `Categorias_Investimento`.
CREATE TABLE Ativos (
    id_ativo SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT NOT NULL,
    codigo VARCHAR(20) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES Categorias_Investimento(id_categoria) ON DELETE CASCADE,
    UNIQUE (id_usuario, codigo)
);

COMMENT ON TABLE Ativos IS 'Tabela que armazena os ativos de investimento de cada usuário.';
COMMENT ON COLUMN Ativos.id_ativo IS 'Identificador único do ativo.';
COMMENT ON COLUMN Ativos.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Ativos.id_categoria IS 'Chave estrangeira para a tabela Categorias_Investimento.';
COMMENT ON COLUMN Ativos.codigo IS 'Código de negociação do ativo (ex: GARE11).';
COMMENT ON COLUMN Ativos.nome IS 'Nome completo do ativo (ex: FII GUARDIAN).';

-- As demais tabelas já dependem da tabela `Ativos`, portanto, não precisam de mudanças diretas.
-- Se um ativo é deletado, todas as transações, históricos e proventos relacionados são removidos.

-- Tabela: Historico_Patrimonio
-- Registra o histórico de saldo e preço médio do investidor para cada ativo.
CREATE TABLE Historico_Patrimonio (
    id_historico SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ativo INT NOT NULL,
    data DATE NOT NULL,
    alteracao VARCHAR(50),
    quantidade INT NOT NULL,
    novo_saldo INT NOT NULL,
    preco_medio NUMERIC(10, 4) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ativo) REFERENCES Ativos (id_ativo) ON DELETE CASCADE
);

COMMENT ON TABLE Historico_Patrimonio IS 'Histórico de alterações no saldo e preço médio por ativo de cada usuário.';
COMMENT ON COLUMN Historico_Patrimonio.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Historico_Patrimonio.id_ativo IS 'Chave estrangeira para a tabela Ativos.';
COMMENT ON COLUMN Historico_Patrimonio.data IS 'Data da alteração.';
COMMENT ON COLUMN Historico_Patrimonio.alteracao IS 'Descrição da alteração (ex: Negociação).';
COMMENT ON COLUMN Historico_Patrimonio.quantidade IS 'Quantidade de cotas negociadas.';
COMMENT ON COLUMN Historico_Patrimonio.novo_saldo IS 'Saldo total de cotas após a alteração.';
COMMENT ON COLUMN Historico_Patrimonio.preco_medio IS 'Preço médio por cota após a alteração.';

-- Tabela: Negociacoes
-- Detalha cada transação realizada (compra ou venda).
CREATE TABLE Negociacoes (
    id_negociacao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ativo INT NOT NULL,
    data DATE NOT NULL,
    corretora VARCHAR(50),
    tipo CHAR(1) NOT NULL CHECK (tipo IN ('C', 'V')),
    qtd INT NOT NULL,
    preco NUMERIC(10, 2) NOT NULL,
    total NUMERIC(10, 2),
    preco_com_taxas NUMERIC(10, 4),
    total_com_taxas NUMERIC(10, 2),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ativo) REFERENCES Ativos (id_ativo) ON DELETE CASCADE
);

COMMENT ON TABLE Negociacoes IS 'Registra cada transação de compra ou venda de um ativo por usuário.';
COMMENT ON COLUMN Negociacoes.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Negociacoes.id_ativo IS 'Chave estrangeira para a tabela Ativos.';
COMMENT ON COLUMN Negociacoes.tipo IS 'Tipo de transação: ''C'' para Compra, ''V'' para Venda.';
COMMENT ON COLUMN Negociacoes.qtd IS 'Quantidade de cotas negociadas.';
COMMENT ON COLUMN Negociacoes.preco IS 'Preço por cota sem taxas.';
COMMENT ON COLUMN Negociacoes.total IS 'Valor total da negociação sem taxas.';
COMMENT ON COLUMN Negociacoes.preco_com_taxas IS 'Preço por cota com taxas.';
COMMENT ON COLUMN Negociacoes.total_com_taxas IS 'Valor total da negociação com taxas.';

-- Tabela: Proventos
-- Armazena os proventos (rendimentos) recebidos.
CREATE TABLE Proventos (
    id_provento SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ativo INT NOT NULL,
    data_pagamento DATE NOT NULL,
    data_com DATE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valor_por_cota NUMERIC(10, 4) NOT NULL,
    total_recebido NUMERIC(10, 2),
    percentual_on_cost NUMERIC(5, 2),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ativo) REFERENCES Ativos (id_ativo) ON DELETE CASCADE
);

COMMENT ON TABLE Proventos IS 'Registra os proventos recebidos por um usuário de um ativo.';
COMMENT ON COLUMN Proventos.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Proventos.id_ativo IS 'Chave estrangeira para a tabela Ativos.';
COMMENT ON COLUMN Proventos.data_pagamento IS 'Data em que o provento foi pago.';
COMMENT ON COLUMN Proventos.data_com IS 'Data "COM", data de registro para receber o provento.';
COMMENT ON COLUMN Proventos.tipo IS 'Tipo de provento (ex: RENDIMENTO).';
COMMENT ON COLUMN Proventos.valor_por_cota IS 'Valor do provento por cota.';
COMMENT ON COLUMN Proventos.total_recebido IS 'Valor total recebido.';
COMMENT ON COLUMN Proventos.percentual_on_cost IS 'Percentual de rendimento sobre o custo.';


-- A tabela `Indicadores_Ativos` precisa de um relacionamento com `Usuarios`
-- para rastrear quais indicadores pertencem a cada usuário.
CREATE TABLE Indicadores_Ativos (
    id_indicador SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_ativo INT NOT NULL,
    data DATE NOT NULL,
    valor_mercado BIGINT,
    patrimonio BIGINT,
    p_vp NUMERIC(5, 2),
    retorno_12m_percentual NUMERIC(5, 2),
    retorno_12m_real NUMERIC(5, 2),
    variacao_12m NUMERIC(5, 2),
    preco_min_52sem NUMERIC(10, 2),
    preco_max_52sem NUMERIC(10, 2),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ativo) REFERENCES Ativos (id_ativo) ON DELETE CASCADE
);

COMMENT ON TABLE Indicadores_Ativos IS 'Armazena indicadores de mercado de um ativo para um usuário em uma data específica.';
COMMENT ON COLUMN Indicadores_Ativos.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Indicadores_Ativos.id_ativo IS 'Chave estrangeira para a tabela Ativos.';
COMMENT ON COLUMN Indicadores_Ativos.data IS 'Data do registro do indicador.';
COMMENT ON COLUMN Indicadores_Ativos.valor_mercado IS 'Valor de mercado do ativo.';
COMMENT ON COLUMN Indicadores_Ativos.patrimonio IS 'Patrimônio líquido do ativo.';
COMMENT ON COLUMN Indicadores_Ativos.p_vp IS 'Indicador Preço/Valor Patrimonial.';
COMMENT ON COLUMN Indicadores_Ativos.retorno_12m_percentual IS 'Retorno dos últimos 12 meses em porcentagem.';
COMMENT ON COLUMN Indicadores_Ativos.retorno_12m_real IS 'Retorno dos últimos 12 meses em valor real.';
COMMENT ON COLUMN Indicadores_Ativos.variacao_12m IS 'Variação percentual nos últimos 12 meses.';
COMMENT ON COLUMN Indicadores_Ativos.preco_min_52sem IS 'Preço mínimo nas últimas 52 semanas.';
COMMENT ON COLUMN Indicadores_Ativos.preco_max_52sem IS 'Preço máximo nas últimas 52 semanas.';

-- Tabelas para controle de acesso (Roles e Permissões)
CREATE TABLE Roles (
    id_role SERIAL PRIMARY KEY,
    nome_role VARCHAR(50) UNIQUE NOT NULL
);

COMMENT ON TABLE Roles IS 'Tabela que armazena os papéis de usuário (ex: Admin, Leitor).';
COMMENT ON COLUMN Roles.id_role IS 'Identificador único do papel.';
COMMENT ON COLUMN Roles.nome_role IS 'Nome do papel (ex: Admin, Leitor).';

CREATE TABLE Permissoes (
    id_permissao SERIAL PRIMARY KEY,
    nome_permissao VARCHAR(100) UNIQUE NOT NULL
);

COMMENT ON TABLE Permissoes IS 'Tabela que armazena as permissões granulares do sistema.';
COMMENT ON COLUMN Permissoes.id_permissao IS 'Identificador único da permissão.';
COMMENT ON COLUMN Permissoes.nome_permissao IS 'Nome da permissão (ex: criar_ativo, deletar_ativo).';

CREATE TABLE Usuario_Roles (
    id_usuario INT NOT NULL,
    id_role INT NOT NULL,
    PRIMARY KEY (id_usuario, id_role),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_role) REFERENCES Roles(id_role) ON DELETE CASCADE
);

COMMENT ON TABLE Usuario_Roles IS 'Tabela de junção para atribuir papéis a usuários (N:N).';

CREATE TABLE Role_Permissoes (
    id_role INT NOT NULL,
    id_permissao INT NOT NULL,
    PRIMARY KEY (id_role, id_permissao),
    FOREIGN KEY (id_role) REFERENCES Roles(id_role) ON DELETE CASCADE,
    FOREIGN KEY (id_permissao) REFERENCES Permissoes(id_permissao) ON DELETE CASCADE
);

COMMENT ON TABLE Role_Permissoes IS 'Tabela de junção para atribuir permissões a papéis (N:N).';

-- Tabela: Transacoes_Viagem
-- Tabela para registrar transações de viagem e conversões de moeda.
CREATE TABLE Transacoes_Viagem (
    id_transacao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    data DATE NOT NULL,
    valor_original NUMERIC(10, 2) NOT NULL,
    moeda_original VARCHAR(10) NOT NULL,
    valor_convertido NUMERIC(10, 2) NOT NULL,
    moeda_convertida VARCHAR(10) NOT NULL,
    taxa_conversao NUMERIC(10, 4) NOT NULL,
    tipo_transacao VARCHAR(50) NOT NULL,
    descricao VARCHAR(255),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

COMMENT ON TABLE Transacoes_Viagem IS 'Registra as transações de viagem e conversões de moeda de cada usuário.';
COMMENT ON COLUMN Transacoes_Viagem.id_transacao IS 'Identificador único da transação de viagem.';
COMMENT ON COLUMN Transacoes_Viagem.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Transacoes_Viagem.data IS 'Data da transação.';
COMMENT ON COLUMN Transacoes_Viagem.valor_original IS 'Valor gasto na moeda original.';
COMMENT ON COLUMN Transacoes_Viagem.moeda_original IS 'Moeda original da transação (ex: EUR, USD).';
COMMENT ON COLUMN Transacoes_Viagem.valor_convertido IS 'Valor da transação convertido para a moeda local (BRL).';
COMMENT ON COLUMN Transacoes_Viagem.moeda_convertida IS 'Moeda convertida (ex: BRL).';
COMMENT ON COLUMN Transacoes_Viagem.taxa_conversao IS 'Taxa de câmbio usada na conversão.';
COMMENT ON COLUMN Transacoes_Viagem.tipo_transacao IS 'Tipo de transação (ex: Wise, Cartão de Crédito).';
COMMENT ON COLUMN Transacoes_Viagem.descricao IS 'Descrição opcional da despesa.';

-- Tabela: Juros_Wise
-- Tabela para registrar os juros recebidos através do Wise Interest.
CREATE TABLE Juros_Wise (
    id_juros SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    data DATE NOT NULL,
    moeda VARCHAR(10) NOT NULL,
    valor_juros NUMERIC(10, 2) NOT NULL,
    saldo_base NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios (id_usuario) ON DELETE CASCADE
);

COMMENT ON TABLE Juros_Wise IS 'Registra os juros ganhos pelo usuário através do Wise Interest.';
COMMENT ON COLUMN Juros_Wise.id_juros IS 'Identificador único do registro de juros.';
COMMENT ON COLUMN Juros_Wise.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Juros_Wise.data IS 'Data em que os juros foram recebidos.';
COMMENT ON COLUMN Juros_Wise.moeda IS 'Moeda em que os juros foram recebidos (ex: USD, EUR).';
COMMENT ON COLUMN Juros_Wise.valor_juros IS 'Valor dos juros recebidos.';
COMMENT ON COLUMN Juros_Wise.saldo_base IS 'Saldo base sobre o qual os juros foram calculados.';

-- Tabela: Cartoes_Credito
-- Tabela para armazenar os cartões de crédito associados a um usuário.
CREATE TABLE Cartoes_Credito (
    id_cartao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome_cartao VARCHAR(100) NOT NULL,
    banco VARCHAR(100),
    tipo_cartao VARCHAR(50),
    bandeira VARCHAR(50),
    ultimos_quatro_digitos VARCHAR(4) NOT NULL,
    limite NUMERIC(10, 2),
    cor VARCHAR(20),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE
);

COMMENT ON TABLE Cartoes_Credito IS 'Armazena informações sobre os cartões de crédito de cada usuário.';
COMMENT ON COLUMN Cartoes_Credito.id_cartao IS 'Identificador único do cartão.';
COMMENT ON COLUMN Cartoes_Credito.id_usuario IS 'Chave estrangeira para a tabela Usuarios.';
COMMENT ON COLUMN Cartoes_Credito.nome_cartao IS 'Nome de exibição do cartão (ex: Nubank Roxinho).';
COMMENT ON COLUMN Cartoes_Credito.banco IS 'Nome do banco emissor do cartão.';
COMMENT ON COLUMN Cartoes_Credito.tipo_cartao IS 'Tipo do cartão (ex: Crédito).';
COMMENT ON COLUMN Cartoes_Credito.bandeira IS 'Bandeira do cartão (ex: Mastercard).';
COMMENT ON COLUMN Cartoes_Credito.ultimos_quatro_digitos IS 'Últimos 4 dígitos do cartão para identificação.';
COMMENT ON COLUMN Cartoes_Credito.limite IS 'Limite de crédito do cartão.';
COMMENT ON COLUMN Cartoes_Credito.cor IS 'Cor do cartão, para fins de personalização.';
COMMENT ON COLUMN Cartoes_Credito.ativo IS 'Indica se o cartão está ativo.';


--
-- Adicionando dados de exemplo para as tabelas
--

-- Inserindo dados na tabela Usuarios
INSERT INTO Usuarios (nome, email, senha) VALUES
('Ana Silva', 'ana.silva@example.com', '123456'),
('Bruno Costa', 'bruno.costa@example.com', '123456');

-- Inserindo dados na tabela Categorias_Investimento
INSERT INTO Categorias_Investimento (nome_categoria) VALUES
('Ações'),
('FIIs'),
('ETFs'),
('Criptomoedas');

-- Inserindo dados na tabela Ativos
-- Ana investe em um FII (FII Guardian) e uma Ação (PETR4)
INSERT INTO Ativos (id_usuario, id_categoria, codigo, nome) VALUES
(1, 2, 'GARE11', 'FII Guardian'),
(1, 1, 'PETR4', 'Petrobras S.A.'),
(2, 1, 'VALE3', 'Vale S.A.');

-- Inserindo dados na tabela Historico_Patrimonio
INSERT INTO Historico_Patrimonio (id_usuario, id_ativo, data, alteracao, quantidade, novo_saldo, preco_medio) VALUES
(1, 1, '2023-01-10', 'Compra inicial', 100, 100, 9.80),
(1, 1, '2023-02-15', 'Compra', 50, 150, 9.75),
(1, 2, '2023-03-01', 'Compra inicial', 200, 200, 30.50);

-- Inserindo dados na tabela Negociacoes
INSERT INTO Negociacoes (id_usuario, id_ativo, data, corretora, tipo, qtd, preco, total, preco_com_taxas, total_com_taxas) VALUES
(1, 1, '2023-01-10', 'XP Investimentos', 'C', 100, 9.80, 980.00, 9.82, 982.00),
(1, 1, '2023-02-15', 'XP Investimentos', 'C', 50, 9.70, 485.00, 9.75, 487.50),
(1, 2, '2023-03-01', 'NuInvest', 'C', 200, 30.50, 6100.00, 30.55, 6110.00);

-- Inserindo dados na tabela Proventos
INSERT INTO Proventos (id_usuario, id_ativo, data_pagamento, data_com, tipo, valor_por_cota, total_recebido) VALUES
(1, 1, '2023-03-17', '2023-03-15', 'RENDIMENTO', 0.80, 120.00),
(1, 2, '2023-04-10', '2023-04-05', 'JCP', 0.55, 110.00);

-- Inserindo dados na tabela Indicadores_Ativos
INSERT INTO Indicadores_Ativos (id_usuario, id_ativo, data, valor_mercado, patrimonio, p_vp, retorno_12m_percentual, variacao_12m) VALUES
(1, 1, '2023-06-01', 5000000000, 5200000000, 0.96, 12.50, 10.00),
(1, 2, '2023-06-01', 400000000000, 380000000000, 1.05, 15.00, 13.50);

-- Inserindo dados na tabela Roles
INSERT INTO Roles (nome_role) VALUES
('admin'),
('user');

-- Inserindo dados na tabela Permissoes
INSERT INTO Permissoes (nome_permissao) VALUES
('read_all'),
('write_ativo'),
('delete_ativo');

-- Inserindo dados na tabela Usuario_Roles
INSERT INTO Usuario_Roles (id_usuario, id_role) VALUES
(1, 1), -- Ana é admin
(2, 2); -- Bruno é user

-- Inserindo dados na tabela Role_Permissoes
INSERT INTO Role_Permissoes (id_role, id_permissao) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 2);

-- Inserindo dados na tabela Transacoes_Viagem
INSERT INTO Transacoes_Viagem (id_usuario, data, valor_original, moeda_original, valor_convertido, moeda_convertida, taxa_conversao, tipo_transacao, descricao) VALUES
(1, '2023-05-20', 100.00, 'USD', 480.00, 'BRL', 4.80, 'Wise', 'Compra de passagem aérea'),
(1, '2023-05-22', 50.00, 'USD', 242.50, 'BRL', 4.85, 'Cartão de Crédito', 'Jantar em restaurante');

-- Inserindo dados na tabela Juros_Wise
INSERT INTO Juros_Wise (id_usuario, data, moeda, valor_juros, saldo_base) VALUES
(1, '2023-06-01', 'USD', 1.50, 300.00),
(1, '2023-07-01', 'USD', 1.85, 350.00);

-- Inserindo dados na tabela Cartoes_Credito
INSERT INTO Cartoes_Credito (id_usuario, nome_cartao, banco, tipo_cartao, bandeira, ultimos_quatro_digitos, limite, cor) VALUES
(1, 'Meu Cartão Nubank', 'Nubank', 'Crédito', 'Mastercard', '1234', 5000.00, '#8205BA'),
(2, 'Cartão Inter', 'Inter', 'Crédito', 'Visa', '5678', 8000.00, '#FF8A00');
