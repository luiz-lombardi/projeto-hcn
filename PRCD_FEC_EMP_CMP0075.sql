CREATE OR REPLACE PROCEDURE PRCD_FEC_EMP_CMP0075 (P_ID_UNN     IN NUMBER,
                                                  P_ID_EMP_NEW IN NUMBER,
                                                  P_ID_EMP_REF IN NUMBER)
IS
BEGIN

   insert into custo
     select id_unn, P_ID_EMP_NEW, id_pro, cd_tipo_custo, vl_custo_sem_icms, vl_custo_com_icms,
            vl_custo_ind_sem_icms, vl_custo_ind_com_icms, cd_situacao, dt_custo
      from custo
     where id_unn = P_ID_UNN
       and id_emp = P_ID_EMP_REF;
END PRCD_FEC_EMP_CMP0075;
/
