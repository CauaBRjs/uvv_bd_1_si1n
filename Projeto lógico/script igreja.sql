-- Criando usuário do banco de dandos Igreja

CREATE USER grupo7 WITH
  NOSUPERUSER
  CREATEDB
  CREATEROLE
  LOGIN
  ENCRYPTED PASSWORD '123456'
;

-- Criando banco de dados Igreja

CREATE DATABASE igreja WITH
  owner      = grupo7
  template   = template0
  encoding   = 'UTF-8'
  lc_collate = 'pt_BR.UTF-8'
  lc_ctype   = 'pt_BR.UTF-8'
;

COMMENT ON DATABASE igreja IS 'Banco de dados do Sistema Igreja';

-- Criação do schema "sistema".

CREATE SCHEMA sistema AUTHORIZATION grupo7;
COMMENT ON SCHEMA sistema IS 'Schema para Sistema Igreja.';

-- Configura o SEARCH_PATH do usuário grupo7.
ALTER USER grupo7 SET SEARCH_PATH TO sistema, "$user", public;

-- Ajusta o SEARCH_PATH da conexão atual ao banco de dados.
SET SEARCH_PATH TO sistema, "$user", public;

-- Criando tabela doações

CREATE TABLE doacoes (
                codigo_doacao VARCHAR(4) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                data_doacao DATE NOT NULL,
                identificacao_doador VARCHAR(50),
                CONSTRAINT doacoes_pk PRIMARY KEY (codigo_doacao)
);

-- Criando tabela "trabalhos"

CREATE TABLE trabalhos (
                codigo_doacao VARCHAR(4) NOT NULL,
                tipo_trabalho VARCHAR(15) NOT NULL,
                tipo_trabalho_1 VARCHAR(50) NOT NULL,
                CONSTRAINT trabalhos_pk PRIMARY KEY (codigo_doacao)
);

-- Criando tabela "disponibilidade"

CREATE TABLE disponibilidade (
                codigo_doacao VARCHAR(4) NOT NULL,
                dias_disponibilidade DATE NOT NULL,
                horarios_disponibilidade TIME NOT NULL,
                CONSTRAINT disponibilidade_pk PRIMARY KEY (codigo_doacao, dias_disponibilidade)
);

-- Criando tabela "bens"

CREATE TABLE bens (
                codigo_doacao VARCHAR(4) NOT NULL,
                descricao VARCHAR(200) NOT NULL,
                tipo VARCHAR(200) NOT NULL,
                CONSTRAINT bens_pk PRIMARY KEY (codigo_doacao)
);

-- Criando tabela "monetarios"

CREATE TABLE monetarios (
                codigo_doacao VARCHAR(4) NOT NULL,
                valor VARCHAR NOT NULL,
                tipo_moeda VARCHAR,
                CONSTRAINT monetarios_pk PRIMARY KEY (codigo_doacao)
);

-- Criando tabela "atendidos"

CREATE TABLE atendidos (
                codigo_atendido VARCHAR(4) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                cpf VARCHAR(11),
                cnpj VARCHAR(12),
                CONSTRAINT atendidos_pk PRIMARY KEY (codigo_atendido)
);

-- Criando tabela "telefones_atendidos"


CREATE TABLE telefones_atendidos (
                codigo_atendido VARCHAR(4) NOT NULL,
                numero_atendido VARCHAR(12) NOT NULL,
                CONSTRAINT telefones_atendidos_pk PRIMARY KEY (codigo_atendido, numero_atendido)
);

-- Criando tabela "imagens"

CREATE TABLE imagens (
                codigo_imagem VARCHAR(4) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                descricao VARCHAR(200) NOT NULL,
                data_registro DATE NOT NULL,
                CONSTRAINT imagens_pk PRIMARY KEY (codigo_imagem)
);

-- Criando tabela "registram"

CREATE TABLE registram (
                codigo_imagem VARCHAR(4) NOT NULL,
                CONSTRAINT registram_pk PRIMARY KEY (codigo_imagem)
);

-- Criando tabela "destinacoes

CREATE TABLE destinacoes (
                codigo_atendido VARCHAR(4) NOT NULL,
                codigo_doacao VARCHAR(4) NOT NULL,
                data DATE NOT NULL,
                recebedor VARCHAR(50) NOT NULL,
                observacoes VARCHAR(200),
                codigo_imagem VARCHAR(4) NOT NULL,
                CONSTRAINT destinacoes_pk PRIMARY KEY (codigo_atendido, codigo_doacao)
);

