-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 10-Dez-2025 às 01:47
-- Versão do servidor: 10.5.29-MariaDB-0+deb11u1
-- versão do PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `saude_mental`
--
CREATE DATABASE IF NOT EXISTS `novo_banco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `novo_banco`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `atendimento`
--

DROP TABLE IF EXISTS `atendimento`;
CREATE TABLE `atendimento` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `valor_individual_sessao` bigint(20) DEFAULT NULL,
  `valor_individual_mensal` bigint(20) DEFAULT NULL,
  `valor_casal_sessao` bigint(20) DEFAULT NULL,
  `valor_casal_mensal` bigint(20) DEFAULT NULL,
  `valor_grupo_sessao` bigint(20) DEFAULT NULL,
  `valor_grupo_mensal` bigint(20) DEFAULT NULL,
  `aceita_negociar_plano` tinyint(1) DEFAULT 0,
  `ultima_atualizacao` datetime(3) DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `atividade`
--

DROP TABLE IF EXISTS `atividade`;
CREATE TABLE `atividade` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_criador` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `sobre` text DEFAULT NULL,
  `data_criacao` datetime(3) DEFAULT NULL,
  `data_atualizacao` datetime(3) DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `deslikes` int(11) DEFAULT 0,
  `duracao` bigint(20) DEFAULT NULL,
  `tem_video` tinyint(1) DEFAULT 0,
  `link_video` varchar(500) DEFAULT NULL,
  `numero_participantes` int(11) DEFAULT 0,
  `visualizacoes` int(11) DEFAULT 0,
  `etapas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`etapas`)),
  `image` longblob DEFAULT NULL,
  `tema` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `atividade_user`
--

DROP TABLE IF EXISTS `atividade_user`;
CREATE TABLE `atividade_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_atividade` bigint(20) UNSIGNED NOT NULL,
  `data_inicio` datetime(3) DEFAULT NULL,
  `data_fim` datetime(3) DEFAULT NULL,
  `completado` tinyint(1) DEFAULT 0,
  `etapas_feitas` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cartao`
--

