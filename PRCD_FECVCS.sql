CREATE OR REPLACE PROCEDURE "PRCD_FECVCS"
IS
   P_ID_UNN   NUMBER(3) := 1;
   P_ID_EMP   NUMBER(3) := 18;    --> Empresa Matriz
   --
   CURSOR EMP IS
      SELECT DT_PROCES
        FROM EMPRESA
       WHERE ID_UNN  = P_ID_UNN
         AND ID_EMP  = P_ID_EMP;
   V_DT_PROCES  DATE;
   CURSOR FEC IS
      SELECT PROGRAMA, OBSERVACAO
        FROM CONTROLE_FECHAMENTO
       WHERE STATUS = 'S'
      ORDER BY SEQUENCIA;
   V_FEC FEC%ROWTYPE;
   V_COD_ERR  NUMBER(6);
   V_MES_ERR  VARCHAR2(300);
   V_DT_INI   DATE;
   V_DT_FIM   DATE;
BEGIN
   OPEN EMP;
   FETCH EMP INTO V_DT_PROCES;
   CLOSE EMP;
   IF V_DT_PROCES < TRUNC(SYSDATE) THEN
      PRCD_TRUNCA ('COMMERCE.ERROS_FECHAMENTO');
      PRCD_TRUNCA ('COMMERCE.OCORRENCIA');
      PRCD_TRUNCA ('COMMERCE.NIVEL_3');
      PRCD_TRUNCA ('COMMERCE.TIPO_CLF');
      PRCD_TRUNCA ('COMMERCE.PLANILHA_COMPRA');
      PRCD_TRUNCA ('COMMERCE.PLANILHA_COMPRA_FOR');
      PRCD_TRUNCA ('COMMERCE.PLANILHA_COMPRA_NP1');
      PRCD_TRUNCA ('COMMERCE.PLANILHA_COMPRA_EMP');
      PRCD_INPDV2(V_DT_PROCES);
      COMMIT;
      PRCD_SPR010(V_DT_PROCES);
      COMMIT;
      OPEN FEC;
      LOOP
         FETCH FEC INTO V_FEC;
         EXIT WHEN FEC%NOTFOUND;
         V_DT_INI := SYSDATE;
         IF    V_FEC.PROGRAMA = 'PRCD_FECPVD' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECPVD (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECPVD', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECPTR' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECPTR (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECPTR', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECPRE' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECPRE (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECPRE', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECCAM' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECCAM (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECCAM', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         --INCLUIDO 24/11/2005 RUTE      
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECMOV' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECMOV;   --- FAZ LOOP EM TODAS AS EMPRESAS
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECMOV', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
    --     ELSIF V_FEC.PROGRAMA = 'PRCD_FECPROM' THEN
    --           IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
    --              BEGIN
    --                 PRCD_FECPROM (P_ID_UNN, P_ID_EMP);
    --              EXCEPTION
    --                 WHEN OTHERS THEN
    --                    V_COD_ERR := SQLCODE;
    --                    V_MES_ERR := SQLERRM;
    --                    INSERT INTO ERROS_FECHAMENTO
    --                       (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
    --                    VALUES
    --                       (TRUNC(SYSDATE), 'PRCD_FECPROM', V_COD_ERR, V_MES_ERR);
    --              END;
    --           END IF;
         ELSIF V_FEC.PROGRAMA = 'GERA_EAN_TXT_PDV' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     GERA_EAN_TXT_PDV (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'GERA_EAN_TXT_PDV', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'GERA_PRO_TXT_PDV' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     GERA_PRO_TXT_PDV (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'GERA_PRO_TXT_PDV', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'GERA_CPG_NP3' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     GERA_CPG_NP3 (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'GERA_CPG_NP3', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
 --        ELSIF V_FEC.PROGRAMA = 'GERA_PED' THEN
 --              IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
 --                 BEGIN
 --                    GERA_PED;
 --                 EXCEPTION
 --                    WHEN OTHERS THEN
 --                       V_COD_ERR := SQLCODE;
 --                       V_MES_ERR := SQLERRM;
 --                       INSERT INTO ERROS_FECHAMENTO
 --                          (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
 --                       VALUES
 --                          (TRUNC(SYSDATE), 'GERA_PED', V_COD_ERR, V_MES_ERR);
 --                 END;
 --              END IF;
 --        ELSIF V_FEC.PROGRAMA = 'GERA_MM' THEN
 --              IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
 --                 BEGIN
 --                    SDICMM01D  (V_DT_PROCES);
 --                    SDICMM01TD (V_DT_PROCES);
 --                    SDICMM18D  (V_DT_PROCES);
 --                    SDICMM03D  (V_DT_PROCES);
 --                    SDICMM032D (V_DT_PROCES);
 --                    SDICMM05D  (V_DT_PROCES);
 --                    SDICMM08D  (V_DT_PROCES);
 --                    SDICMM11D  (V_DT_PROCES);
 --                    SDICMM12D  (V_DT_PROCES);
 --                    SDICMM03C  (V_DT_PROCES);
 --                 EXCEPTION
 --                    WHEN OTHERS THEN
 --                       V_COD_ERR := SQLCODE;
 --                       V_MES_ERR := SQLERRM;
 --                       INSERT INTO ERROS_FECHAMENTO
 --                          (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
 --                       VALUES
 --                          (TRUNC(SYSDATE), 'GERA_MM', V_COD_ERR, V_MES_ERR);
 --                 END;
 --              END IF;
 --        ELSIF V_FEC.PROGRAMA = 'GERA_MOVI' THEN
 --              IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
 --                 BEGIN
 --                    GERA_MOVI01(P_ID_UNN, P_ID_EMP);
 --                    GERA_MOVI02(P_ID_UNN, P_ID_EMP);
 --                    GERA_MOVI03(P_ID_UNN, P_ID_EMP);
 --                    GERA_MOVI04(P_ID_UNN, P_ID_EMP);
 --                    GERA_MOVI05(P_ID_UNN, P_ID_EMP);
 --                    GERA_MOVI06(P_ID_UNN, P_ID_EMP);
 --                 EXCEPTION
 --                    WHEN OTHERS THEN
 --                       V_COD_ERR := SQLCODE;
 --                       V_MES_ERR := SQLERRM;
 --                       INSERT INTO ERROS_FECHAMENTO
 --                          (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
 --                       VALUES
 --                          (TRUNC(SYSDATE), 'GERA_MOVI', V_COD_ERR, V_MES_ERR);
 --                 END;
 --              END IF;
 --        ELSIF V_FEC.PROGRAMA = 'GERA_PRO_SISCORP_DIA' THEN
 --              IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
 --                 BEGIN
 --                    GERA_PRO_SISCORP_DIA (V_DT_PROCES);
 --                 EXCEPTION
 --                    WHEN OTHERS THEN
 --                       V_COD_ERR := SQLCODE;
 --                       V_MES_ERR := SQLERRM;
 --                       INSERT INTO ERROS_FECHAMENTO
 --                          (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
 --                       VALUES
 --                          (TRUNC(SYSDATE), 'GERA_PRO_SISCORP_DIA', V_COD_ERR, V_MES_ERR);
 --                 END;
 --              END IF;
 --        ELSIF V_FEC.PROGRAMA = 'GERA_CLI_SISCORP_DIA' THEN
 --              IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
 --                 BEGIN
 --                    GERA_CLI_SISCORP_DIA (V_DT_PROCES);
 --                 EXCEPTION
 --                    WHEN OTHERS THEN
 --                       V_COD_ERR := SQLCODE;
 --                       V_MES_ERR := SQLERRM;
 --                       INSERT INTO ERROS_FECHAMENTO
 --                          (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
 --                       VALUES
 --                          (TRUNC(SYSDATE), 'GERA_CLI_SISCORP_DIA', V_COD_ERR, V_MES_ERR);
 --                 END;
 --              END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_POSCPA' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_POSCPA;  --- FAZ LOOP EMPRESA
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_POSCPA', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECMDV' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECMDV (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECMDV', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECMES' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECMES (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECMES', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_FECDIA' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FECDIA (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_FECDIA', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_PLA001' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_PLA001;
                     PRCD_PLA003;
                     PRCD_PLA005;
                     PRCD_PLA004;
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_PLA001', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_PLA002' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_PLA002 (P_ID_UNN, P_ID_EMP);
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_PLA002', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_VEREST' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_VEREST;
                     PRCD_VEREST_MES;
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_VEREST', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'PRCD_PROEXC' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_PROEXC;
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'PRCD_PROEXC', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;
         ELSIF V_FEC.PROGRAMA = 'VER_RESPED' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     VER_RESPED;
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'VER_RESPED', V_COD_ERR, V_MES_ERR);
                  END;
         			END IF;   
         ELSIF V_FEC.PROGRAMA = 'VER_FUTPED' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     VER_FUTPED;
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'VER_FUTPED', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;           
         ELSIF V_FEC.PROGRAMA = 'PRCD_FEC_EMP_NOVA' THEN
               IF TO_DATE(V_FEC.OBSERVACAO,'DD/MM/YYYY') < TRUNC(SYSDATE) THEN
                  BEGIN
                     PRCD_FEC_EMP_NOVA;
                  EXCEPTION
                     WHEN OTHERS THEN
                        V_COD_ERR := SQLCODE;
                        V_MES_ERR := SQLERRM;
                        INSERT INTO ERROS_FECHAMENTO
                           (DT_PROCES, NM_PROG, COD_ERR, MES_ERR)
                        VALUES
                           (TRUNC(SYSDATE), 'FEC_EMP_NOVA', V_COD_ERR, V_MES_ERR);
                  END;
               END IF;  
         END IF;
         V_DT_FIM := SYSDATE;
         INSERT INTO ERROS_FECHAMENTO
            (DT_PROCES, NM_PROG, MES_ERR)
         VALUES
            (TRUNC(SYSDATE), V_FEC.PROGRAMA,
             'Inicio : ' || TO_CHAR(V_DT_INI,'DD/MM/YYYY HH24:MI:SS')||
             '    Fim : '|| TO_CHAR(V_DT_FIM,'DD/MM/YYYY HH24:MI:SS'));
         UPDATE CONTROLE_FECHAMENTO
            SET OBSERVACAO = TO_CHAR(V_DT_PROCES,'DD/MM/YYYY')
          WHERE PROGRAMA = V_FEC.PROGRAMA;
         COMMIT;
      END LOOP;
      CLOSE FEC;
      COMMIT;
   END IF;
END PRCD_FECVCS;
/
