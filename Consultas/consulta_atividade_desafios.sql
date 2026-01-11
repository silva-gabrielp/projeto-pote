CREATE OR REPLACE VIEW vw_atividade_desafio_usuario AS

/* =========================
   ATIVIDADES
   ========================= */
SELECT
    a.id                                AS conteudo_id,
    'ATIVIDADE'                         AS tipo_conteudo,

    a.fk_criador                        AS fk_criador,
    au.fk_usuario                       AS fk_usuario,

    a.titulo                            AS titulo,
    a.sobre                             AS descricao,
    a.tema                              AS tema,

    a.data_criacao                     AS data_criacao,
    a.data_atualizacao                 AS data_atualizacao,

    a.duracao                           AS duracao,
    a.tem_video                         AS tem_video,
    a.link_video                        AS link_video,

    a.likes                             AS likes,
    a.deslikes                          AS deslikes,
    a.visualizacoes                     AS visualizacoes,
    a.numero_participantes              AS numero_participantes,

    au.data_inicio                      AS data_inicio_usuario,
    au.data_fim                         AS data_fim_usuario,
    au.completado                       AS completado,
    au.etapas_feitas                    AS etapas_feitas,

    a.etapas                            AS etapas,
    a.image                             AS imagem

FROM atividade a
LEFT JOIN atividade_user au
       ON au.fk_atividade = a.id


UNION ALL


/* =========================
   DESAFIOS
   ========================= */
SELECT
    d.id                                AS conteudo_id,
    'DESAFIO'                           AS tipo_conteudo,

    d.fk_criador                        AS fk_criador,
    du.fk_usuario                       AS fk_usuario,

    d.titulo                            AS titulo,
    NULL                                AS descricao,
    NULL                                AS tema,

    d.data_criacao                     AS data_criacao,
    d.data_atualizacao                 AS data_atualizacao,

    d.duracao                           AS duracao,
    NULL                                AS tem_video,
    NULL                                AS link_video,

    d.likes                             AS likes,
    d.deslikes                          AS deslikes,
    d.visualizacoes                     AS visualizacoes,
    d.numero_participantes              AS numero_participantes,

    du.data_inicio                      AS data_inicio_usuario,
    du.data_fim                         AS data_fim_usuario,
    du.completado                       AS completado,
    du.etapas_feitas                    AS etapas_feitas,

    d.etapas                            AS etapas,
    d.image                             AS imagem

FROM desafio d
LEFT JOIN desafio_user du
       ON du.fk_desafio = d.id;