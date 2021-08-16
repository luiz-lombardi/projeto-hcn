CREATE OR REPLACE PROCEDURE PRCD_FEC_EMP_VDA0010 (P_ID_UNN IN NUMBER,
                                                  P_ID_EMP_NEW IN NUMBER,
                                                  P_ID_EMP_REF IN NUMBER)
IS
BEGIN
  insert into vendedor values
   (P_ID_UNN, P_ID_EMP_NEW, 0, 1, 1, 'AUTO SERVICO', null, 'V', 0, 0, '123', 1);
   commit;
END PRCD_FEC_EMP_VDA0010;
/