DROP TABLE IF EXISTS `cartao`;
CREATE TABLE `cartao` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `numero_cartao` VARBINARY(64) NOT NULL,
  `data_validade` CHAR(4) NOT NULL,
  `ultimos_digitos` CHAR(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `comentario_importancia_terapia`
--

DROP TABLE IF EXISTS `comentario_importancia_terapia`;
CREATE TABLE `comentario_importancia_terapia` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_criador` bigint(20) UNSIGNED DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `deslikes` int(11) DEFAULT 0,
  `texto` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `configuracoes`
--

DROP TABLE IF EXISTS `configuracoes`;
CREATE TABLE `configuracoes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_conta_acesso` bigint(20) UNSIGNED NOT NULL,
  `notificacao_email_ativada` tinyint(1) DEFAULT 1,
  `notificacao_sms_ativada` tinyint(1) DEFAULT 0,
  `notificacao_whatsapp_ativada` tinyint(1) DEFAULT 0,
  `receber_promocoes` tinyint(1) DEFAULT 0,
  `ui_compacta` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_acesso`
--

DROP TABLE IF EXISTS `dados_acesso`;
CREATE TABLE `dados_acesso` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `public_id` CHAR(26) NOT NULL,
  `fk_user` BIGINT UNSIGNED DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `senha` VARBINARY(255) DEFAULT NULL,
  `telefone` VARCHAR(25) DEFAULT NULL,
  `firebase_uid` VARCHAR(255) DEFAULT NULL,
  `e_empresa` TINYINT(1) NOT NULL DEFAULT 0,
  `e_profissional` TINYINT(1) NOT NULL DEFAULT 0,
  `login_principal` ENUM('email','telefone','oauth') NOT NULL DEFAULT 'oauth',
  `conta_excluida` TINYINT(1) NOT NULL DEFAULT 0,
  `data_exclusao` DATETIME(3) DEFAULT NULL,
  `data_cadastro` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `email_verificado` TINYINT(1) NOT NULL DEFAULT 0,
  `telefone_verificado` TINYINT(1) NOT NULL DEFAULT 0,
  `telefone_e_whatsapp` TINYINT(1) NOT NULL DEFAULT 0,
  `tipo_usuario` ENUM('usuario','profissional','empresa') NOT NULL DEFAULT 'usuario',
  `ultimo_login` DATETIME(3) DEFAULT NULL,
  `tentativas_login` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `fk_profissional` BIGINT UNSIGNED DEFAULT NULL,
  `fk_empresa` BIGINT UNSIGNED DEFAULT NULL,
  `role` ENUM('admin','user','supervisor','tester') NOT NULL DEFAULT 'user',
  `data_atualizacao` TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_public_id` (`public_id`),
  UNIQUE KEY `ux_firebase_uid` (`firebase_uid`),
  KEY `idx_email` (`email`),
  KEY `idx_telefone` (`telefone`),
  KEY `idx_fk_profissional` (`fk_profissional`),
  KEY `idx_fk_empresa` (`fk_empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_assinatura`
--

DROP TABLE IF EXISTS `dados_assinatura`;
CREATE TABLE `dados_assinatura` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `data_inicio_assinatura` datetime(3) DEFAULT NULL,
  `data_fim_assinatura` datetime(3) DEFAULT NULL,
  `data_pagamento` datetime(3) DEFAULT NULL,
  `plano` tinyint(3) UNSIGNED NOT NULL,
  `valor_plano` bigint(20) DEFAULT NULL,
  `valor_pago` bigint(20) DEFAULT NULL,
  `desconto` bigint(20) DEFAULT NULL,
  `periodo_contratado` enum('mensal','anual','pra_sempre','nao_se_aplica') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_cobranca`
--

DROP TABLE IF EXISTS `dados_cobranca`;
CREATE TABLE `dados_cobranca` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_cartao` BIGINT(20) UNSIGNED DEFAULT NULL,
  `cep` VARCHAR(20) DEFAULT NULL,          -- suportar códigos postais internacionais
  `endereco` VARCHAR(255) NOT NULL,        -- exigido
  `bairro` VARCHAR(120) DEFAULT NULL,
  `numero` VARCHAR(20) NOT NULL,           -- agora NOT NULL e como string para "s/n", "10A" etc.
  `complemento` VARCHAR(120) DEFAULT NULL,
  `nome_completo` VARCHAR(255) DEFAULT NULL,
  `fk_user` BIGINT(20) UNSIGNED DEFAULT NULL,  -- referencia para dados_acesso.id (permite múltiplos registros por user)
  `cidade` VARCHAR(120) NOT NULL,
  `estado` VARCHAR(100) DEFAULT NULL,
  `regiao` VARCHAR(100) DEFAULT NULL,
  `pais` VARCHAR(100) NOT NULL,
  `data_criacao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `data_atualizacao` TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`),
  KEY `idx_fk_user` (`fk_user`),
  KEY `idx_fk_cartao` (`fk_cartao`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

  ALTER TABLE `dados_cobranca`
  ADD CONSTRAINT `fk_dadoscobranca_dados_acesso`
    FOREIGN KEY (`fk_user`) REFERENCES `dados_acesso`(`id`)
    ON UPDATE CASCADE
    ON DELETE SET NULL;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_empresariais`
--

DROP TABLE IF EXISTS `dados_empresariais`;
CREATE TABLE `dados_empresariais` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome_clinica` VARCHAR(255) NOT NULL,
  `nome_representante_legal` VARCHAR(255) DEFAULT NULL,
  `cnpj` VARCHAR(20) DEFAULT NULL,
  `endereco_completo_clinica` VARCHAR(255) DEFAULT NULL,
  `tipos_profissionais` JSON DEFAULT NULL,
  `publico_alvo` VARCHAR(255) DEFAULT NULL,
  `modalidade_atendimento` ENUM('presencial','online','ambos') NOT NULL DEFAULT 'ambos',
  `aceita_convenio` TINYINT(1) NOT NULL DEFAULT 0,
  `convenios_aceitos` VARCHAR(255) DEFAULT NULL,
  `realiza_reembolso` TINYINT(1) NOT NULL DEFAULT 0,
  `observacoes_adicionais` VARCHAR(500) DEFAULT NULL,
  `link_compartilhavel` VARCHAR(500) DEFAULT NULL,
  `tipo_cobranca` ENUM('por_profissional','clinica','depende') NOT NULL DEFAULT 'depende',
  `fk_dados_acesso` BIGINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_dados_empresariais_cnpj` (`cnpj`),
  KEY `ix_dados_empresariais_fk_dados_acesso` (`fk_dados_acesso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_profissionais`
--

DROP TABLE IF EXISTS `dados_profissionais`;
CREATE TABLE `dados_profissionais` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_atendimento` BIGINT UNSIGNED DEFAULT NULL,
  `e_psicologo` TINYINT(1) DEFAULT 0,
  `e_psiquiatra` TINYINT(1) DEFAULT 0,
  `e_neuropsicologo` TINYINT(1) DEFAULT 0,
  `profissao_outra` VARCHAR(120) DEFAULT NULL,
  `crp` VARCHAR(50) DEFAULT NULL,
  `outro_registro` VARCHAR(50) DEFAULT NULL,
  `publico_alvo` VARCHAR(255) DEFAULT NULL,
  `temas_abordados` VARCHAR(255) DEFAULT NULL,
  `modalidade_atendimento` ENUM('presencial','online','ambos') NOT NULL DEFAULT 'ambos',
  `aceita_convenio` TINYINT(1) DEFAULT 0,
  `convenios_aceitos` VARCHAR(255) DEFAULT NULL,
  `realiza_reembolso` TINYINT(1) DEFAULT 0,
  `observacoes_adicionais` VARCHAR(500) DEFAULT NULL,
  `profissional_empresa` TINYINT(1) DEFAULT 0,
  `empresa` BIGINT UNSIGNED DEFAULT NULL,
  `esta_divulgado` TINYINT(1) DEFAULT 0,
  `link_compartilhavel` VARCHAR(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_pessoais`
--

DROP TABLE IF EXISTS `dados_pessoais`;
CREATE TABLE `dados_pessoais` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_dados_acesso` BIGINT(20) UNSIGNED NOT NULL,
  `fk_configuracoes` BIGINT(20) UNSIGNED DEFAULT NULL,
  -- `fk_dados_cobranca` removido intencionalmente
  `nome_completo` VARCHAR(255) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `genero` ENUM('homem','mulher','outro') DEFAULT NULL,
  `imagem_perfil` LONGBLOB DEFAULT NULL,
  `ultima_atualizacao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `pais` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(120) DEFAULT NULL,
  `regiao_zona` VARCHAR(120) DEFAULT NULL,
  `telefone_emergencia_1` VARCHAR(11) DEFAULT NULL,
  `telefone_emergencia_2` VARCHAR(11) DEFAULT NULL,
  `telefone_emergencia_3` VARCHAR(11) DEFAULT NULL,
  `plano` TINYINT(3) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fk_dados_acesso` (`fk_dados_acesso`),
  KEY `idx_cpf` (`cpf`),
  KEY `idx_pais_estado` (`pais`, `estado`),
  CONSTRAINT `fk_dados_pessoais_dados_acesso` FOREIGN KEY (`fk_dados_acesso`) REFERENCES `dados_acesso`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Chave estrageira das tabelas `dados_acesso` e `dados_empresariais`
--

ALTER TABLE `dados_acesso`
  ADD CONSTRAINT `fk_dadosacesso_dadosprof`
    FOREIGN KEY (`fk_profissional`) REFERENCES `dados_profissionais` (`id`)
      ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dadosacesso_dadosemp`
    FOREIGN KEY (`fk_empresa`) REFERENCES `dados_empresariais` (`id`)
      ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `dados_empresariais`
  ADD CONSTRAINT `fk_dados_empresariais_dados_acesso`
    FOREIGN KEY (`fk_dados_acesso`) REFERENCES `dados_acesso` (`id`)
      ON DELETE RESTRICT ON UPDATE CASCADE;

-- --------------------------------------------------------

--
-- Estrutura da tabela `desafio`
--

DROP TABLE IF EXISTS `desafio`;
CREATE TABLE `desafio` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_criador` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `data_criacao` datetime(3) DEFAULT NULL,
  `data_atualizacao` datetime(3) DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `deslikes` int(11) DEFAULT 0,
  `duracao` bigint(20) DEFAULT NULL,
  `numero_participantes` int(11) DEFAULT 0,
  `visualizacoes` int(11) DEFAULT 0,
  `etapas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`etapas`)),
  `image` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `desafio_user`