-- Criando tabela "usam_atendidos"

CREATE TABLE usam_atendidos (
                codigo_imagem VARCHAR(4) NOT NULL,
                codigo_atendido VARCHAR(4) NOT NULL,
                CONSTRAINT usam_atendidos_pk PRIMARY KEY (codigo_imagem, codigo_atendido)
);

-- Criando tabela "comunidades"

CREATE TABLE comunidades (
                codigo_comunidade VARCHAR(4) NOT NULL,
                noime VARCHAR(50) NOT NULL,
                endereco VARCHAR(25) NOT NULL,
                email VARCHAR(30),
                CONSTRAINT comunidades_pk PRIMARY KEY (codigo_comunidade)
);

-- Criando tabela "cadastram"

CREATE TABLE cadastram (
                codigo_comunidade VARCHAR(4) NOT NULL,
                codigo_atendido VARCHAR(4) NOT NULL,
                CONSTRAINT cadastram_pk PRIMARY KEY (codigo_comunidade, codigo_atendido)
);

-- Criando tabela "usam_comunidades"

CREATE TABLE usam_comunidades (
                codigo_comunidade VARCHAR(4) NOT NULL,
                codigo_imagem VARCHAR(4) NOT NULL,
                CONSTRAINT usam_comunidades_pk PRIMARY KEY (codigo_comunidade, codigo_imagem)
);

-- Criando tabela "telefones_comunidade"

CREATE TABLE telefones_comunidade (
                codigo_comunidade VARCHAR(4) NOT NULL,
                numero_comunidade VARCHAR(12) NOT NULL,
                CONSTRAINT telefones_comunidade_pk PRIMARY KEY (codigo_comunidade, numero_comunidade)
);

-- Criando tabela "programas"

CREATE TABLE programas (
                codigo_programa VARCHAR(6) NOT NULL,
                nome VARCHAR(10) NOT NULL,
                descricao VARCHAR(200) NOT NULL,
                data_prevista DATE,
                descricao_1 VARCHAR(25) NOT NULL,
                data_inicio DATE NOT NULL,
                CONSTRAINT programas_pk PRIMARY KEY (codigo_programa)
);


CREATE TABLE usam_programas (
                codigo_programa VARCHAR(6) NOT NULL,
                codigo_imagem VARCHAR(4) NOT NULL,
                CONSTRAINT usam_programas_pk PRIMARY KEY (codigo_programa, codigo_imagem)
);

-- Criando tabela "usam_programas"

CREATE TABLE desenvolvem (
                codigo_programa VARCHAR(6) NOT NULL,
                codigo_comunidade VARCHAR(4) NOT NULL,
                CONSTRAINT desenvolvem_pk PRIMARY KEY (codigo_programa, codigo_comunidade)
);

-- Criando tabela "membros"

CREATE TABLE membros (
                codigo_membro VARCHAR(4) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                logradouro VARCHAR(25) NOT NULL,
                numero VARCHAR(4) NOT NULL,
                complemento VARCHAR(25),
                bairro VARCHAR(15) NOT NULL,
                cidade VARCHAR(15) NOT NULL,
                uf VARCHAR(2) NOT NULL,
                cep VARCHAR(8) NOT NULL,
                profissao VARCHAR(10) NOT NULL,
                data_nascimento DATE NOT NULL,
                sexo CHAR(1) NOT NULL,
                estado_civil VARCHAR(10) NOT NULL,
                CONSTRAINT membros_pk PRIMARY KEY (codigo_membro)
);

-- Criando tabela "fazem"

CREATE TABLE fazem (
                codigo_membro VARCHAR(4) NOT NULL,
                codigo_doacao VARCHAR(4) NOT NULL,
                CONSTRAINT fazem_pk PRIMARY KEY (codigo_membro, codigo_doacao)
);

-- Criando tabela "trabalham"

CREATE TABLE trabalham (
                codigo_membro VARCHAR(4) NOT NULL,
                codigo_programa VARCHAR(6) NOT NULL,
                CONSTRAINT trabalham_pk PRIMARY KEY (codigo_membro, codigo_programa)
);

-- Criando tabela "colaboram"

CREATE TABLE colaboram (
                codigo_membro VARCHAR(4) NOT NULL,
                codigo_membro_2 VARCHAR(4) NOT NULL,
                CONSTRAINT colaboram_pk PRIMARY KEY (codigo_membro, codigo_membro_2)
);

-- Criando tabela "telefone_membros"

