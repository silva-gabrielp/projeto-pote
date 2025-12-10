-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 10-Dez-2025 às 11:28
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
CREATE DATABASE IF NOT EXISTS `saude_mental` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `saude_mental`;

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
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_cartao` varbinary(64) NOT NULL,
  `codigo_seguranca` varbinary(16) NOT NULL,
  `data_validade` char(4) NOT NULL,
  `ultimos_digitos` char(4) NOT NULL
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
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_user` bigint(20) UNSIGNED DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` varbinary(60) DEFAULT NULL,
  `telefone` varchar(11) DEFAULT NULL,
  `oauth_facebook` varchar(255) DEFAULT NULL,
  `oauth_google` varchar(255) DEFAULT NULL,
  `oauth_apple` varchar(255) DEFAULT NULL,
  `oauth_telefone` varchar(255) DEFAULT NULL,
  `login_principal` enum('email','telefone','oauth') DEFAULT 'oauth',
  `conta_excluida` tinyint(1) DEFAULT 0,
  `data_exclusao` datetime(3) DEFAULT NULL,
  `data_cadastro` datetime(3) DEFAULT NULL,
  `email_verificado` tinyint(1) DEFAULT 0,
  `telefone_verificado` tinyint(1) DEFAULT 0,
  `telefone_e_whatsapp` tinyint(1) DEFAULT 0,
  `tipo_usuario` enum('usuario','profissional','empresa') NOT NULL,
  `ultimo_login` datetime(3) DEFAULT NULL,
  `tentativas_login` int(10) UNSIGNED DEFAULT 0,
  `firebase_uid` longtext DEFAULT NULL,
  `fk_profissional` bigint(20) UNSIGNED DEFAULT NULL,
  `fk_empresa` bigint(20) UNSIGNED DEFAULT NULL,
  `role` enum('admin','user','supervisor','tester') DEFAULT 'user',
  `data_atualizacao` datetime(3) DEFAULT NULL
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
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_cartao` bigint(20) UNSIGNED DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `bairro` varchar(120) DEFAULT NULL,
  `numero` bigint(20) NOT NULL,
  `complemento` varchar(120) DEFAULT NULL,
  `nome_completo` varchar(255) DEFAULT NULL,
  `fk_user` bigint(20) UNSIGNED DEFAULT NULL,
  `cidade` longtext NOT NULL,
  `estado` longtext NOT NULL,
  `pais` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_empresariais`
--

DROP TABLE IF EXISTS `dados_empresariais`;
CREATE TABLE `dados_empresariais` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nome_clinica` varchar(255) NOT NULL,
  `nome_representante_legal` varchar(255) DEFAULT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `endereco_completo_clinica` varchar(255) DEFAULT NULL,
  `tipos_profissionais` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tipos_profissionais`)),
  `publico_alvo` varchar(255) DEFAULT NULL,
  `modalidade_atendimento` enum('presencial','online','ambos') DEFAULT 'ambos',
  `aceita_convenio` tinyint(1) DEFAULT 0,
  `convenios_aceitos` varchar(255) DEFAULT NULL,
  `realiza_reembolso` tinyint(1) DEFAULT 0,
  `observacoes_adicionais` varchar(500) DEFAULT NULL,
  `link_compartilhavel` varchar(500) DEFAULT NULL,
  `tipo_cobranca` enum('por_profissional','clinica','depende') NOT NULL,
  `fk_dados_acesso` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_pessoais`
--

DROP TABLE IF EXISTS `dados_pessoais`;
CREATE TABLE `dados_pessoais` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_dados_acesso` bigint(20) UNSIGNED DEFAULT NULL,
  `fk_configuracoes` bigint(20) UNSIGNED DEFAULT NULL,
  `fk_dados_cobranca` bigint(20) UNSIGNED DEFAULT NULL,
  `nome_completo` varchar(255) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `cpf` char(11) DEFAULT NULL,
  `genero` enum('homem','mulher','outro') DEFAULT NULL,
  `imagem_perfil` longblob DEFAULT NULL,
  `ultima_atualizacao` datetime(3) DEFAULT current_timestamp(3),
  `pais` varchar(100) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `cidade` varchar(120) DEFAULT NULL,
  `regiao_zona` varchar(120) DEFAULT NULL,
  `telefone_emergencia_1` varchar(11) DEFAULT NULL,
  `telefone_emergencia_2` varchar(11) DEFAULT NULL,
  `telefone_emergencia_3` varchar(11) DEFAULT NULL,
  `plano` tinyint(3) UNSIGNED DEFAULT NULL,
  `telefone_emergencia1` varchar(11) DEFAULT NULL,
  `telefone_emergencia2` varchar(11) DEFAULT NULL,
  `telefone_emergencia3` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dados_profissionais`
--

