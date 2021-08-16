--**************************************************************
--*   Lista usuários do Banco Oracle
--**************************************************************
accept NEW_ID_EMP   prompt 'Informe a Loja Nova: '
accept LOJA_ORIGEM  prompt 'Informe a Loja Origem: '
select id_usu,nm_usu,id_unn,
       replace(id_emp,&LOJA_ORIGEM,&NEW_ID_EMP),
       id_gpr,cd_situacao
from usuario
where id_unn = 1 
  and id_emp = &LOJA_ORIGEM
  and id_usu not like '%&LOJA_ORIGEM%'
union all
select replace(id_usu,'&LOJA_ORIGEM','&NEW_ID_EMP'),
       replace(nm_usu,'&LOJA_ORIGEM','&NEW_ID_EMP'),
       id_unn,
       replace(id_emp,&LOJA_ORIGEM,&NEW_ID_EMP),
       id_gpr,
       cd_situacao 
from usuario 
where id_unn = 1 
  and id_emp = &LOJA_ORIGEM
  and id_usu like '%&LOJA_ORIGEM%';
--**************************************************************
--*   Move usuários do Banco Oracle para Loja Nova
--**************************************************************
--update usuario set id_emp = &NEW_ID_EMP where id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Move usuários da Intranet para Loja Nova
--**************************************************************
--update usuarios set id_emp = &NEW_ID_EMP where id_emp = &LOJA_ORIGEM;
--**************************************************************
--*   Copia dados da tabela VENDEDOR
--**************************************************************
insert into VENDEDOR
select
ID_UNN,
&NEW_ID_EMP,
ID_VEN,
ID_CDI,
CD_SITUACAO,
NM_VEN,
1001,
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
  and cd_situacao = 1
  and id_ven > 0;
--update VENDEDOR set ID_EMP = &NEW_ID_EMP
--where id_unn = 1 and id_emp = &LOJA_ORIGEM
--  and id_ven <> 0;  
--**************************************************************
--*   Copia dados da tabela OPERADOR
--**************************************************************
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
where id_unn = 1 and id_emp = &LOJA_ORIGEM
  and cd_ativo = 'S'
  and id_ope <> 0;
--update OPERADOR set ID_EMP = &NEW_ID_EMP
--where id_unn = 1 and id_emp = &LOJA_ORIGEM
--  and id_ope <> 0;
--**************************************************************
--*   Copia dados da tabela MATRICULA
--**************************************************************
--insert into MATRICULA
--select
--ID_MATRICULA,
--ID_UNN,
--&NEW_ID_EMP,
--ID_OPE
--from MATRICULA
--where id_unn = 1 and id_emp = &LOJA_ORIGEM;
update MATRICULA set ID_EMP = &NEW_ID_EMP
where id_unn = 1 and id_emp = &LOJA_ORIGEM
/
