CREATE OR REPLACE VIEW vw_profissionais_busca AS
SELECT
    dp.id AS profissional_id,

    /* Dados pessoais */
    pes.nome_completo,
    pes.estado,
    pes.cidade,

    /* Tipo de profissional derivado */
    CASE
    	WHEN dp.e_psicologo = 1 THEN 'Psicólogo'
    	WHEN dp.e_psiquiatra = 1 THEN 'Psiquiatra'
    	WHEN dp.e_neuropsicologo = 1 THEN 'Neuropsicólogo'
    	ELSE 'Outro'
	END AS tipo_profissional,

    /* Flags originais (opcional manter) */
    dp.e_psicologo,
    dp.e_psiquiatra,
    dp.e_neuropsicologo,

    /* Informações profissionais */
    dp.modalidade_atendimento,
    dp.aceita_convenio,
    dp.esta_divulgado

FROM dados_profissionais dp
INNER JOIN dados_pessoais pes
    ON pes.id = dp.fk_dados_pessoais;