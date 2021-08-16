--**************************************************************
--*   Copia pedidos de encomenda pagos
--**************************************************************
accept NEW_ID_EMP   prompt 'Informe a Loja Nova: '
accept LOJA_ORIGEM  prompt 'Informe a Loja Origem: '
insert into PEDIDO_VENDA
select
ID_UNN,
&NEW_ID_EMP,
ID_PVD,
ID_VEN,
ID_TRANSP,
ID_CDI,
ID_UNN_NF,
--ID_EMP_NF,
&NEW_ID_EMP,
ID_CLI,
CD_TIPO_END,
ID_END,
ID_CLI_PRE,
CD_TIPO_END_PRE,
ID_END_PRE,
CD_TIPO_END_COB,
ID_END_COB,
VL_MERCAD,
VL_DESC_TOT_IT,
VL_DESCONTO,
VL_DESPESAS,
VL_FRETE,
VL_DESP_FINANC,
VL_ENTRADA,
VL_JUROS,
VL_FINANC,
VL_TOTAL,
DT_PEDIDO,
DT_ENTREGA,
DT_PAGTO,
OB_OBSERV,
ST_SIT_PED,
CD_TIPO_PED,
CD_MODAL_ENT,
CD_ENCOMENDA,
CD_SIT_CARGA,
CD_SITUACAO,
ID_LOTE,
NM_CLI_ORC,
NR_FONE_ORC,
DT_CANCELA,
VL_DESCONTO_SUP,
NR_PDV,
NR_CUPOM,
ID_SUP,
CD_CRED_LIB,
CD_SIT_UTIL,
ID_ORDEM,
CD_BLOQUEADO,
NM_RUA,
NM_BAIRRO,
NM_CIDADE,
ID_EST,
ID_CEP,
DT_MANUTENCAO,
ID_TP_LOC,
ID_PROMOTOR,
CD_TIPO_MOV,
CD_TIPO_ORC
from PEDIDO_VENDA
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and dt_pedido > '01/01/2007'
  and cd_encomenda = 'S'
  and st_sit_ped not in (40,99);
--**************************************************************
--*   Copia itens dos pedidos de encomenda pagos
--**************************************************************
insert into ITEM_PEDIDO_VENDA
select
ID_UNN,
&NEW_ID_EMP,
ID_PVD,
ID_IPR,
ID_EMB,
ID_PRO,
ID_GRCDI,
ID_TP_LOC,
ID_LOCAL,
CD_SITUACAO,
VL_PRECO,
QT_VENDIDA,
QT_RESERVA,
QT_RESFUT,
QT_RESTRANS,
QT_FATUR,
QT_ENT_RET,
DT_ENT_RET,
PC_DESC,
PC_IPI,
VL_IPI,
VL_LIQ_IT,
VL_TOTAL,
NM_COMPL_IPR,
ST_SIT_PED,
SQ_ITEM,
ID_LOT_EST,
VL_CUSTO,
CD_IMP,
PC_ALIQ_ICMS
from ITEM_PEDIDO_VENDA
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and id_pvd in 
  (select id_pvd from pedido_venda 
   where id_unn = 1 and id_emp = &LOJA_ORIGEM
     and dt_pedido > '01/01/2007'
     and cd_encomenda = 'S'
     and st_sit_ped not in (40,99));
--**************************************************************
--*   Copia condição pagto. pedidos de encomenda 
--**************************************************************
insert into PEDIDO_VENDA_COND_PAGTO
select
ID_UNN,
&NEW_ID_EMP,
ID_PVD,
ID_CPG,
VL_TOTAL,
CD_SITUACAO
from PEDIDO_VENDA_COND_PAGTO
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and id_pvd in 
  (select id_pvd from pedido_venda 
   where id_unn = 1 and id_emp = &LOJA_ORIGEM
     and dt_pedido > '01/01/2007'
     and cd_encomenda = 'S'
     and st_sit_ped not in (40,99));      
--**************************************************************
--*   Copia motivo desconto pedidos de encomenda 
--**************************************************************
insert into PEDIDO_VENDA_COMPLEMENTO
select
ID_UNN,
&NEW_ID_EMP,
ID_PVD,
ID_TDM,
ID_USU,
ID_OUTM,
CD_VENDA_TERCEIRO,
VL_MARKUP,
PC_ACRESC,
VL_CUSTO,
VL_TOTAL_LIQ,
VL_TOTAL,
OB_OBSERV,
TP_ACRESC,
NM_CONTATO,
LIMITE_CRED_EXCEDE,
CD_MENS_NOTA,
ALTERA_DT,
ID_PROF,
CIF_FOB,
CD_BLQ_COND_PGTO,
CD_BLQ_QT_VEND,
CD_ORGAO_PUBLICO,       
CD_REC_LOCAL,
ID_TMD,
CD_CALC_PROM,
QT_PRAZO_MEDIO
from PEDIDO_VENDA_COMPLEMENTO
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and id_pvd in 
  (select id_pvd from pedido_venda 
   where id_unn = 1 and id_emp = &LOJA_ORIGEM
     and dt_pedido > '01/01/2007'
     and cd_encomenda = 'S'
     and st_sit_ped not in (40,99));
--**************************************************************
--*   Lista pedidos interestaduais pagos no pdv
--**************************************************************     
select * from PEDIDO_VENDA
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and dt_pedido > '01/01/2007'
  and cd_situacao = 2
  and st_sit_ped = 12
/
