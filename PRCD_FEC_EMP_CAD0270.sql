CREATE OR REPLACE PROCEDURE PRCD_FEC_EMP_CAD0270 (P_ID_UNN     IN NUMBER,
                                                  P_ID_EMP_NEW IN NUMBER,
                                                  P_ID_EMP_REF IN NUMBER)
IS
BEGIN
  insert into emp_nivel_produto_2
    select id_unn, P_ID_EMP_NEW, id_np1, id_np2
      from emp_nivel_produto_2
     where id_unn = P_ID_UNN
       and id_Emp = P_ID_EMP_REF;
   COMMIT;
END PRCD_FEC_EMP_CAD0270;
/