--

DROP TABLE IF EXISTS `desafio_user`;
CREATE TABLE `desafio_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_desafio` bigint(20) UNSIGNED NOT NULL,
  `data_inicio` datetime(3) DEFAULT NULL,
  `data_fim` datetime(3) DEFAULT NULL,
  `completado` tinyint(1) DEFAULT 0,
  `etapas_feitas` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `diario`
--

DROP TABLE IF EXISTS `diario`;
CREATE TABLE `diario` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `data_criacao` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `data_atualizacao` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `origem` enum('pote','desafio','oficina','outro') NOT NULL,
  `topico` varchar(255) DEFAULT NULL,
  `texto` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `erro_app`
--

CREATE TABLE `conta_acesso` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `erro_app`;
CREATE TABLE `erro_app` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_criacao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

  -- Campos obrigatórios
  `tipo_erro` VARCHAR(120) NOT NULL,
  `origem` VARCHAR(120) NOT NULL,
  `mensagem` VARCHAR(500) NOT NULL,

  -- Identificação do criador (usuário do sistema)
  `foi_criado_por_usuario` TINYINT(1) NOT NULL DEFAULT 1,
  `fk_criador` BIGINT(20) UNSIGNED DEFAULT NULL,

  -- Controle de agregação de erros
  `contador` INT UNSIGNED NOT NULL DEFAULT 1,

  -- Atualização automática em caso de incrementos
  `ultima_atualizacao` TIMESTAMP NULL 
       DEFAULT NULL 
       ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  CONSTRAINT `fk_erroapp_criador`
    FOREIGN KEY (`fk_criador`) REFERENCES `conta_acesso` (`id`)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB 
  DEFAULT CHARSET=utf8mb4 
  COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estatisticas_app`
--

DROP TABLE IF EXISTS `estatisticas_app`;
CREATE TABLE `estatisticas_app` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero_dispositivos_sem_autenticacao` INT UNSIGNED DEFAULT 0,
  `numero_usuarios` INT UNSIGNED DEFAULT 0,
  `numero_profissionais` INT UNSIGNED DEFAULT 0,
  `numero_empresas` INT UNSIGNED DEFAULT 0,
  `numero_delecoes` INT UNSIGNED DEFAULT 0,
  `numero_usuarios_pagos` INT UNSIGNED DEFAULT 0,
  `ganhos` INT UNSIGNED DEFAULT 0,
  `data_criacao` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `data_atualizacao` DATETIME(3) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(3),

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estatisticas_profissional`
--

DROP TABLE IF EXISTS `estatisticas_profissional`;
CREATE TABLE `estatisticas_profissional` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_profissional` bigint(20) UNSIGNED NOT NULL,
  `data_criacao` datetime(3) DEFAULT NULL,
  `data_atualizacao` datetime(3) DEFAULT NULL,
  `pacientes` int(11) UNSIGNED DEFAULT 0,
  `entraram_contato` int(11) UNSIGNED DEFAULT 0,
  `agendamentos` int(11) UNSIGNED DEFAULT 0,
  `likes_oficinas` int(11) UNSIGNED DEFAULT 0,
  `likes_desafios` int(11) UNSIGNED DEFAULT 0,
  `likes_comentarios` int(11) UNSIGNED DEFAULT 0,
  `participantes_oficinas` int(11) UNSIGNED DEFAULT 0,
  `participantes_desafios` int(11) UNSIGNED DEFAULT 0,
  `participantes_atividades` int(11) UNSIGNED DEFAULT 0,
  `ganhos` int(11) UNSIGNED DEFAULT 0,
  `e_empresa` tinyint(1) DEFAULT 0,
  `numero_profissionais` int(11) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `notificacao`
