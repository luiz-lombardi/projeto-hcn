CREATE OR REPLACE PROCEDURE PRCD_FEC_EMP_PRE0010 (P_ID_UNN     IN NUMBER,
                                                  P_ID_EMP_NEW IN NUMBER,
                                                  P_ID_EMP_REF IN NUMBER)
IS
BEGIN

   delete from preco where id_unn = p_id_unn and id_Emp = p_id_emp_new;

   begin

      insert into grupo_preco
          select id_unn, p_id_emp_new, id_grpre, nm_grpre, cd_situacao
            from grupo_preco
           where id_unn  = p_id_unn
             and id_Emp  = p_id_emp_ref;
   exception
        when dup_val_on_index then
           null;
   end;

   insert into preco
     select id_unn, P_ID_EMP_NEW, id_grpre, id_ipr, id_emb, id_pro, id_spr, vl_preco,
            cd_situacao, nr_lote_max_venda, dt_inicio_prom, dt_fim_promocao, pc_desc_prom,
            dt_ult_prec, pc_marg_ideal, id_tmp
       from preco
      where id_unn = P_ID_UNN
        and id_Emp = P_ID_EMP_REF;

   commit;

END PRCD_FEC_EMP_PRE0010;
/
