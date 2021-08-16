accept NEW_ID_EMP   prompt 'Informe a Loja Nova: '
accept LOJA_ORIGEM  prompt 'Informe a Loja Origem: '
--**************************************************************
--*   Move usuários do Banco Oracle para Loja Nova
--**************************************************************
update usuario set id_emp = &NEW_ID_EMP where id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Move usuários da Intranet para Loja Nova
--**************************************************************
update tendtudo.usuarios set id_emp = &NEW_ID_EMP where id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela VENDEDOR
--**************************************************************
--update VENDEDOR set ID_EMP = &NEW_ID_EMP
--where id_unn = 1 and id_emp = &LOJA_ORIGEM
--  and id_ven <> 0;  
insert into VENDEDOR
select
ID_UNN,
&NEW_ID_EMP,
ID_VEN,
ID_CDI,
CD_SITUACAO,
NM_VEN,
ID_VEN_VEN,
CD_TIPO_VEN,
PC_COMISSAO,
PC_DESCONTO,
SN_SENHA,
QT_CICLO_VISITA,
NM_EMAIL,
CD_REENVIA_MAIL,
NR_CPF                         
from VENDEDOR
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and id_ven <> 0;
--**************************************************************
--*   Copia dados da tabela OPERADOR
--**************************************************************
--update OPERADOR set ID_EMP = &NEW_ID_EMP
--where id_unn = 1 and id_emp = &LOJA_ORIGEM
--  and id_ope <> 0;
insert into OPERADOR
select
ID_UNN,
&NEW_ID_EMP,
ID_OPE,
NM_OPE,
SN_SENHA,
CD_NIVEL,
CD_ATIVO,
CD_SITUACAO,
PC_DESCONTO,
DT_ULT_ALT,
NR_CPF
from OPERADOR
where id_unn = 1 and id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela MATRICULA
--**************************************************************
update MATRICULA set ID_EMP = &NEW_ID_EMP
where id_unn = 1 and id_emp = &LOJA_ORIGEM
/