--

DROP TABLE IF EXISTS `notificacao`;
CREATE TABLE `notificacao` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `target_id` BIGINT(20) UNSIGNED DEFAULT NULL,
  `target_group` TINYINT(3) UNSIGNED DEFAULT NULL,
  `titulo` VARCHAR(255) NOT NULL,
  `mensagem` TEXT NOT NULL,
  `link_acao` VARCHAR(500) DEFAULT NULL,

  /* b) Quando enviar */
  `quando_enviar` TIMESTAMP NULL DEFAULT NULL,

  /* c) Foi enviado */
  `foi_enviado` TINYINT(1) NOT NULL DEFAULT 0,

  /* d) Meio de envio */
  `meio` ENUM(
      'todos',
      'app',
      'in_app',
      'out_app',
      'web',
      'email',
      'whatsapp'
  ) NOT NULL DEFAULT 'app',

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oficina`
--

DROP TABLE IF EXISTS `oficina`;
CREATE TABLE `oficina` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_criador` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `sobre` text DEFAULT NULL,
  `data_criacao` datetime(3) DEFAULT NULL,
  `data_atualizacao` datetime(3) DEFAULT NULL,
  `data_e_hora_inicio` datetime(3) DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `deslikes` int(11) DEFAULT 0,
  `duracao` bigint(20) DEFAULT NULL,
  `paga` tinyint(1) DEFAULT 0,
  `valor` bigint(20) DEFAULT NULL,
  `numero_participantes` int(11) DEFAULT 0,
  `numero_participantes_max` bigint(20) DEFAULT NULL,
  `visualizacoes` int(11) DEFAULT 0,
  `image` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `oficina_user`
--

DROP TABLE IF EXISTS `oficina_user`;
CREATE TABLE `oficina_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_oficina` bigint(20) UNSIGNED NOT NULL,
  `pagou` tinyint(1) DEFAULT 0,
  `valor_pago` int(11) DEFAULT 0,
  `participante` tinyint(1) DEFAULT 0,
  `desistiu` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `paciente`
--

DROP TABLE IF EXISTS `paciente`;
CREATE TABLE `paciente` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_profissional` bigint(20) UNSIGNED NOT NULL,
  `motivo` enum('entrou_contato','agendamento') NOT NULL,
  `permissao_acesso_dados` tinyint(1) DEFAULT 0,
  `preferencia_contato` enum('email','whatsapp','ligacao') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pergunta_importancia_terapia`
--

DROP TABLE IF EXISTS `pergunta_importancia_terapia`;
CREATE TABLE `pergunta_importancia_terapia` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `texto` text NOT NULL,
  `respostas` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`respostas`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pote`
--

DROP TABLE IF EXISTS `pote`;
CREATE TABLE `pote` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `categoria` varchar(100) DEFAULT NULL,
  `permite_sorteio_offline` tinyint(1) DEFAULT 0,
  `topico` varchar(255) DEFAULT NULL,
  `items` longtext
      CHARACTER SET utf8mb4
      COLLATE utf8mb4_bin
      DEFAULT NULL
      CHECK (json_valid(`items`)),
  `nome` varchar(255) NOT NULL,
  
  -- Índices
  UNIQUE KEY `uk_pote_nome` (`nome`),

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `session`
--

DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `refresh_token` varchar(200) NOT NULL,
  `device_info` varchar(300) NOT NULL,
  `ip` varchar(64) NOT NULL,
  `created_at` datetime(3) NOT NULL,
  `expires_at` datetime(3) NOT NULL,
  `revoked_at` datetime(3) DEFAULT NULL,
  `rotation_counter` bigint(20) DEFAULT 0,
  `last_used_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `refresh_token` varchar(200) DEFAULT NULL,
  `device_info` varchar(300) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `expires_at` datetime(3) DEFAULT NULL,
  `revoked_at` datetime(3) DEFAULT NULL,
  `rotation_counter` bigint(20) DEFAULT NULL,
  `last_used_at` datetime(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `refresh_token`, `device_info`, `ip`, `created_at`, `expires_at`, `revoked_at`, `rotation_counter`, `last_used_at`) VALUES