DROP TABLE IF EXISTS `dados_profissionais`;
CREATE TABLE `dados_profissionais` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_atendimento` bigint(20) UNSIGNED DEFAULT NULL,
  `profissao` enum('psicologo','psiquiatra','neuropsicologo','psicologo_psiquiatra','psicologo_neuropsicologo','psiquiatra_neuropsicologo','outra') NOT NULL,
  `profissao_outra` varchar(120) DEFAULT NULL,
  `crp` varchar(50) DEFAULT NULL,
  `outro_registro` varchar(50) DEFAULT NULL,
  `publico_alvo` varchar(255) DEFAULT NULL,
  `temas_abordados` varchar(255) DEFAULT NULL,
  `modalidade_atendimento` enum('presencial','online','ambos') NOT NULL,
  `aceita_convenio` tinyint(1) DEFAULT 0,
  `convenios_aceitos` varchar(255) DEFAULT NULL,
  `realiza_reembolso` tinyint(1) DEFAULT 0,
  `observacoes_adicionais` varchar(500) DEFAULT NULL,
  `profissional_empresa` tinyint(1) DEFAULT 0,
  `empresa` bigint(20) UNSIGNED DEFAULT NULL,
  `esta_divulgado` tinyint(1) DEFAULT 0,
  `link_compartilhavel` varchar(500) DEFAULT NULL,
  `e_psicologo` tinyint(1) DEFAULT 0,
  `e_psiquiatra` tinyint(1) DEFAULT 0,
  `e_neuropsicologo` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `id` bigint(20) UNSIGNED NOT NULL,
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `data_criacao` datetime(3) DEFAULT NULL,
  `data_atualizacao` datetime(3) DEFAULT NULL,
  `origem` enum('pote','desafio','oficina','outro') NOT NULL,
  `topico` varchar(255) DEFAULT NULL,
  `texto` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `erro_app`
--

DROP TABLE IF EXISTS `erro_app`;
CREATE TABLE `erro_app` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data_criacao` datetime(3) DEFAULT NULL,
  `tipo_erro` varchar(120) DEFAULT NULL,
  `origem` varchar(120) DEFAULT NULL,
  `mensagem` varchar(500) DEFAULT NULL,
  `fk_criador` bigint(20) UNSIGNED DEFAULT NULL,
  `contador` tinyint(3) UNSIGNED DEFAULT 1,
  `foi_crado_por_usuario` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estatisticas_app`
--

DROP TABLE IF EXISTS `estatisticas_app`;
CREATE TABLE `estatisticas_app` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_dispositivos_sem_autenticacao` int(11) DEFAULT 0,
  `numero_usuarios` int(11) DEFAULT 0,
  `numero_profissionais` int(11) DEFAULT 0,
  `numero_empresas` int(11) DEFAULT 0,
  `numero_delecoes` int(11) DEFAULT 0,
  `numero_usuarios_pagos` int(11) DEFAULT 0,
  `ganhos` int(11) DEFAULT 0,
  `data_criacao` datetime(3) DEFAULT NULL,
  `data_atualizacao` datetime(3) DEFAULT NULL
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
  `pacientes` int(11) DEFAULT 0,
  `entraram_contato` int(11) DEFAULT 0,
  `agendamentos` int(11) DEFAULT 0,
  `likes_oficinas` int(11) DEFAULT 0,
  `likes_desafios` int(11) DEFAULT 0,
  `likes_comentarios` int(11) DEFAULT 0,
  `participantes_oficinas` int(11) DEFAULT 0,
  `participantes_desafios` int(11) DEFAULT 0,
  `participantes_atividades` int(11) DEFAULT 0,
  `ganhos` int(11) DEFAULT 0,
  `e_empresa` tinyint(1) DEFAULT 0,
  `numero_profissionais` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `notificacao`
--

DROP TABLE IF EXISTS `notificacao`;
CREATE TABLE `notificacao` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `target_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_group` tinyint(3) UNSIGNED DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `mensagem` text NOT NULL,
  `link_acao` varchar(500) DEFAULT NULL,
  `quando_enviar` datetime(3) DEFAULT NULL,
  `foi_enviado` tinyint(1) DEFAULT 0,
  `meio` enum('todos','in_app','out_app','email','whatsapp') DEFAULT 'out_app'
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
  `id` bigint(20) UNSIGNED NOT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `permite_sorteio_offline` tinyint(1) DEFAULT 0,
  `topico` varchar(255) DEFAULT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`items`)),
  `nome` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `relacionamento_dp_diarios`
--

