--**************************************************************
--*   Copia dados da tabela PESSOA_JURIDICA
--*
--*   Verificar --> max(id_pju) from empresa
--**************************************************************
accept NR_INSCR     prompt 'Informe a Inscr.Estadual: '
accept NR_CGC       prompt 'Informe o CNPJ: '
accept NEW_ID_EMP   prompt 'Informe a Loja Nova: '
accept LOJA_ORIGEM  prompt 'Informe a Loja Origem: '
accept NM_FANTASIA  prompt 'Informe o Nome Fantasia: '
insert into PESSOA_JURIDICA
select (select max(id_pju)+1 from pessoa_juridica where id_pju < 50),
       CD_SITUACAO,
       'HOME CENTER NORDESTE COM. MAT. CONSTR. S/A',
       '&NR_INSCR',
       &NR_CGC,
       TP_INSCR,
       ID_POE,
       ID_RAT,
       ID_SEG,
       '01/03/2012',
       '&NM_FANTASIA',
       QT_FUNC,
       ID_EST_IE,
       '&NR_INSCR_MUNIC'
from PESSOA_JURIDICA
where id_pju = (select id_pju from empresa where id_emp = &LOJA_ORIGEM);
--**************************************************************
--*   Copia dados da tabela EMPRESA
--**************************************************************
insert into EMPRESA
select
ID_UNN,
&NEW_ID_EMP,
(select max(id_pju) from pessoa_juridica where id_pju < 50),
ID_GRE,
ID_CDI_DEFAULT,
ID_TP_LOC_REC_COMPRA,
ID_EMP_MATRIZ,
ID_EMP_CUSTO,
ID_EST,
ID_IMP,
ID_MSG,
TP_SERIE,
DT_PROCES,
CD_TIPO_EMP,
CD_VL_TRANSF,
CD_TIPO_CUSTO,
CD_FORMA_PAGTO,
CD_BXA_EST_AUTO,
CD_CUSTO_COM_ICMS,
PC_PIS,
PC_IOC,
PC_ISS,
PC_CURVA_A,
PC_CURVA_B,
PC_CURVA_C,
PC_JUROS_DIARIO,
PC_MULTA_DIARIA,
PC_CUSTO_OPERAC,
PC_CONTR_SOCIAL,
PC_MARGEM_RENTAB_IDEAL,
NR_MES_CONTABIL,
NR_MES_EXERC_FISCAL,
0,
PZ_ENTREGA,
PZ_MEDIO_ICMS,
PZ_MEDIO_COFINS,
PZ_MEDIO_ISS,
DEPOSITO,
NM_LOCAL_IMAGEM,
CD_SITUACAO,
CD_REC_COMPRA,
CD_ATU_STQ_FIN,
NR_DVE_MAX,
NR_DVE_MIN,
ID_TP_LOC_AS,
CD_EXTRA_PED,
CD_EXTRA_PROD,
NR_DVE_PED,
DS_SMTP,
PZ_REABAST_TRANSF,
PZ_ENTREGA_VIAGEM,
PORTA_SMTP,
PZ_ENTREGA_ECOMM,
PZ_PERIODO_ENTREGA,
CNAE,
CD_MENSAGEM,
CD_MENSAGEM_1,
EMAIL_NFE
from EMPRESA
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela ENDERECO_EMPRESA
--**************************************************************
insert into ENDERECO_EMPRESA
select
ID_UNN,
&NEW_ID_EMP,
CD_TIPO_END,
ID_END,
ID_CEP,
SQ_CEP,
ID_REG,
NR_IMOVEL,
CD_SITUACAO,
DS_COMPL
from ENDERECO_EMPRESA
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela CONTATO_EMPRESA
--**************************************************************
insert into CONTATO_EMPRESA
select
ID_UNN,
&NEW_ID_EMP,
CD_TIPO_END,
ID_END,
ID_CEM,
ID_CRG,
CD_SITUACAO,
NM_CEM,
DT_NASC,
NM_SETOR,
NM_EMAIL
from CONTATO_EMPRESA
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela TELEFONE_EMPRESA
--**************************************************************
insert into TELEFONE_EMPRESA
select
ID_UNN,
&NEW_ID_EMP,         
CD_TIPO_END,
ID_END,
ID_CEM,
NR_FONE,
CD_SITUACAO,
CD_TIPO_FONE,
NR_DDD,
NR_RAMAL
from TELEFONE_EMPRESA
where id_unn = 1 and id_emp = &LOJA_ORIGEM
/