('d602b145-6e4f-4e18-8eca-8e64c32718cc', 1, 'RmMh2ADEpT0DNZhproR45ipJhivMBnrxSqV0sDpWGNs', 'bruno api', '127.0.0.1', '2025-10-27 08:41:35.809', '2025-11-26 08:41:35.809', NULL, 1, '2025-10-27 09:11:27.044');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_grupo`
--

DROP TABLE IF EXISTS `tipo_grupo`;
CREATE TABLE `tipo_grupo` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `tipo_grupo`
--

INSERT INTO `tipo_grupo` (`id`, `nome`) VALUES
(4, 'clinicas'),
(1, 'global'),
(3, 'profissionais'),
(7, 'profissional_alternativo'),
(8, 'profissional_psicologo'),
(9, 'profissional_psiquiatra'),
(2, 'usuarios'),
(5, 'usuarios_free'),
(6, 'usuarios_premium');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tipo_plano`
--

DROP TABLE IF EXISTS `tipo_plano`;
CREATE TABLE `tipo_plano` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `escopo` enum('usuario','profissional','empresa') NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `tipo_plano`
--

INSERT INTO `tipo_plano` (`id`, `escopo`, `nome`) VALUES
(1, 'usuario', 'bronze'),
(2, 'usuario', 'prata'),
(3, 'usuario', 'ouro'),
(4, 'profissional', 'sob_demanda'),
(5, 'profissional', 'profissional'),
(7, 'empresa', 'empresarial');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `firebase_uid` longtext DEFAULT NULL,
  `email` longtext DEFAULT NULL,
  `role` longtext DEFAULT NULL,
  `plan` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `created_at`, `updated_at`, `deleted_at`, `firebase_uid`, `email`, `role`, `plan`) VALUES