DROP TABLE IF EXISTS `relacionamento_dp_diarios`;
CREATE TABLE `relacionamento_dp_diarios` (
  `fk_usuario` bigint(20) UNSIGNED NOT NULL,
  `fk_diario` bigint(20) UNSIGNED NOT NULL
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
  `id` bigint(20) UNSIGNED NOT NULL,
  `data_primeiro_acesso` datetime(3) DEFAULT NULL,
  `data_ultimo_acesso` datetime(3) DEFAULT NULL,
  `dispositivo` enum('web','android','ios') NOT NULL,
  `identificador` longtext DEFAULT NULL,
  `ip` varchar(64) NOT NULL,
  `dispositivo_info` longtext DEFAULT NULL,
  `location` longtext DEFAULT NULL
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
-- Índices para tabela `cartao`
--
ALTER TABLE `cartao`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_dados_acesso_fk_user` (`fk_user`),
  ADD UNIQUE KEY `idx_dados_acesso_email` (`email`),
  ADD UNIQUE KEY `idx_dados_acesso_telefone` (`telefone`),
  ADD UNIQUE KEY `idx_dados_acesso_fk_profissional` (`fk_profissional`),
  ADD UNIQUE KEY `idx_dados_acesso_fk_empresa` (`fk_empresa`),
  ADD UNIQUE KEY `idx_acesso_firebase_uid` (`firebase_uid`) USING HASH,
  ADD KEY `idx_acesso_deleted_at` (`data_exclusao`);

--
-- Índices para tabela `dados_cobranca`
--
ALTER TABLE `dados_cobranca`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dados_cobranca_cartao` (`fk_cartao`);

--
-- Índices para tabela `dados_empresariais`
--
ALTER TABLE `dados_empresariais`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_dados_empresariais_fk_dados_acesso` (`fk_dados_acesso`),
  ADD UNIQUE KEY `idx_dados_empresariais_cnpj` (`cnpj`);

--
-- Índices para tabela `dados_pessoais`
--
ALTER TABLE `dados_pessoais`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fk_dados_acesso` (`fk_dados_acesso`),
  ADD UNIQUE KEY `idx_dados_pessoais_fk_configuracoes` (`fk_configuracoes`),
  ADD UNIQUE KEY `idx_dados_pessoais_cpf` (`cpf`),
  ADD KEY `fk_dp_cobranca` (`fk_dados_cobranca`),
  ADD KEY `fk_dados_pessoais_tipo_plano` (`plano`);

--
-- Índices para tabela `dados_profissionais`
--
ALTER TABLE `dados_profissionais`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_dados_profissionais_fk_atendimento` (`fk_atendimento`),
  ADD KEY `fk_dados_profissionais_dados_empresariais` (`empresa`);

--
-- Índices para tabela `desafio`
--
ALTER TABLE `desafio`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_desafio_titulo` (`titulo`),
  ADD KEY `fk_desafio_criador` (`fk_criador`);

--
-- Índices para tabela `diario`
--
ALTER TABLE `diario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_diario_usuario` (`fk_usuario`);

--
-- Índices para tabela `oficina`
--
ALTER TABLE `oficina`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_oficina_criador` (`fk_criador`);

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
-- Índices para tabela `pote`
--
ALTER TABLE `pote`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_pote_nome` (`nome`) USING HASH;

--
-- Índices para tabela `relacionamento_dp_diarios`
--
ALTER TABLE `relacionamento_dp_diarios`
  ADD PRIMARY KEY (`fk_usuario`,`fk_diario`),
  ADD KEY `fk_relacionamento_dp_diarios_diario` (`fk_diario`);

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
-- Índices para tabela `usuario_sem_autenticacao`
--
ALTER TABLE `usuario_sem_autenticacao`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_usuario_sem_autenticacao_identificador` (`identificador`) USING HASH;

--
-- AUTO_INCREMENT de tabelas despejadas
--

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
-- AUTO_INCREMENT de tabela `cartao`
--
ALTER TABLE `cartao`
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
-- AUTO_INCREMENT de tabela `diario`
--
ALTER TABLE `diario`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `oficina`
--
ALTER TABLE `oficina`
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
-- AUTO_INCREMENT de tabela `usuario_sem_autenticacao`
--
ALTER TABLE `usuario_sem_autenticacao`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `atividade`
--
ALTER TABLE `atividade`
  ADD CONSTRAINT `fk_atividade_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_profissionais` (`id`);

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
  ADD CONSTRAINT `fk_dp_cobranca` FOREIGN KEY (`fk_dados_cobranca`) REFERENCES `dados_cobranca` (`id`),
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
-- Limitadores para a tabela `diario`
--
ALTER TABLE `diario`
  ADD CONSTRAINT `fk_diario_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_diario_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `oficina`
--
ALTER TABLE `oficina`
  ADD CONSTRAINT `fk_oficina_criador` FOREIGN KEY (`fk_criador`) REFERENCES `dados_profissionais` (`id`);

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
-- Limitadores para a tabela `relacionamento_dp_diarios`
--
ALTER TABLE `relacionamento_dp_diarios`
  ADD CONSTRAINT `fk_rel_diario` FOREIGN KEY (`fk_diario`) REFERENCES `diario` (`id`),
  ADD CONSTRAINT `fk_rel_user` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`),
  ADD CONSTRAINT `fk_relacionamento_dp_diarios_diario` FOREIGN KEY (`fk_diario`) REFERENCES `diario` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_relacionamento_dp_diarios_usuario` FOREIGN KEY (`fk_usuario`) REFERENCES `dados_pessoais` (`id`) ON DELETE CASCADE;

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
