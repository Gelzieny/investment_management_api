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
    senha VARCHAR(100) NOT NULL
);

COMMENT ON TABLE Usuarios IS 'Tabela que armazena os usuários do sistema.';
COMMENT ON COLUMN Usuarios.id_usuario IS 'Identificador único do usuário.';
COMMENT ON COLUMN Usuarios.nome IS 'Nome completo do usuário.';
COMMENT ON COLUMN Usuarios.email IS 'Email do usuário (único).';
COMMENT ON COLUMN Usuarios.data_criacao IS 'Carimbo de data/hora de criação do registro do usuário.';

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