(1, '2025-10-27 07:12:47.989', '2025-10-27 07:12:47.989', NULL, 'CboukqeEJ8cmUwOu20gq4FgxwWr2', 'richardmunizlico@gmail.com', 'user', 'free');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_atividade_favorita`
--

DROP TABLE IF EXISTS `usuario_atividade_favorita`;
CREATE TABLE `usuario_atividade_favorita` (
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_atividade` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_desafio_favorito`
--

DROP TABLE IF EXISTS `usuario_desafio_favorito`;
CREATE TABLE `usuario_desafio_favorito` (
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_desafio` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_diario_ref`
--

DROP TABLE IF EXISTS `usuario_diario_ref`;
CREATE TABLE `usuario_diario_ref` (
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_diario` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_oficina_favorita`
--

DROP TABLE IF EXISTS `usuario_oficina_favorita`;
CREATE TABLE `usuario_oficina_favorita` (
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_oficina` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_sem_autenticacao`
--

DROP TABLE IF EXISTS `usuario_sem_autenticacao`;
CREATE TABLE `usuario_sem_autenticacao` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,

  `data_primeiro_acesso` DATETIME(3) DEFAULT NULL,
  `data_ultimo_acesso` DATETIME(3) DEFAULT NULL,

  `dispositivo` ENUM('web','android','ios') NOT NULL,

  -- Alterado conforme item (d)
  `identificador` VARCHAR(255) NOT NULL,

  -- Item (a)
  `ip` VARCHAR(64) NOT NULL,

  -- Item (b)
  `dispositivo_info` LONGTEXT DEFAULT NULL,

  -- Item (c)
  `localizacao` VARCHAR(255) DEFAULT NULL,

  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_identificador_unique` (`identificador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `atendimento`
--
ALTER TABLE `atendimento`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `atividade`
--
ALTER TABLE `atividade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_atividade_criador` (`fk_criador`);

--
-- Índices para tabela `atividade_user`
--
ALTER TABLE `atividade_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_atividade_user` (`fk_usuario`,`fk_atividade`),
  ADD KEY `fk_atividade_user_atividade` (`fk_atividade`);

--
-- Índices para tabela `comentario_importancia_terapia`
--
ALTER TABLE `comentario_importancia_terapia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_comentario_importancia_terapia_fk_criador` (`fk_criador`);

--
-- Índices para tabela `configuracoes`
--
ALTER TABLE `configuracoes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_configuracoes_fk_conta_acesso` (`fk_conta_acesso`);

--
-- Índices para tabela `dados_acesso`
--
ALTER TABLE `dados_acesso`
  ADD UNIQUE KEY `idx_dados_acesso_email` (`email`),
  ADD UNIQUE KEY `idx_dados_acesso_telefone` (`telefone`),
  ADD UNIQUE KEY `idx_dados_acesso_fk_profissional` (`fk_profissional`),
  ADD UNIQUE KEY `idx_dados_acesso_fk_empresa` (`fk_empresa`),
  ADD UNIQUE KEY `idx_acesso_firebase_uid` (`firebase_uid`) USING HASH,
  ADD KEY `idx_acesso_deleted_at` (`data_exclusao`);

--
-- Índices para tabela `dados_assinatura`
--
ALTER TABLE `dados_assinatura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assin_plano` (`plano`),
  ADD KEY `fk_dados_assinatura_usuario` (`fk_usuario`);

--
-- Índices para tabela `dados_empresariais`
--
ALTER TABLE `dados_empresariais`
  ADD UNIQUE KEY `idx_dados_empresariais_cnpj` (`cnpj`);

--
-- Índices para tabela `dados_pessoais`
--
ALTER TABLE `dados_pessoais`
  ADD UNIQUE KEY `idx_dados_pessoais_fk_configuracoes` (`fk_configuracoes`),
  ADD UNIQUE KEY `idx_dados_pessoais_cpf` (`cpf`),
  ADD KEY `fk_dados_pessoais_tipo_plano` (`plano`);

--
-- Índices para tabela `dados_profissionais`
--
ALTER TABLE `dados_profissionais`
  ADD KEY `fk_dados_profissionais_dados_empresariais` (`empresa`);

--
-- Índices para tabela `desafio`
--
ALTER TABLE `desafio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_desafio_titulo` (`titulo`),
  ADD KEY `fk_desafio_criador` (`fk_criador`);

--
-- Índices para tabela `desafio_user`
--
ALTER TABLE `desafio_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_desafio_user` (`fk_usuario`,`fk_desafio`),
  ADD KEY `fk_desafio_user_desafio` (`fk_desafio`);

--
-- Índices para tabela `estatisticas_app`
--
ALTER TABLE `estatisticas_app`
  ADD UNIQUE KEY `idx_estatisticas_app_data_criacao` (`data_criacao`);

--
-- Índices para tabela `estatisticas_profissional`
--
ALTER TABLE `estatisticas_profissional`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_estatisticas_profissional_profissional` (`fk_profissional`);

--
-- Índices para tabela `notificacao`
--
ALTER TABLE `notificacao`
  ADD KEY `fk_notificacao_tipo_grupo` (`target_group`);

--
-- Índices para tabela `oficina`
--
ALTER TABLE `oficina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_oficina_criador` (`fk_criador`);

--
-- Índices para tabela `oficina_user`
--
ALTER TABLE `oficina_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_oficina_user` (`fk_usuario`,`fk_oficina`),
  ADD KEY `fk_oficina_user_oficina` (`fk_oficina`);

--
-- Índices para tabela `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_paciente_usuario` (`fk_usuario`),
  ADD KEY `fk_paciente_profissional` (`fk_profissional`);

--
-- Índices para tabela `pergunta_importancia_terapia`
--
ALTER TABLE `pergunta_importancia_terapia`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_pergunta_importancia_terapia_fk_usuario` (`fk_usuario`);

--
-- Índices para tabela `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sessions_user_id` (`user_id`),
  ADD KEY `idx_sessions_expires_at` (`expires_at`);

--
-- Índices para tabela `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sessions_user_id` (`user_id`),
  ADD KEY `idx_sessions_expires_at` (`expires_at`);

--
-- Índices para tabela `tipo_grupo`
--
ALTER TABLE `tipo_grupo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_tipo_grupo_nome` (`nome`);

--
-- Índices para tabela `tipo_plano`
--
ALTER TABLE `tipo_plano`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_tipo_plano_nome` (`nome`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_users_firebase_uid` (`firebase_uid`) USING HASH,
  ADD KEY `idx_users_deleted_at` (`deleted_at`);

--
-- Índices para tabela `usuario_atividade_favorita`
--
ALTER TABLE `usuario_atividade_favorita`
  ADD PRIMARY KEY (`fk_usuario`,`fk_atividade`),
  ADD KEY `fk_usuario_atividade_favorita_atividade` (`fk_atividade`);

--
-- Índices para tabela `usuario_desafio_favorito`
--
ALTER TABLE `usuario_desafio_favorito`
  ADD PRIMARY KEY (`fk_usuario`,`fk_desafio`),
  ADD KEY `fk_usuario_desafio_favorito_desafio` (`fk_desafio`);

--
-- Índices para tabela `usuario_diario_ref`
--
ALTER TABLE `usuario_diario_ref`
  ADD PRIMARY KEY (`fk_usuario`,`fk_diario`),
  ADD KEY `fk_udr_diario` (`fk_diario`);

--
-- Índices para tabela `usuario_oficina_favorita`
--
ALTER TABLE `usuario_oficina_favorita`
  ADD PRIMARY KEY (`fk_usuario`,`fk_oficina`),
  ADD KEY `fk_usuario_oficina_favorita_oficina` (`fk_oficina`);

--
-- AUTO_INCREMENT de tabela `atendimento`
--
ALTER TABLE `atendimento`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atividade`
--
ALTER TABLE `atividade`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atividade_user`
--
ALTER TABLE `atividade_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `cartao`
--
ALTER TABLE `cartao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `comentario_importancia_terapia`
--
ALTER TABLE `comentario_importancia_terapia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `configuracoes`
--
ALTER TABLE `configuracoes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dados_acesso`
--
ALTER TABLE `dados_acesso`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dados_assinatura`
--
ALTER TABLE `dados_assinatura`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dados_cobranca`
--
ALTER TABLE `dados_cobranca`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dados_empresariais`
--
ALTER TABLE `dados_empresariais`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dados_pessoais`
--
ALTER TABLE `dados_pessoais`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dados_profissionais`
--
ALTER TABLE `dados_profissionais`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `desafio`
--
ALTER TABLE `desafio`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `desafio_user`
--
ALTER TABLE `desafio_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `diario`
--
ALTER TABLE `diario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `erro_app`
--
ALTER TABLE `erro_app`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estatisticas_app`
--
ALTER TABLE `estatisticas_app`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `estatisticas_profissional`
--
ALTER TABLE `estatisticas_profissional`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `notificacao`
--
ALTER TABLE `notificacao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `oficina`
--
ALTER TABLE `oficina`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `oficina_user`
--
ALTER TABLE `oficina_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pergunta_importancia_terapia`
--
ALTER TABLE `pergunta_importancia_terapia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pote`
--
ALTER TABLE `pote`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `atividade`
--
ALTER TABLE `atividade`
  ADD CONSTRAINT `fk_atividade_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_profissionais` (`id`);

--
-- Limitadores para a tabela `atividade_user`
--
ALTER TABLE `atividade_user`
  ADD CONSTRAINT `fk_atividade_user_atividade` FOREIGN KEY (`fk_atividade`) REFERENCES `atividade` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_atividade_user_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_au_atividade` FOREIGN KEY (`fk_atividade`) REFERENCES `atividade` (`id`),
  ADD CONSTRAINT `fk_au_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`);

--
-- Limitadores para a tabela `comentario_importancia_terapia`
--
ALTER TABLE `comentario_importancia_terapia`
  ADD CONSTRAINT `fk_comentario_importancia_terapia_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_acesso` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `configuracoes`
--
ALTER TABLE `configuracoes`
  ADD CONSTRAINT `fk_cfg_conta` FOREIGN KEY (`fk_conta_acesso`) REFERENCES `dados_acesso` (`id`),
  ADD CONSTRAINT `fk_configuracoes_usuario` FOREIGN KEY (`fk_conta_acesso`) REFERENCES `dados_acesso` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `dados_acesso`
--
ALTER TABLE `dados_acesso`
  ADD CONSTRAINT `fk_acesso_user` FOREIGN KEY (`fk_user`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_dados_acesso_dados_empresariais` FOREIGN KEY (`fk_empresa`) REFERENCES `dados_empresariais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dados_acesso_dados_pessoais` FOREIGN KEY (`fk_user`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dados_acesso_dados_profissionais` FOREIGN KEY (`fk_profissional`) REFERENCES `dados_profissionais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dados_cobranca_usuario` FOREIGN KEY (`fk_user`) REFERENCES `dados_cobranca` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `dados_assinatura`
--
ALTER TABLE `dados_assinatura`
  ADD CONSTRAINT `fk_assin_plano` FOREIGN KEY (`plano`) REFERENCES `tipo_plano` (`id`),
  ADD CONSTRAINT `fk_assin_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_acesso` (`id`),
  ADD CONSTRAINT `fk_dados_assinatura_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_acesso` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `dados_cobranca`
--
ALTER TABLE `dados_cobranca`
  ADD CONSTRAINT `fk_cobranca_cartao` FOREIGN KEY (`fk_cartao`) REFERENCES `cartao` (`id`),
  ADD CONSTRAINT `fk_dados_cobranca_cartao` FOREIGN KEY (`fk_cartao`) REFERENCES `cartao` (`id`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `dados_empresariais`
--
ALTER TABLE `dados_empresariais`
  ADD CONSTRAINT `fk_dados_empresariais_usuario` FOREIGN KEY (`fk_dados_acesso`) REFERENCES `dados_acesso` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `dados_pessoais`
--
ALTER TABLE `dados_pessoais`
  ADD CONSTRAINT `fk_dados_pessoais_configuracoes` FOREIGN KEY (`fk_configuracoes`) REFERENCES `configuracoes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_dados_pessoais_tipo_plano` FOREIGN KEY (`plano`) REFERENCES `tipo_plano` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_dp_acesso` FOREIGN KEY (`fk_dados_acesso`) REFERENCES `dados_acesso` (`id`),
  ADD CONSTRAINT `fk_dp_cfg` FOREIGN KEY (`fk_configuracoes`) REFERENCES `configuracoes` (`id`),
  ADD CONSTRAINT `fk_dp_plano` FOREIGN KEY (`plano`) REFERENCES `tipo_plano` (`id`);

--
-- Limitadores para a tabela `dados_profissionais`
--
ALTER TABLE `dados_profissionais`
  ADD CONSTRAINT `fk_dados_profissionais_atendimento` FOREIGN KEY (`fk_atendimento`) REFERENCES `atendimento` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_dados_profissionais_dados_empresariais` FOREIGN KEY (`empresa`) REFERENCES `dados_empresariais` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_dp_atendimento` FOREIGN KEY (`fk_atendimento`) REFERENCES `atendimento` (`id`),
  ADD CONSTRAINT `fk_dp_empresa` FOREIGN KEY (`empresa`) REFERENCES `dados_empresariais` (`id`);

--
-- Limitadores para a tabela `desafio`
--
ALTER TABLE `desafio`
  ADD CONSTRAINT `fk_desafio_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_profissionais` (`id`);

--
-- Limitadores para a tabela `desafio_user`
--
ALTER TABLE `desafio_user`
  ADD CONSTRAINT `fk_desafio_user_desafio` FOREIGN KEY (`fk_desafio`) REFERENCES `desafio` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_desafio_user_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_du_desafio` FOREIGN KEY (`fk_desafio`) REFERENCES `desafio` (`id`),
  ADD CONSTRAINT `fk_du_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`);

--
-- Limitadores para a tabela `diario`
--
ALTER TABLE `diario`
  ADD CONSTRAINT `fk_diario_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_diario_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `erro_app`
--
ALTER TABLE `erro_app`
  ADD CONSTRAINT `fk_erro_app_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_acesso` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `estatisticas_profissional`
--
ALTER TABLE `estatisticas_profissional`
  ADD CONSTRAINT `fk_est_prof` FOREIGN KEY (`fk_profissional`) REFERENCES `dados_profissionais` (`id`),
  ADD CONSTRAINT `fk_estatisticas_profissional_profissional` FOREIGN KEY (`fk_profissional`) REFERENCES `dados_profissionais` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `notificacao`
--
ALTER TABLE `notificacao`
  ADD CONSTRAINT `fk_notif_group` FOREIGN KEY (`target_group`) REFERENCES `tipo_grupo` (`id`),
  ADD CONSTRAINT `fk_notificacao_tipo_grupo` FOREIGN KEY (`target_group`) REFERENCES `tipo_grupo` (`id`) ON DELETE SET NULL;

--
-- Limitadores para a tabela `oficina`
--
ALTER TABLE `oficina`
  ADD CONSTRAINT `fk_oficina_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_profissionais` (`id`);

--
-- Limitadores para a tabela `oficina_user`
--
ALTER TABLE `oficina_user`
  ADD CONSTRAINT `fk_oficina_user_oficina` FOREIGN KEY (`fk_oficina`) REFERENCES `oficina` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_oficina_user_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ou_oficina` FOREIGN KEY (`fk_oficina`) REFERENCES `oficina` (`id`),
  ADD CONSTRAINT `fk_ou_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`);

--
-- Limitadores para a tabela `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `fk_pac_prof` FOREIGN KEY (`fk_profissional`) REFERENCES `dados_profissionais` (`id`),
  ADD CONSTRAINT `fk_pac_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_paciente_profissional` FOREIGN KEY (`fk_profissional`) REFERENCES `dados_profissionais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_paciente_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `pergunta_importancia_terapia`
--
ALTER TABLE `pergunta_importancia_terapia`
  ADD CONSTRAINT `fk_pergunta_importancia_terapia_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pit_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`);