CREATE TABLE telefone_membros (
                numero_membros VARCHAR(12) NOT NULL,
                codigo_membro VARCHAR(4) NOT NULL,
                CONSTRAINT telefone_membros_pk PRIMARY KEY (numero_membros, codigo_membro)
);

-- Constraints adicionais da tabela "membros"

ALTER TABLE destinacoes ADD CONSTRAINT doacoes_destinacoes_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "fazem"

ALTER TABLE fazem ADD CONSTRAINT doacoes_fazem_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "monetarios"

ALTER TABLE monetarios ADD CONSTRAINT doacoes_monetarios_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "bens"

ALTER TABLE bens ADD CONSTRAINT doacoes_bens_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "trabalhos"


ALTER TABLE trabalhos ADD CONSTRAINT doacoes_trabalhos_fk
FOREIGN KEY (codigo_doacao)
REFERENCES doacoes (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "disponibilidade"

ALTER TABLE disponibilidade ADD CONSTRAINT trabalhos_disponibilidade_fk
FOREIGN KEY (codigo_doacao)
REFERENCES trabalhos (codigo_doacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "usam_atendidos"

ALTER TABLE usam_atendidos ADD CONSTRAINT atendidos_usam_atendidos_fk
FOREIGN KEY (codigo_atendido)
REFERENCES atendidos (codigo_atendido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "telefones_atendidos"

ALTER TABLE telefones_atendidos ADD CONSTRAINT atendidos_telefones_atendidos_fk
FOREIGN KEY (codigo_atendido)
REFERENCES atendidos (codigo_atendido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "cadastram"

ALTER TABLE cadastram ADD CONSTRAINT atendidos_cadastram_fk
FOREIGN KEY (codigo_atendido)
REFERENCES atendidos (codigo_atendido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "destinacoes"

ALTER TABLE destinacoes ADD CONSTRAINT atendidos_destinacoes_fk
FOREIGN KEY (codigo_atendido)
REFERENCES atendidos (codigo_atendido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "usam_comunidades"

ALTER TABLE usam_comunidades ADD CONSTRAINT imagens_usam_imagens_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "usam_programas"

ALTER TABLE usam_programas ADD CONSTRAINT imagens_usam_programas_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "usam_atendidos"

ALTER TABLE usam_atendidos ADD CONSTRAINT imagens_usam_atendidos_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "registram"

ALTER TABLE registram ADD CONSTRAINT imagens_registram_fk
FOREIGN KEY (codigo_imagem)
REFERENCES imagens (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE destinacoes ADD CONSTRAINT registram_destinacoes_fk
FOREIGN KEY (codigo_imagem)
REFERENCES registram (codigo_imagem)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "desenvolvem"

ALTER TABLE desenvolvem ADD CONSTRAINT comunidades_desenvolvem_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "telefones_comunidade"

ALTER TABLE telefones_comunidade ADD CONSTRAINT comunidades_telefones_comunidade_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "usam_comunidades"

ALTER TABLE usam_comunidades ADD CONSTRAINT comunidades_usam_imagens_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "cadastram"

ALTER TABLE cadastram ADD CONSTRAINT comunidades_cadastram_fk
FOREIGN KEY (codigo_comunidade)
REFERENCES comunidades (codigo_comunidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "trabalham"

ALTER TABLE trabalham ADD CONSTRAINT programas_trabalham_fk
FOREIGN KEY (codigo_programa)
REFERENCES programas (codigo_programa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "desenvolvem"

ALTER TABLE desenvolvem ADD CONSTRAINT programas_desenvolvem_fk
FOREIGN KEY (codigo_programa)
REFERENCES programas (codigo_programa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "usam_programas"

ALTER TABLE usam_programas ADD CONSTRAINT programas_usam_programas_fk
FOREIGN KEY (codigo_programa)
REFERENCES programas (codigo_programa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "telefone_membros"

ALTER TABLE telefone_membros ADD CONSTRAINT membros_telefone_membros_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "colaboram"

ALTER TABLE colaboram ADD CONSTRAINT membros_colaboram_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



ALTER TABLE colaboram ADD CONSTRAINT membros_colaboram_fk1
FOREIGN KEY (codigo_membro_2)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "trabalham"

ALTER TABLE trabalham ADD CONSTRAINT membros_trabalham_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Foreign keys da tabela "fazem"

ALTER TABLE fazem ADD CONSTRAINT membros_fazem_fk
FOREIGN KEY (codigo_membro)
REFERENCES membros (codigo_membro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
