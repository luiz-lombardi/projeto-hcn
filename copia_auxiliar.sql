--**************************************************************
--*   Copia dados da tabela EMPRESA_PARAMETRO
--**************************************************************
accept NEW_ID_EMP   prompt 'Informe a Loja Nova: '
accept LOJA_ORIGEM  prompt 'Informe a Loja Origem: '
insert into EMPRESA_PARAMETRO
select
ID_UNN,
&NEW_ID_EMP,
CD_ATU_CUSTO_TRANSF,
PZ_REABAST_LOJA,
ID_REDE,
NM_DIRETORIO,
ID_VEN_GENERICO,
ID_EMP_REABAST,
CD_EXIBE_MARGEM,        
CD_SUBST_BARR,
CD_IMP_DESC_ORC,
CD_NFS_UNICA,
DS_DIRETORIO,
CD_DESC_FORNECEDOR,
CD_SOLICITA_COMPRA,
CD_ORC_SEM_CAD,
CD_VL_FATURA,
CD_LIBERA_COND_CLIENTE,
CD_LIM_CRED,
PC_EXCEDIDO,
VL_EXCEDIDO,
CD_AUTOR_VENDAS,
CD_AUTOR_FINANC,
CD_DUPLIC_ATRASO,
CD_LIBERA_DUPLIC_ATRASO,
CD_ANALISE_CLIENTE,
CD_LIBERA_ANALISE_CLIENTE,
CD_PESQ_CREDITO,
CD_LIBERA_PESQ_CREDITO,
CD_CARTORIO,
CD_LIBERA_CARTORIO,
CD_EMITE_DEVOL,
IP_FORMS_WEB,
CD_ALT_PR_VEN,
CD_PC_ALT_PR_VEN,
CD_DEV_GERA_CRED,
NM_EMAIL_VCS,
CD_IMPR_TOT_PED,
CD_DESC_ITEM,
CD_DESC_PED,
CD_ALT_DESC_GER,
CD_PERIODO_ENTREGA,
CD_EMP_SAI,
CD_TP_LOC_SAI,
CD_TP_ESTOQUE,
CD_NFE_UNICA,
CD_EMITE_NFE_DEVOL,
CD_INCLUI_FRETE,
CD_INCL_CLI_SEM_CPFCNPJ,
&LOJA_ORIGEM,
CD_INCLUI_FRETE_DEV,
CD_COMISS_ENC_NF,
CD_DEVOL_SEM_NOTA,
CD_COMP_AUTO,
CD_COMP_RESFIS,
CD_COMP_RESFUT,
CD_IMPRIME_PED,
CD_RECEBIMENTO_COLETOR,
PC_ALIQ_ICMS_PADRAO,
ID_UNN_REABAST,
PC_DESC_CD_DIST,
CD_TIPO_ORC,
CD_MONTA_CARGA_PARC,
CD_ALT_TP_ESTOQUE,
CD_AGRUPA_PTR,
CD_CHECA_ENGRADADO,
CD_FRETE,
CD_DESTACA_IPI,
CD_DESC_FRETE,
CD_ALTERA_EMBAL_COMP,
CD_ALTER_CLICPFCNPJ,
CD_SERV_REPORTS_WEB,
CD_PERMITE_MANUT_COMP,
CD_AGREGA_IPI,
CD_DESCONTO_FRETE,
CD_HABILITA_HR_ENTREGA,
CD_CADASTRA_CLIENTE,
ID_CPG_AURA,
NR_DIAS_MAX_PROR_VALID,
NR_DIAS_MAX_PROR_ENTREGA,
NR_DIAS_MAX_PROR_VALID_VENC,
CD_APROVA_RUPTURA,
CD_SENHA_BCO,
CD_DIR_CARGA_PDV,
CD_RECOLHE_IMPOSTO_FINANC,
NR_FONE_OBRIGATORIO,
CD_CHECA_INSCR_EST,
CD_PERM_MANUT_CADCLIE,
IP_SERV_BCO,
CD_CONFERENCIA_PEDIDO,
ID_ECOMMERCE,
CD_AGREGA_SUBST_TRIB,
CD_LOGISTICA_COLETOR,
ID_EMP_SAP,
ID_CLI_GENERICO,
NR_CERTIFICADO_GARANTECH,
CD_CALC_COMIS_ENTR,
CD_VALIDA_ESTOQUE_OFFLINE,
CD_INTEGRA_NFE,
CD_TRANSF_EST_EMP,
CD_DT_ENTREGA_NULA,
CD_CRT,
CD_CSOSN,
DIA_UTIL_ENTREGA_LOCAL,
PARCELA_FRETE,
CD_DIR_REPORTS_WEB,
CD_VENDA_DIRETA,
CD_POLITICA_FRETE_PROPRIA,
CD_VENDA_GARANTIA,
NR_CERTIFICADO_GARANTIA,
CD_ALTERA_DESCONTO,
CD_CAD_DESC_CARTAZ,
CD_IMPRIME_DEVOLUCAO,
CD_VALIDA_FRETE_MINIMO,
CD_INTEGRACAO,
CD_AGENDA_HORARIO_POSTERIOR,
CD_IMP_DEV_OUTRA_FILIAL,
CD_ALTERA_PED_OUTRA_FILIAL,
CD_BOTIQUE,
DS_LOCAL_PROD_VENDA,
NR_DIAS_MIN_ANTECIPA_ENTREGA,
CD_FORNEC_WS_NFE,
CD_VERSAO_NFE,
CD_PROMOCAO,
QT_DECIMAL_ALIQ_ICMS_SUB,
TP_AMB,
CD_EXIBE_PREVISAO_COMPRA
from EMPRESA_PARAMETRO
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela IMAGEM_EMPRESA
--**************************************************************
insert into IMAGEM_EMPRESA
select
ID_UNN,
&NEW_ID_EMP,
NM_LOCAL_IMAGEM,
NM_ARQUIVO
from IMAGEM_EMPRESA
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela EMPRESA_MENSAGEM
--**************************************************************
insert into EMPRESA_MENSAGEM
select
ID_UNN,
&NEW_ID_EMP,       
ID_MSG_PVD,
ID_MSG_NFS,
ID_MSG_PCP,
ID_MSG_DEV
from EMPRESA_MENSAGEM
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela CONEXAO_EMPRESA
--**************************************************************
insert into CONEXAO_EMPRESA
select
ID_UNN,
&NEW_ID_EMP,       
replace(SN_CONEXAO,'&LOJA_ORIGEM','&NEW_ID_EMP')
from CONEXAO_EMPRESA
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela PDV_PARAMETRO
--**************************************************************
insert into PDV_PARAMETRO
select
ID_UNN,
&NEW_ID_EMP,
MSG_TELA,
MSG_CUPOM_1,
MSG_CUPOM_2,
MSG_CUPOM_3,
MOEDA_SINGULAR,
MOEDA_PLURAL,
MOEDA_SIMBOLO,
MAX_PRECO_ITEM,
MAX_VL_CUPOM,
MAX_QT_ITEM,
MAX_ITENS_CUPOM,
IMPR_IT_VENDIDOS,
QT_USA_DECIMAIS,
FTROCO_AUTOMATICO,
FTROCO_VALOR,
ID_CPG_DEFAULT,
ID_FIN,
PC_DESCONTO,
CD_SERVIDOR,
CD_TIMER,
CD_VENDEDOR,
CD_TEF,
CD_GARANTIA_CHEQUE,
CD_TELECHEQUE,
CD_SERASA,
CD_CLI_NEGATIVADO,
CD_IMPRIME_PEDIDO,
ID_ENDERECO_TEF,
TF_EMPRESA,
CANCELA_ITEM_CF,
DESCONTO_ITEM_CF,
CHEQUE_IMPRIME,
CHEQUE_AUTENTICA,
CHEQUE_CIDADE,
'Home Center Nordeste',
CHEQUE_TELEFONE,
CHEQUE_CGC_CPF,
CHEQUE_NR_CONTA,
CHEQUE_NR_CHEQUE,
CHEQUE_NR_IDENTIDADE,
A_VISTA_DINHEIRO,
A_VISTA_CHEQUE,
A_VISTA_CHEQUE_PRE,
A_VISTA_CUPOM,
A_VISTA_CRT_CREDITO,
A_VISTA_CRT_DEBITO,
A_VISTA_CRT_PROPRIO,
A_VISTA_CRT_MANUAL,
A_VISTA_CREDIARIO,
A_VISTA_PLANOS,
A_VISTA_LIVRE1,
A_VISTA_LIVRE2,
A_VISTA_LIVRE3,
A_VISTA_LIVRE4,
A_VISTA_LIVRE5,
A_VISTA_LIVRE6,
A_VISTA_LIVRE7,
A_VISTA_LIVRE8,
A_VISTA_LIVRE9,
A_VISTA_LIVRE10,
CD_ALT_CPG_PVD,
DIAS_ALT_SENHA,
MSG_CUP_VALE_1,
MSG_CUP_VALE_2,
MSG_CUP_VALE_3,
DIAS_VALID_VALE,
DS_MIDIA,
CD_LOCAL_TXT,
CD_ON_LINE,
CD_IMP_CUP_CHEQUE,
CD_AUT_CONTRA_VALE,
CD_CONF_CONTRA_VALE,
CD_ALT_VENCTO,
'Home Center Nordeste',
CD_IMP_TXT_PED,
VL_SOLIC_SANGRIA,
CD_SANG_DINHEIRO,
CD_SANG_CHEQUE,
CD_SANG_CHEQUE_PRE,
CD_SANG_CUPOM,
CD_SANG_CREDIARIO,
CD_SANG_CRT_CREDITO,
CD_SANG_CRT_DEBITO,
CD_SANG_CRT_PROPRIO,
CD_SANG_CRT_MANUAL,
CD_SANG_PLANOS,
CD_SANG_LIVRE1,
CD_SANG_LIVRE2,
CD_SANG_LIVRE3,
CD_SANG_LIVRE4,
CD_SANG_LIVRE5,
CD_SANG_LIVRE6,
CD_SANG_LIVRE7,
CD_SANG_LIVRE8,
CD_SANG_LIVRE9,
CD_SANG_LIVRE10,
CD_AUT_PEDIDO_VENDA,
QT_AUT_PEDIDO_VENDA,
QT_AUT_CONTRA_VALE,
MSG_FIDELI,
CD_IMP_CUP_FIDELI,
CD_FIDELI,
CD_PARAM,
CD_CEP,
CD_SOLIC_PRECO,
CD_NF_PAULISTA,
CD_SERVIDOR_BACKUP,
DS_AURA,
CD_LANCA_PEDIDO_RETIRA,
CD_VENDEDOR_PEDIDO,
CD_CAPTURA_LOTE_PRODUTO,
CD_TRANSFPEDRETAUTSERV,
CD_RATEIA_DESC_ITENS_AUT,
CD_BANDEIRA_CRT_DEBITO,
CD_MSG_CUPOM_MANIA
from PDV_PARAMETRO
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela EMP_PLANOS_PAGAMENTO
--**************************************************************
insert into EMP_PLANOS_PAGAMENTO
select
ID_UNN,
&NEW_ID_EMP,
ID_CPG,
ID_PLPG
from EMP_PLANOS_PAGAMENTO
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela EMPRESA_COND_PAGTO
--**************************************************************
insert into EMPRESA_COND_PAGTO
select
ID_UNN,
&NEW_ID_EMP,
ID_CDI,
ID_CPG,
CD_SITUACAO
from EMPRESA_COND_PAGTO
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela MERCADOLOGICO_COND_PAGTO
--**************************************************************
insert into MERCADOLOGICO_COND_PAGTO
select 
ID_UNN,
&NEW_ID_EMP,
ID_CDI,
ID_CPG,
ID_NP123,
CD_SITUACAO
from mercadologico_cond_pagto
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Atualiza dados da tabela MODAL_EMPRESA
--**************************************************************
--update modal_empresa set ID_EMP_CDI = ID_EMP
--where id_unn = 1 and id_emp = &NEW_ID_EMP;
--**************************************************************
--*   Copia dados da tabela TIPO_ESTOQUE
--**************************************************************
insert into TIPO_ESTOQUE
select 
ID_UNN,
&NEW_ID_EMP,
ID_TES,
CD_SITUACAO,
CD_COMPOE_EST_GERAL,
CD_MOVIM_EST
from TIPO_ESTOQUE
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela OUTROS_RECEBIMENTOS
--**************************************************************
insert into OUTROS_RECEBIMENTOS
select 
ID_UNN,
&NEW_ID_EMP,
ID_IPR,
NM_DESCRICAO,
VL_PRECO,
CD_TIPO
from OUTROS_RECEBIMENTOS
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Atualiza Empresa Default da tabela EMPRESA_CDI
--**************************************************************
insert into EMPRESA_CDI
select
ID_UNN,
&NEW_ID_EMP,
ID_CDI,
ID_GRCDI,
ID_GRPRE,
CD_SITUACAO,
ID_TP_LOC_RET,
ID_TP_LOC_ENT,
NR_DIAS_VALID_ORCAM,
NR_DIAS_VALID_PED_VDA,
NR_DIAS_VALID_PED_TRF,
ID_COND_PG_DEFAULT,
PC_CUSTO_OPER,
ID_EMP_DEF,
CD_IMP_PED,
CD_VERIF_EST_ENCOM,
NR_HORAS_VALID_ORCAM,
NR_HORAS_VALID_PED_VDA,
NR_HORAS_VALID_PED_TRF,
PZ_MAX_ENT_PED_VDA,
PZ_MAX_ENT_POST_PED_VDA,
NR_DIAS_MAX_VALID_PED_VDA,
CD_IMP_PED_GER
from EMPRESA_CDI
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela MODAL_EMPRESA
--**************************************************************
insert into MODAL_EMPRESA
select
ID_UNN,
ID_EMP,
ID_CDI,
&NEW_ID_EMP,
CD_SITUACAO,
ID_UNN_CDI,
CD_MODAL_ENT,
CD_TIPO,
PZ_TRANSF
from MODAL_EMPRESA
where id_unn = 1 and id_emp = &NEW_ID_EMP
  and id_emp_cdi = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela GRUPO_CANAL_DIST
--**************************************************************
insert into GRUPO_CANAL_DIST
select
ID_UNN,
&NEW_ID_EMP,
ID_GRCDI,
NM_GRCDI,
CD_SITUACAO
from GRUPO_CANAL_DIST
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela EMP_NUMERO_NF
--**************************************************************
insert into EMP_NUMERO_NF
values (1,&NEW_ID_EMP,0)
/