--
-- Limitadores para a tabela `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `fk_session_usuario` FOREIGN KEY (`user_id`) REFERENCES `dados_acesso` (`id`);

--
-- Limitadores para a tabela `usuario_atividade_favorita`
--
ALTER TABLE `usuario_atividade_favorita`
  ADD CONSTRAINT `fk_uaf_atividade` FOREIGN KEY (`fk_atividade`) REFERENCES `atividade` (`id`),
  ADD CONSTRAINT `fk_uaf_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_usuario_atividade_favorita_atividade` FOREIGN KEY (`fk_atividade`) REFERENCES `atividade` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_usuario_atividade_favorita_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `usuario_desafio_favorito`
--
ALTER TABLE `usuario_desafio_favorito`
  ADD CONSTRAINT `fk_udf_desafio` FOREIGN KEY (`fk_desafio`) REFERENCES `desafio` (`id`),
  ADD CONSTRAINT `fk_udf_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_usuario_desafio_favorito_desafio` FOREIGN KEY (`fk_desafio`) REFERENCES `desafio` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_usuario_desafio_favorito_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `usuario_diario_ref`
--
ALTER TABLE `usuario_diario_ref`
  ADD CONSTRAINT `fk_udr_diario` FOREIGN KEY (`fk_diario`) REFERENCES `diario` (`id`),
  ADD CONSTRAINT `fk_udr_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`);

--
-- Limitadores para a tabela `usuario_oficina_favorita`
--
ALTER TABLE `usuario_oficina_favorita`
  ADD CONSTRAINT `fk_uof_oficina` FOREIGN KEY (`fk_oficina`) REFERENCES `oficina` (`id`),
  ADD CONSTRAINT `fk_uof_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_usuario_oficina_favorita_oficina` FOREIGN KEY (`fk_oficina`) REFERENCES `oficina` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_usuario_oficina_favorita_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
