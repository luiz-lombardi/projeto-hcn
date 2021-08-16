CREATE OR REPLACE PROCEDURE PRCD_FEC_EMP_EST0030 (P_ID_UNN     IN NUMBER,
                                                  P_ID_EMP_NEW IN NUMBER,
                                                  P_ID_EMP_REF IN NUMBER)
IS
BEGIN
  INSERT INTO ESTOQUE
    SELECT ID_UNN, P_ID_EMP_NEW, ID_GRCDI, ID_TP_LOC, ID_IPR, ID_PRO, ID_LOC,
           NM_BLOCO, NM_PRAT, NM_RUA, CD_SITUACAO, NR_DVE_MAX, NR_DVE_MIN, NR_DVE_PED,
           NR_MDV, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,
           0, 0, QT_EST_MAX, QT_EST_MIN
      FROM ESTOQUE
     WHERE ID_UNN = P_ID_UNN
       AND ID_EMP = P_ID_EMP_REF;
   COMMIT;
END PRCD_FEC_EMP_EST0030;
/
